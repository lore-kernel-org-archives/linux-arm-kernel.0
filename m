Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E5FC1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:19:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE9C2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kjVH4L9H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLOqi8qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE9C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xa6uFEM2yXK8musOBZNufqXLPvgOA96c3QVOohiscKA=; b=kjVH4L9HX+ZRA2
	U7N8kCqMv0rWMMJ3PayxTtHXewVkv13m5Y8jjuEJU3/BSVVuXJGwGwUKfPhXOyVh1rzhqSSa3DmBm
	ot2lpR7rOSte5drjxPzDHCoRzE6Ci4jd+RaziyGnJgEawW6gGWtnmL3RIRQWzd5l+t9G4woa/ApSX
	ZioxJRCdZrG3IddNjLnNtFADN/ZHruBq5G68J65IG+GVcmZQBQ9XwZjoo8BGAuszPHQ6IlYkqFMoh
	VavX8mz0VhNgO8J3rS0fGcsEotzAiyfNJi4mR565wX5OqrCYbJZQO0EWWbgzwUvMf3+0v52UI0o5v
	4T7W4mkT7RGl41mIorvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkbXj-0000xA-Sv; Fri, 18 Jan 2019 21:19:11 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkbXg-0000wX-CP
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 21:19:10 +0000
Received: by mail-ot1-x342.google.com with SMTP id 32so15620053ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r5esMmal+EyiJjppc4XekprtxYgx+syUq4ePbtc3GRY=;
 b=DLOqi8qGJPYy2B9LlOD7twGId6dll2zgIvXdBe+v5IOpB6af94v96wZrlQbHmcKMBy
 HGwwuWDfeOXAYLUhk+mRRBNWfQxih4sp1P15kATLZU655N13CgbZ1w7WOjmbsJY6AlMo
 DX9dvq4Wnhqs6+tuRF2A9L0pPNik1E/ajl/1g0Vx3tBR0ORwBj0vqzoWZC5b/iLxQsRL
 k+BmhzpPdbHcExA9GoiadGa4Og9RnLrnnkTXBUO3sAkGCKs+4bZMFU6WuaHqwu9Uu/xp
 d3jNKOGhp+l2besos3Wcy8dEmQ0o5cJqoMU1bgFddWt4joNO9yIF0z6+6oOYsf5OUZmp
 5/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r5esMmal+EyiJjppc4XekprtxYgx+syUq4ePbtc3GRY=;
 b=GgM+BIaySbsp5Im45eGsEdXD1ow/lJjbjZkfKeHHyXt4cZL5DSslnYCZKidQqPmX4s
 n1V40GgyHghmbfp7EIKt7LAg/ktzhoVl2B8SathLGfYYrrR9SXp/M/bUqX0drHGMBa2g
 eSS1SrYHJRoe/G6vu2FBoUQDmMwMv/DrE4kDx8VYO3+Xw9XsFgefw0Ivy60b/mX9bQpm
 r7cYedDcZ9PzcDvdhFOcaSesXyJHDciXnHklBw04DCpnfnANJdCpUbCd/2RjEQLIHBA2
 hAgfTDvyBQL8F1w3amgMXJjIIDdPPtkpTsCJsgHqO5dsL7rLInIMEODJUcU7ZOOZfr9P
 impA==
X-Gm-Message-State: AJcUukdo8YSeKtp2SGoWq51JE4eAN11XN1e8Va2DxFn3ophWtX7u4xTt
 0vj03Qzb9u9ifLThkl0JhVStyYiLWB6ecaBYQjQ=
X-Google-Smtp-Source: ALg8bN7yEDzZ/ik19/gC/B8WysQYlH9TYZjk95Wutj03C66M7F0hKU3UY5v8rkjW9jyqjmwyCU/rqYBtw/uEUaIsJvY=
X-Received: by 2002:a9d:5d2:: with SMTP id 76mr12517903otd.78.1547846346709;
 Fri, 18 Jan 2019 13:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20190118194812.3319-1-martyn.welch@collabora.com>
 <20190118194812.3319-2-martyn.welch@collabora.com>
In-Reply-To: <20190118194812.3319-2-martyn.welch@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Jan 2019 19:18:55 -0200
Message-ID: <CAOMZO5ASTUDfKkghXq5FftM8-XNztXCYpmdOU9CVfyX3pgKxxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
To: Martyn Welch <martyn.welch@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_131908_450746_37CD790A 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 =?UTF-8?Q?Stefan_Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Christian Hemp <c.hemp@phytec.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martyn,

On Fri, Jan 18, 2019 at 5:49 PM Martyn Welch <martyn.welch@collabora.com> wrote:

> +       /*
> +        * Set the minimum memory size here and
> +        * let the bootloader set the real size.
> +        */
> +       memory {

Need to pass device_type = "memory";

> +               reg = <0x80000000 0x8000000>;
> +       };
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart1>;
> +       status = "okay";
> +};
> +
> +&iomuxc {
> +       pinctrl-names = "default";

Uneeded line.

> +
> +       pinctrl_enet1: enet1grp {
> +&iomuxc {
> +       pinctrl_gpio_keys: gpio_keysgrp {
> +               fsl,pins = <
> +                       MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x79
> +               >;
> +       };
> +
> +       pinctrl_user_leds: user_ledsgrp {
> +               fsl,pins = <
> +                       MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0x79
> +                       MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0x79
> +               >;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> new file mode 100644
> index 000000000000..83cdf4fa10c0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +/dts-v1/;
> +#include "imx6ul-phytec-pcl063.dtsi"
> +#include "imx6ul-phytec-phyboard-segin.dtsi"
> +#include "imx6ul-phytec-peb-eval-01.dtsi"
> +
> +/ {
> +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full Featured";
> +       compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063",
> +                    "fsl,imx6ul";

Better keep it in a single line?

> +&ecspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi3>;
> +       cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +
> +       spidev@0 {
> +               compatible = "spidev";

Doesn't the kernel complain about spidev dts nodes?

> +};
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
> new file mode 100644
> index 000000000000..bccabb84c9f6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + * Author: Christian Hemp <c.hemp@phytec.de>
> + */
> +
> +/ {
> +       model = "Phytec phyBOARD-Segin i.MX6 UltraLite";
> +       compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
> +                    "fsl,imx6ul";

Single line?

> +&i2c1 {
> +       codec: tlv320@18 {

Node names should be generic and label names specific, so:

 tlv320: codec@18

> +               compatible = "ti,tlv320aic3007";
> +               #sound-dai-cells = <0>;
> +               reg = <0x18>;
> +               AVDD-supply = <&reg_sound_3v3>;
> +               IOVDD-supply = <&reg_sound_3v3>;
> +               DRVDD-supply = <&reg_sound_3v3>;
> +               DVDD-supply = <&reg_sound_1v8>;
> +               status = "disabled";
> +       };
> +
> +       stmpe: stmpe@44 {

touchscreen@44

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
