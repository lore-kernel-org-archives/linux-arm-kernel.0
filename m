Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E863A2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPXCbi9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E863A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r344bP/Qs4UNvrwpnaieAwVr/rCOyv5PKUYVsvKyRII=; b=jPXCbi9Pv17eHk
	6qEXcOnuNC1ZjYUVu8vBmeOW69M99IWevgbQYMESw0Ss5gIqicbbqSfHMNXN5aoVL63Oa5Zvlay9g
	KsasI518UbcPAiXKpHBo9eIqn+1wuwimJDgmVUJjEW+QUPfLU0jLyXy8Cmx3+spXUpmvLCnIO+OXz
	PvB7RMa18D3bRf+miLwrlPbxj6Y2FfhXREKnT8w1+/A79CKB7iuDvusQWKe0EpSfVnvz6p1lKXqIo
	ckfsWZGqGKZFOFUxIO4AGk1YsSH+RLfM/NKH1XWqwnirtGUczxpnmU9zxMNQ124gpCT7lXnJQyOCs
	EEFHNLdEhSdLyqvlpExg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4xN-0000Ax-6e; Thu, 17 Jan 2019 10:31:29 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4xJ-0000AX-Ae; Thu, 17 Jan 2019 10:31:26 +0000
Received: by mail-oi1-f193.google.com with SMTP id x23so5761773oix.3;
 Thu, 17 Jan 2019 02:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xGd1GzfRXCa7LnA5V4FSlo4bq5QGELGlvjfZTifFP3o=;
 b=kbnZBwqTLmjl7Gk1av5QsY/OOoK2w6bUSCqxW2z/Qdc0XI36hOZLhigtflOWgm8g5d
 jCNe3nTP+UkBX923RGu3Nfrf+F8YGHJuBtuv62vN/+9XaDgJSgFtWpbGTgzNmO91snH2
 DIW0nIm049u35pPaWdhhqX5VPxd0LGrTo1DoyKCCKbtKx/m31I6VtAM8gzeliEcYDqVt
 NZKVrr1i8g53ECajrFAgzq2TFui6IZfGSa4JhJoLLUJSzEzGvaVGaqhnPZo6X9+ents8
 s+bH29rQz5GCwIIKnXTcslGJCM3js6js5eJLIv/Z0LqaAWNkCbQ5fgmc33Z18DYWFR/n
 7R3Q==
X-Gm-Message-State: AJcUukcbtC1RQp9vCSPSxNyaflFcqE7phtwd9sOMMUvDdss9J1/IxHFd
 HtIfdLXoaXSzic3++eXNrGR4a9BdSp64zCq5uO8=
X-Google-Smtp-Source: ALg8bN5c+rJ4uszRgZIkgs0ZQrcYAyuaAq4DqfJERAZoa1JIDIazitANO042tZMiEHKxbZPZLW3KRG6JMQ6hCLhxy00=
X-Received: by 2002:aca:e715:: with SMTP id e21mr7418405oih.76.1547721084580; 
 Thu, 17 Jan 2019 02:31:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
 <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
In-Reply-To: <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jan 2019 11:31:13 +0100
Message-ID: <CAJZ5v0idoGcc-j1kZVjsNE9Z76xzN1xe0bb=AW-JFcL0ZjfyMg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_023125_408667_729D6DFE 
X-CRM114-Status: UNSURE (   7.81  )
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
Cc: Doug Anderson <dianders@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
 Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 11:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 11:14, Rafael J. Wysocki wrote:
> > Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
> > too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
> > then, AFAICS.
>
> That works and this is the easiest of the changes to make :)

Let's do that, then, I think.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
