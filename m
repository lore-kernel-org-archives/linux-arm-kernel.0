Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A983C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4136620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TjvgxMV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4136620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sYw55oNjbvLquIZLn28ffkgLISIjfF4QP06Np5RslJA=; b=TjvgxMV5oprCM1
	xNN05J+CAZI+HNoq+qn0gu02K5VHZtB32iGLCMfgAnYVi2ydSsId4IlI19f/El4+QsONQ+SLBOaon
	e7c4fBb2Cww5Z7ETHaIs7r+eqvEUkStPYfSIhggoa3ys7jPlYskNRiu6qxBWh4PPRgoQQoLt2+Z5q
	ikyBX7UtFkjOVn1P3vEGm48ERqCDmD8L24r/akg91ISiEqPab4ApTFyB8me1ZdJAN9dkJhLpmyNAN
	Bw8PHK7XW2ahOFd6HwFMYv0YNwaJhYTKnf1rw5ZvOu8vVxdy7bL+W4poc4EDp958uJtcaBXSnMBtw
	joKOv/HUbrGth21ixvsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glts4-0002RB-Td; Tue, 22 Jan 2019 11:05:32 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltrw-0002Pn-BF
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:05:30 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gltrt-0007S5-D8; Tue, 22 Jan 2019 12:05:21 +0100
Message-ID: <1548155121.2465.22.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, Marc Zyngier
 <marc.zyngier@arm.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 22 Jan 2019 12:05:21 +0100
In-Reply-To: <AM0PR04MB421189505D3F196A82DEF19A80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
 <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
 <AM0PR04MB42114D5B25B23C0D7FFF95BA809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <ef6eb38d-8e74-a55d-6d78-516d81fa957f@arm.com>
 <AM0PR04MB421189505D3F196A82DEF19A80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_030524_542855_090ED8F8 
X-CRM114-Status: GOOD (  23.48  )
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
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, den 22.01.2019, 10:56 +0000 schrieb Aisheng Dong:
> > > > From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> > Sent: Friday, January 18, 2019 6:12 PM
> 
> [...]
> > > > > > > > From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> > > > Sent: Friday, January 18, 2019 5:39 PM On 18/01/2019 08:48, Lucas
> > > > Stach wrote:
> > > > > Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> > > > > > Not all 64 interrupts may be used in one group. e.g. most irqsteer
> > > > > > in imx8qxp and imx8qm subsystems supports only 32 interrupts.
> > > > > > 
> > > > > > As the IP integration parameters are Channel number and interrupts
> > > > > > number, let's use fsl,irqs-per-chan to represents how many
> > > > > > interrupts supported by this irqsteer channel.
> > > > > 
> > > > > Sorry, but total NACK. I've got to great lengths with dumping the
> > > > > actually implemented register layout on i.MX8M and AFAICS the IRQs
> > > > > are always managed in groups of 64 IRQs, even if less than that are
> > > > > connected as input IRQs. This is what the actually present register
> > > > > set on i.MX8M tells us.
> > > > 
> > > > Also, I'd really like the DT bindings not to change at every release.
> > > > So whatever change (if any) has to be done for this driver to support
> > > > existing HW, please make sure that the DT bindings are kept as stable as
> > 
> > possible.
> > > > 
> > > 
> > > Sorry I should clarify it a bit.
> > > There's still no users in Devicetree.
> > > So I guess we can update it, right? Or not?
> > 
> > What do you mean by no users? This driver is in 5.0, and I assume people are
> > using it one way or another. Not having a platform in the kernel tree is pretty
> > much irrelevant, as the kernel tree is not a canonical repository of existing
> > platforms.
> > 
> 
> I understand the concern.
> Theoretically yes, but it's very unlikely that there's already an out of tree users
> wants to use it for a long term as we're still at the very initial stage.
> 
> And the most important reason is that current using actually is wrong.
> We can also choose to mark it as 'depreciated' and keep the backward compatibility in driver,
> but I'm not sure whether it's worthy to do it as we may add a lot ugly code in driver
> benefits no users.
> 
> Ideas?

I'm all for doing a breaking DT change now. The binding is
significantly different from the downstream one anyways and I'm not
aware of any upstream users that wouldn't be able to cope with a change
at this point.

I want to reach a conclusion on the discussion about how the HW
actually works and is configured in reply to Patch 4/4 first.

Regards,
Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
