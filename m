Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D7CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6C920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bz1TrFqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6C920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MFGttSrbgBgn4UX8TXDpkZNN98kgS1ANgTVbugrfQo4=; b=bz1TrFqwqupymI
	5/IwrrkYQ4S03v9ieC0KnfspC0wHsCrjDUJmwKxgsn/wZ7Q60TqVE3fSN7n157hwRRTljrjBeSfff
	Y5ZW+luKWHA6isWukcXkZU6F+D1navWY+MQkJLC9qmlAkmmL6SoO2ZIFeWg6tg+qsMoTBmD+tAh0O
	mLkZ/QT5o2G0yAgvuBeN5YmiTeOaVmnEPfZ2houcJvaWjr62AYjKwhoMD/MRh1btnU1DPha4bZ0mt
	0CkmAm5EKA+zG4sN7avazbCToEyYwYzt2ce1pBIBKYMPAGUTyUitwo88UvXvKfYUwSaRZGzdxwrn7
	/M32jSNf5EqIYqNN0IrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKQQ-0006hS-I2; Wed, 06 Feb 2019 10:27:26 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKQF-0006Y6-9L
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:27:16 +0000
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 7402aecc8bb6cdab; Wed, 6 Feb 2019 11:27:10 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sudeep Holla <sudeep.holla@arm.com>, Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Wed, 06 Feb 2019 11:25:57 +0100
Message-ID: <2111013.byp0gTo4u7@aspire.rjw.lan>
In-Reply-To: <20190201114838.GA10042@e107155-lin>
References: <20190201021639.27245-1-josephl@nvidia.com>
 <20190201114838.GA10042@e107155-lin>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_022715_483148_9483E25F 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Friday, February 1, 2019 12:48:38 PM CET Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 10:16:39AM +0800, Joseph Lo wrote:
> > Currently, the DT of the idle states will be parsed first whether it's
> > compatible or not. This could cause a warning message that comes from if
> > the CPU doesn't support identical idle states. E.g. Tegra186 can run
> > with 2 Cortex-A57 and 2 Denver cores with different idle states on
> > different types of these cores.
> > 
> > So fix it by checking the match node earlier, then it can make sure it
> > only goes through the idle states that the CPU supported.
> > 
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> > v2:
> >  * fix it by moving of_match_node earlier, so we don't need to match the
> >    node twice like the v1 did.
> 
> Neat, thanks for the quick patch. FWIW,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Patch applied, thanks!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
