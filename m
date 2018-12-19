Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9719C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:52:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC2B2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSq9raWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC2B2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lWKt3dkPzPkyQc6Mr2ZU5ovQrH3lgkOKPS98UPB/gTU=; b=MSq9raWgCP1NaW
	IZEoJh5IIlOhSpFC5fTGh/NZt7mBz6Nh25wtcLbZeAbkgr3F2iHs1ACB2IIXletPzqB0swUHO2mpl
	3DyfUXp37ci3DuMAxrL9AL4nGrOeMOI7YDKbar/ohJD6MY6R0vqTkWADfRL3x7/iIkMQEz7j7gGPv
	S8Na+YkV7kCFh+7IScKODmFylETj+FRVrwSduNrEvOUEaIhpa3CfxYQmboDUzQWZnoMCROeehRR8q
	iByXlNnkIn7WN3xAvNujdwH5jFrg2QOCis417FmCA3i6ZKBFAy6vmsEuyCls/2LhnmmoIxwv2HqCv
	Kv3r3RdhcILZ1t3vEI9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZXaR-00015V-7B; Wed, 19 Dec 2018 08:52:15 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZXaN-00014X-CM
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 08:52:13 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gZXa9-0002xp-9j; Wed, 19 Dec 2018 09:51:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gZXa8-0008Ri-JT; Wed, 19 Dec 2018 09:51:56 +0100
Date: Wed, 19 Dec 2018 09:51:56 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sl: correct PWM ipg clock source
Message-ID: <20181219085156.2o5xxrodrqrc62ba@pengutronix.de>
References: <1545197799-9082-1-git-send-email-Anson.Huang@nxp.com>
 <20181219083640.42jmibqzn2t3i4t2@pengutronix.de>
 <DB3PR0402MB39160D8B04AE55D1E2829067F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39160D8B04AE55D1E2829067F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_005211_583001_51BF93FA 
X-CRM114-Status: GOOD (  17.77  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Wed, Dec 19, 2018 at 08:44:13AM +0000, Anson Huang wrote:
> i.MX6SL current setting has no issue, because the ipg_clk_s is from percl=
k which is always
> ON, but it does NOT match the clock info in reference manual, while other=
 i.MX6 SoCs
> are having correct clock settings for PWM IPG clock. =

> =

> It is just an improvement, NOT fix a real problem.

OK, so it's merge window material as I expected.
 =

> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> > > b/arch/arm/boot/dts/imx6sl.dtsi index e7524e7..4b4813f 100644
> > > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > > @@ -338,7 +338,7 @@
> > >  				compatible =3D "fsl,imx6sl-pwm", "fsl,imx27-pwm";
> > >  				reg =3D <0x02080000 0x4000>;
> > >  				interrupts =3D <0 83 IRQ_TYPE_LEVEL_HIGH>;
> > > -				clocks =3D <&clks IMX6SL_CLK_PWM1>,
> > > +				clocks =3D <&clks IMX6SL_CLK_PERCLK>,
> > >  					 <&clks IMX6SL_CLK_PWM1>;
> > >  				clock-names =3D "ipg", "per";
> > =

> > It's a bit irritating that IMX6SL_CLK_PERCLK is used for the "ipg" clk,=
 not the
> > "per" clk. Is this correct?
> =

> Yes, you can check the i.MX6SL CCM chapter for PWM clocks, the ipg_clk_s
> is from perclk and its enabled control is VCC which is always ON. The "pe=
r"
> clock is for PWM function, NOT register access, I tried disabling the PWM=
 per clock,
> PWM registers still can be accessed.

OK, then Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> > Industrial Linux Solutions                 |
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> > pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C7bf
> > fc7bad61545fb595508d6658d1d0f%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C636808054141733417&amp;sdata=3DdDv2spIwbQmkpu7mhEm
> > 8bRHyKKviSO%2BQ33ZU7nD1bJQ%3D&amp;reserved=3D0  |

haha, something between you and me mangles links. I bet it's on your
side.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
