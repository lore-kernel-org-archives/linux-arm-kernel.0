Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957372084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f7Ta4nls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957372084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HA07tz2WMCdkMFVNTIwUXlFE+9b5OXPS0fTsiZcrZ0o=; b=f7Ta4nlsIkGzO4
	7C01ng0+ccangdek5rM/NLcnJRU64b99/EvkAnIcHSXR0GlcPu5fZYgg00s4nM+keX9pExh/Tjf0/
	LtOWi1jVJEAGXlK9wotNRz8MLL7mKf2+FRT1rzimnzEJQ38s38aXU7bYmgp6P3Tf9GbZs3qmuGqse
	HImdrKhs1LB5B7Dhl18bxWOVae5MhsAH2URdFDeDVSLcZY9MHjSC8DMXtRMVwZfwIHSo6CKXJk2jY
	A4Ewwp0Kgt0WbRt9TqWod944Z9eOFfhtx4dvo20dasS/RrvkZFLqEMsfOXeIuou8XuGyNH6AUpluO
	YFiA/ON5yMM8JmEJ/WAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8xT-0006Pt-DF; Mon, 11 Feb 2019 10:37:03 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8xQ-0006PT-E7
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:37:01 +0000
Received: from wicke.hi.pengutronix.de ([2001:67c:670:100:2e4d:54ff:fe9d:8eb7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gt8xK-0003fo-7f; Mon, 11 Feb 2019 11:36:54 +0100
Received: from mfe by wicke.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gt8xI-0003Va-Pe; Mon, 11 Feb 2019 11:36:52 +0100
Date: Mon, 11 Feb 2019 11:36:52 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: pfla02: add ksz9031 clock skew values
Message-ID: <20190211103652.hq77ftu56c34zeas@pengutronix.de>
References: <20190204152956.13471-1-m.felsch@pengutronix.de>
 <20190204152956.13471-2-m.felsch@pengutronix.de>
 <20190211023639.GG22487@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211023639.GG22487@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:34:14 up 7 days, 20 min, 1 user, load average: 0.10, 0.19, 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:2e4d:54ff:fe9d:8eb7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_023700_632282_5D227CC4 
X-CRM114-Status: GOOD (  15.91  )
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
Cc: devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, c.hemp@phytec.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On 19-02-11 10:36, Shawn Guo wrote:
> On Mon, Feb 04, 2019 at 04:29:56PM +0100, Marco Felsch wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > The pfla02 SoM has a Micrel KSZ9031RNX ethernet phy connected to the FEC,
> > which needs RX and TX clock skew settings to compensate for differences
> > in line length. The skew values are taken from barebox commit
> > 4c65c20f1071 ("ARM: pfla02: Set new ethernet phy tx timings"), which
> > is based on patches originally provided by Phytec:
> > 
> >     TX_CLK line is approx. 54mm longer than other TX lines which adds
> >     a delay of 0.36ns. RGMII need a delay of min. 1.0ns. This mean we
> >     have to add a delay of 0.64ns. We choose 0.78 to have a little gap.
> >     This can be done by setting GTX pad skew value to 11100
> >     Also add a delay for the RX delay lines, needed for the Duallite
> >     variant.  => Set register 2.8 (RGMII Clock Pad Skew) to 0x039F.
> > 
> > Cc: Christian Hemp <c.hemp@phytec.de>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Applied, thanks.

Thanks, for applying. Just for me, is something wrong with the first
patch?

Regards,
Marco

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
