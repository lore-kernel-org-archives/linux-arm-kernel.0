Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1612054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ura3bNhE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcyY3yHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1612054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cBkuPXZ4tTiceKqq7Kgfs1ZY774sBrGESpc3gxAA9xU=; b=ura3bNhEWHmMiZ
	kkBe4RkRsIOoACvZPAiQEFDi0wLSZSEgs2cQeu1VegY1K/FjjcOaReLjXJYoTQKur4qXDf3I8lfCF
	DkF3CAMtDCaoBVFIgIIycu/ckjJZYiC+CK4VBymlXDQcTWiT/OgoX3em6UDVePunanLDYPnr2Prg3
	X12gJbw8FMvlgQxerVErxg7IKcZ66WyH3JkRgxirw0j65lbCtUvBgAJ6RDbdOoWEmJ+aVcTsBOtwK
	tpuX0C1NnUvIz2xNroWbUNqMlADG6WzW7YlPx6SI/IMuCsnzO+RJBWCGV9XOSyqrYlzjxnuYLzx0l
	69JuUvFeIkrMZpP7i7Bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4ul-0006g6-Gr; Thu, 17 Jan 2019 10:28:47 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4uh-0006f5-4o
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 10:28:44 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so4265002pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Km1cfzQ/hMEWc3AxHM51l27lTf65fOZ4glWH5feUhpQ=;
 b=EcyY3yHi7zKPCkMMUCAJGiiZXlOHdySISiSNLf4jCs28GiDcMFgqy2/WmsI43jc1hA
 PU6CQ7nzbHuuN9e/ee1jaVaksVBN5o6bzj9xKL2YnsmHnzewzYyyP0CqvD76MYNWsNWo
 X4q5/2bQpnsbQ5oh5O3BGk0/TSFQxF47Pv/kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Km1cfzQ/hMEWc3AxHM51l27lTf65fOZ4glWH5feUhpQ=;
 b=dEyFQaObWsZuY5TSnqbvlKemZSTuTTaWnjsj3XkjcXEIaba7yBE+zdPyICA8mP/cjW
 OsiidOiXnHcgRYloT3aU622sJcgz4veIph7Iorn98HI42XG5tTFGHk4UnsY5bBPC/aOx
 WeeLRip5GE3iWbhSUJt04ZxHAyt78MvcROh2zgX1jt8XMB2CAqkHBfc3FpLSpckeDyft
 eTvEjZOdKc/iShMW4Fy1BQGRq5LzlJp96lc8KNQ5pq1SJRmbHg9J42xTpezvZ3GDuDnK
 398K4+7I7cHe8FhEBkCCKYTAlIxByk6m6Nq+nkg0KkVuExs+hHHTsQMKuqyh1zQVb8rv
 19MQ==
X-Gm-Message-State: AJcUukfCDulbY3+viCi6bQwQfFGAg6bXRP08E9q90kbu+ljawhRniBkW
 MJAcVxrdaUPpq/A3Kkc9uBttvQ==
X-Google-Smtp-Source: ALg8bN5PlbXwykoFB5VP+i/S481hEwUbzpTdF+NiYBsxRhyjum08eIBroMsBp3Juk3jZ0ak4P0DieQ==
X-Received: by 2002:a62:a99:: with SMTP id 25mr14161551pfk.121.1547720922180; 
 Thu, 17 Jan 2019 02:28:42 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id v9sm2394725pfg.144.2019.01.17.02.28.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 02:28:41 -0800 (PST)
Date: Thu, 17 Jan 2019 15:58:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_022843_191795_B48C21FF 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Stephen Boyd <swboyd@chromium.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17-01-19, 11:14, Rafael J. Wysocki wrote:
> Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
> too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
> then, AFAICS.

That works and this is the easiest of the changes to make :)

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
