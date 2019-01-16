Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B369B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KE/NVfxP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8WSX+Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B369B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iWqQN7EUFXtG1D/zXTa0KFiRFhO7I5+C3fgZIyLLoO4=; b=KE/NVfxPIe/XKT
	T3/zHUhUQWllG35E5W+eDo2T9o2620bf0+pOm1ePxL6gEN8MwuMinpeYunJTyKYnic761myHVFGtT
	+U0JKV0/MNMM2Axcmp6DBNYGCcNdYIrU3cHXimjV/4CqgRKUn6m2y7S3biBAsq0peYP4JZfpO6o2S
	xahJ0WEM/IKnF4uC5LkK3nQ7YAercx83DjiHfidx82vdu2o2gGZkHl54TJAJH0UpBsLMzLhf60YlX
	jnWituQkgVfMECnzHmGcses7fs5el1c+uPCJnSa/+CXaWmIqf3bHK9EILKLdJ0NUe3Ifekm7QX7ib
	rNauE38Jy05bkklHFzFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiyA-0003gQ-Aq; Wed, 16 Jan 2019 11:02:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiy2-0003fl-Kb
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:02:48 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28FF620657;
 Wed, 16 Jan 2019 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547636562;
 bh=QLhLCxeA4QZjFn1gUqzDY/Nse0vqxvXw4fNn68EKHiw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n8WSX+Cdw8VtGJigfrwtwCupx9wXHDDituNFtzfWcDsb6XClZc8sWjTLRc0e07bh0
 uZtkSjjxq3dMOP/8dbIh3+UlOmXRZVcj75G9HvZg30x6cg5cgRiphNbheWK9CIbJKe
 ZQFHE6Zh5Oow5hm2d5KaYLGWpkn7BaI0492K5HUg=
Date: Wed, 16 Jan 2019 19:02:17 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
Message-ID: <20190116110216.GN15808@dragon>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB42115D3E98B8B319936AC60E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42115D3E98B8B319936AC60E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_030242_693788_6FD73432 
X-CRM114-Status: GOOD (  15.37  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 05:40:01AM +0000, Aisheng Dong wrote:
> Ping...
> 
> BTW, as the first two patches change the same firmware binding doc fs.scu.txt.
> I'm not sure whether it should go to Shawn's tree for the binding part, or Stephen's clock tree.
> 
> Shawn & Stephen,
> What's your suggestion?

I can apply the first two to my tree as long as Rob and Stephen ack on
them.

Shawn

> 
> Regards
> Dong Aisheng
> 
> > From: Aisheng Dong [mailto:aisheng.dong@nxp.com]
> > Sent: Friday, January 11, 2019 7:56 PM
> > 
> > After a bit more investigation on IMX8QM, it seemed SCU clock can be used in
> > a similar way as IMX8QXP. So update the binding and driver to be a bit generic
> > for easily extension of IMX8QM support later.
> > 
> > Dong Aisheng (4):
> >   dt-bindings: fsl: scu: add fallback compatible string for clock
> >   dt-bindings: fsl: scu: add imx8qm scu clock support
> >   clk: imx: scu: add fallback compatible string support
> >   dt-bindings: imx8-clock: add a53 and a72 clock id
> > 
> >  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
> >  drivers/clk/imx/clk-imx8qxp.c                               | 1 +
> >  include/dt-bindings/clock/imx8-clock.h                      | 6 ++++--
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > --
> > 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
