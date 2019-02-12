Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C524DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:15:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946012081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DF1b3ITi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946012081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tWSJf8uwNwC6jljF+naHjaox6nms92+WbbFWP1ldie8=; b=DF1b3ITif2Zaks
	QdFnU+15nQ+80axdL1oFFZeMYBi6cSpvsHssbVkJ+FA8sbeqZ5WsoNZUHqWz8quUlawvCcqgPbo8Q
	WBsqlIXy0I/1Cv7i8RcOjxNEUq3wwgG9T4yqVcHgU6ga81/PetX1ENUXNVOlq0yeu1xBHEmhHUtp/
	01kZ6L1CEN1+SJ9xxSAxVBPTYAbU/nVNi/ucYT0hxGSo1gUtKUfkijsqpCtM44gYYI7tQrq0QQLQ7
	rRWHco0JmAcNq+morLaOm8SK1ZNoCNmtenVmHgu7xDDIrlRNAYwigXIAKs5UvOAhvAP3c0PkHkTKi
	W0YSRxCC9IbrhaDU7WYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTEQ-0004do-0D; Tue, 12 Feb 2019 08:15:54 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTEM-0004dQ-TK
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:15:52 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gtTEI-0004gw-DS; Tue, 12 Feb 2019 09:15:46 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gtTEH-00080Q-QO; Tue, 12 Feb 2019 09:15:45 +0100
Date: Tue, 12 Feb 2019 09:15:45 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 04/15] ARM: dts: imx6qdl-phytec-pbab01/pfla02: Use
 explicit swpad values
Message-ID: <20190212081545.z2dwoddnm2idsvne@pengutronix.de>
References: <20190211141333.28725-1-u.kleine-koenig@pengutronix.de>
 <20190211141333.28725-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211141333.28725-4-u.kleine-koenig@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:59:16 up 24 days, 12:41, 31 users,  load average: 0.12, 0.04, 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_001551_106780_621B86C8 
X-CRM114-Status: GOOD (  16.74  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Uwe,

On 19-02-11 15:13, Uwe Kleine-K=F6nig wrote:
> Instead of relying on reset defaults or a bootloader to configure
> use explicit values for the swpad configuration. Here the reset
> defaults of the i.MX6dl are used owing to lack of other evidence. (They
> differ from the i.MX6q defaults for GPIO_0 and KEY_ROW4.)

Rely on the reset/bootloader values isn't that good at all. Since the
bootloader use case can be different. I've checked your patch against a
vanilla barebox (bootloader) which includes this devicetree. My test
setup was a imx6q pfla02 SoM and a pbab01 baseboard. Please look my
comment below.

> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot=
/dts/imx6qdl-phytec-pfla02.dtsi
> index 1b50b01e9bac..8e04ab7df2d7 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
> @@ -211,11 +211,11 @@
>  	imx6q-phytec-pfla02 {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins =3D <
> -				MX6QDL_PAD_EIM_D23__GPIO3_IO23 0x80000000
> -				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
> -				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09  0x80000000 /* PMIC interrupt */
> -				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x80000000 /* Green LED */
> -				MX6QDL_PAD_EIM_EB3__GPIO2_IO31 0x80000000 /* Red LED */
> +				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x1b0b0
> +				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x1b0b0 /* SPI NOR chipselect */
> +				MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x1b0b0 /* PMIC interrupt */
> +				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0 /* Green LED */
> +				MX6QDL_PAD_EIM_EB3__GPIO2_IO31		0x1b0b1 /* Red LED */

Don't wanna nitpick, the MX6QDL_PAD_EIM_EB3__GPIO2_IO31 pad should be
configured to 0x1b0b0 too, but I don't know the default imx6dl
behaviour as you mentioned above. So I'm fine with the patch.

Acked-by: Marco Felsch <m.felsch@pengutronix.de>

>  			>;
>  		};
>  =

> @@ -299,7 +299,7 @@
>  		};
>  =

>  		pinctrl_pcie: pciegrp {
> -			fsl,pins =3D <MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000>;
> +			fsl,pins =3D <MX6QDL_PAD_DI0_PIN15__GPIO4_IO17	0x1b0b0>;
>  		};
>  =

>  		pinctrl_uart3: uart3grp {
> @@ -320,7 +320,7 @@
>  =

>  		pinctrl_usbh1: usbh1grp {
>  			fsl,pins =3D <
> -				MX6QDL_PAD_GPIO_0__USB_H1_PWR		0x80000000
> +				MX6QDL_PAD_GPIO_0__USB_H1_PWR		0x130b0
>  			>;
>  		};
>  =

> @@ -328,7 +328,7 @@
>  			fsl,pins =3D <
>  				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
>  				MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
> -				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
> +				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0
>  			>;
>  		};
>  =

> @@ -356,8 +356,8 @@
>  =

>  		pinctrl_usdhc3_cdwp: usdhc3cdwp {
>  			fsl,pins =3D <
> -				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x80000000
> -				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
> +				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1b0b0
> +				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0
>  			>;
>  		};
>  =

> -- =

> 2.20.1
> =

> =

> =


-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
