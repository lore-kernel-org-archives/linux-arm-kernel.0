Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6460B218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fAE48PXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6460B218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dRWTr15B3UfLx/hC6FoDmFBfdyXUsYkVrGAlmqrDR/4=; b=fAE48PXGG2OCkQ
	Whu6zKpnIKFW5RfyFoCV1SELZ5zZ1SShFhHcoQ3ycBxVZOE/qyW3aS8JGHtkRvt2V10dhLTWORW1c
	KuQ6nYMW9Y2PJ1Ssa89vlYPlHDMJYg2QPA5NdmVnUaUPYl2hSwPU2C/F/Va7EwZXVsPDhOxzktwwR
	/veZlAlLNZUjRACLxTWpTo/CM1DnU82DCIIT0sS5hoThZCb8yCdsHZeBYFromNB5eS8ONJKYPy7gJ
	0iaCGKTgrf/rtZA0VFmD5Kkffu9VwYdu8pMTfOU5PBh7rOO4Wz1EWXGUDkt+uvBX0Cckq0CdcdNHe
	ytWrOK1ak07v5ncI8RRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFxQ-0003ir-TG; Tue, 18 Dec 2018 14:02:48 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFxO-0003fL-0N
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:02:47 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gZFx6-0002gJ-RI; Tue, 18 Dec 2018 15:02:28 +0100
Message-ID: <1545141748.5874.27.camel@pengutronix.de>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
From: Lucas Stach <l.stach@pengutronix.de>
To: Anson Huang <anson.huang@nxp.com>
Date: Tue, 18 Dec 2018 15:02:28 +0100
In-Reply-To: <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
 ,<1545129634.5874.20.camel@pengutronix.de>
 <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
 ,<1545140504.5874.25.camel@pengutronix.de>
 <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_060246_205483_94CC10FA 
X-CRM114-Status: GOOD (  15.38  )
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
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, den 18.12.2018, 13:53 +0000 schrieb Anson Huang:
[...]
> > 
> > > Regarding about the over head, yes, the change in common composite
> > > clock register has too many over head for other clocks, what if I
> > > ONLY have dram core clock to pass the CLK_GET_RATE_NOCACHE flag to
> > > register the composite clock?
> > 
> > IMHO marking clocks under TF-A control explicitly as nocache would be
> > much more acceptable than doing it for every composite clock. This
> > seems okay for a short term solution.
> > 
> > Still I think that whatever is causing the bus frequency scale to
> > change should have a way to explicitly invalidate the clock cache for
> > the affected clocks eventually.
> 
> It is because the DDR PLL/clocks can only be changed with strict DDR
> freq change flow, and it is done in TF-A, Linux kernel can NOT touch
> it in runtime, so we have to mark the child clock of DDR PLL to be
> uncached, in V2 patch, I will just add the flag for the DDR PLL child
> clocks to be a shorten solution, should be only very few ones, hope
> it is acceptable, thanks.

I fully understand why you are doing the frequency change in TF-A and I
agree with the reasoning to do so. I also think that using uncached for
the few clocks under TF-A control is fine for now.

But if/when the bus frequency scaling is actually implemented for
upstream I think the flow should look something like that:

1. Bus freq scaling driver determines that a change is necessary
2. Scaling driver calls into TF-A to do the change
3. TF-A reconfigures clock rates
4. Scaling driver calls into clock driver to signal that a clock change
might have happened
5. Clock driver invalidates and recalculates cached values for the
affected clocks

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
