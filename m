Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C0C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:29:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C862184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7jMJZJo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCnjD3dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C862184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BaAenfpSdAyXRUZ4xJxnlW/DRSY9T8GdsadksCkewgk=; b=c7jMJZJo2qWUUx
	/F0EDVEdKyVhp5ieLGJWB6u1d2ZwfiKBHVyq6B/FRHqFQI55rR7IiGJBS4MwnA4GLe79d82MxoFKj
	Em05wxZIPlK7M9gthD/pqGz+5hYuUAS1mr5y08zc4M3iiw6mj/AOrNfNIJzH9t/e+zztE3iKUlWic
	uZ/sql4Hoic8Uut2rHZvK3F/5GoYciQ6CFnhVmnfsp5odrOFLypdMkogyCOc5jAByN73H1p+MR6GA
	LgBHwt3OH0m7zNxg6qlX0TWu/1KWnVVKMKZ4+AAVV/qTaxrAB6bnU9Dqcvhvkx4hyRWyF6Uw2Vp2n
	hbT9UEa6zexRxrHBDGQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcQg-0001cs-MZ; Mon, 18 Feb 2019 06:29:26 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcQd-0001ca-94
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:29:24 +0000
Received: by mail-pg1-x541.google.com with SMTP id u9so4401701pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 22:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vMCeLKfnmmzvgnErdQUS+x/DKuvLGfZGkILErkwYP14=;
 b=uCnjD3dldNBtn6PtC0cA2goL7cDjsFujcao4cFptgTph1RcbFQzPce8QuwM1O+ImGp
 Ng2+cYNn8NUoUGW4ZanojgJrt7PjTmp5GuFnNlWK5Pu8FYa7j67OS4UAl4SGaXZDq9Mq
 7fCCsJjeVGdu7m3L3rzMrDYc6fFKL04uArCZPNA7HJHln/KdycudaZMMUQ/t4rIpTrsY
 WsqZdDuG5i+Gc/ctC0fs07Yhuq9KPM9bF4FnwwcK2lW6GRUeKVOatyzTAeKkbebRcmcy
 gwpeWRObT2O5I/uGACY3MEbyqfW32uuufUXIXKJOTM8uUKrIffK3eh0rxTbT7yo13IVc
 H5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vMCeLKfnmmzvgnErdQUS+x/DKuvLGfZGkILErkwYP14=;
 b=iimCuXUyilRGQcBaobPF5fff9QaI6Ly76RwBZH+QE/NzeqHsThFG9gk6s7qtgcfriS
 7YBEHwQALGrRM5pS+V+MFvLDCKKmZI+b3uatZ+djbmiNoW2BMk/zYczu7OAPLlnwJK67
 /w+NjfF+O91JmdfeggUzOiM4fLJ3cIKnfLN9uIR/DHqzbZuU85x76kBjWfNRCCL9+y27
 zbGewQLT8WT3PeeV4VQ4E8nO8gQ7IK04gZYbh4wRlEhmpXWeOz+pJPakZ74NM+XStewg
 aiwrIcBVbEzdeJxuXRK9w8NOAdorI/gkD7V4/VBdrOGBmhOT/FQSsGDPs/kk66IFZQwJ
 kusg==
X-Gm-Message-State: AHQUAuauM4PCHuF73ikNmQgaQBrWW+737qmy5qiDkuppFDgy82lBdjkE
 jgUBNCOtx6/JG05353WR8oL7/Q==
X-Google-Smtp-Source: AHgI3IZ834xZeb2zU8CSHGPmjMAA9/Q89n+AHOlIuxyVGoRN7vTFBMdmBw76W83LcKQKJMBWRtJcuA==
X-Received: by 2002:a63:43c1:: with SMTP id
 q184mr16304950pga.110.1550471362528; 
 Sun, 17 Feb 2019 22:29:22 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id b197sm15104054pga.89.2019.02.17.22.29.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 17 Feb 2019 22:29:21 -0800 (PST)
Date: Mon, 18 Feb 2019 11:59:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] cpufreq: davinci: move configuration to
 include/linux/platform_data
Message-ID: <20190218062919.n3etewl6ln3shr42@vireshk-i7>
References: <20190214170505.27251-1-brgl@bgdev.pl>
 <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
 <979dd2f6-17dd-9569-42fe-9490c09be1bf@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <979dd2f6-17dd-9569-42fe-9490c09be1bf@ti.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_222923_318885_9B9354B0 
X-CRM114-Status: UNSURE (   9.90  )
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
Cc: linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-02-19, 11:56, Sekhar Nori wrote:
> On 18/02/19 11:46 AM, Viresh Kumar wrote:
> > Applied. Thanks.
> 
> Here is a belated ack from my side.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Included that and pushed again :)

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
