Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10568C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BDD21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5LKg8ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BDD21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a2P7FFMZkJ2qvLuzlOWZEDiarWN3osFX2aQKfwuAAZI=; b=P5LKg8maQKc18w
	VOggYAYeGkXB8DMaSkn4YjwiwecXBIfnC4ZuP1hoDoHtTWKSH5wMj8b9DB0sJvnzOsYNLXW52m4GW
	JM3o5SgHGK9F7mMW3EqwLEqY7s2vvXSefsfGfGFeTMAV4rPw2MixgUmU3xMTh0TvCNffesuysj5tH
	F05KKW6ZQZbZklNbHATgowT79F6AHVKzEh0BlrwEavQswFTMWrP9tmRIXVhyafzQKzudAuMlGgWvk
	OaPv/onzWToQa8sgK95qhyHJ2ZXwleqw5bzSmub2KEwFVeqRt/WzZVnh6WqK6BCgdIcD81IQSoeS0
	Ns8NNnMVFA/5w7pFrOFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCo6-0008VZ-GZ; Tue, 18 Dec 2018 10:40:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCo3-0008Tt-A9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:40:56 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gZCnj-0002cM-Do; Tue, 18 Dec 2018 11:40:35 +0100
Message-ID: <1545129634.5874.20.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Anson Huang <anson.huang@nxp.com>
Date: Tue, 18 Dec 2018 11:40:34 +0100
In-Reply-To: <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_024055_507691_FE63EF6D 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, den 18.12.2018, 08:24 -0200 schrieb Fabio Estevam:
> Hi Anson,
> 
> On Tue, Dec 18, 2018 at 12:56 AM Anson Huang <anson.huang@nxp.com>
> wrote:
> > 
> > On i.MX8M, some of the bus clocks' rate could be changed in TF-A,
> 
> Do you mean ATF (ARM Trusted Firmware) instead?

TF-A is the name of the day for what was formerly known as ATF...

However I don't think that it's correct to just don't cache the clock
settings. Normally the secure world firmware should not change any
clock settings at runtime, or it would run into all kinds of conflicts
with the clock driver. So there are probably some well known points in
time like a suspend or resume event when the firmware might change
clock settings, so we could instead use those to trigger an explicit
invalidate of the clock caches with much lower overhead.

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
