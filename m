Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92582C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596DC214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GkdKajdP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1MOMjGdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596DC214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0wI9wQ9+/Q9Kqr+HOPyogKDOZnSHlEOlEb/JrKqaRTg=; b=GkdKajdPmB8QzQ
	ae2C0a6gOCXbFLVGqrS//7RBHF6Kirj5Oyo6M6AJc6SuZjD8z1CTbkxR1Vho05EvK8JwRWNIQ9fpS
	fjTQCyh6JdPb5fGgGLJnuiCr5nnVmf2jbtP1c507FiuO6Ns/egRv0jPw6sWzKgFnYD+sZ5Q2bHK5g
	nldnTxZoGx6ohsqwqiWfHx97Anm9Qkqtft1bliAZZZOWklhRKxdUuoR8YzX0e9f4OEu+IfBj4WL3b
	dAyqzs7fi/pHa/F8UCQDOVeYrPWJu1sJqJE6X/ZTtrIzQhOdAa5E1CrdOt4HJEZyGXF6pzlU1Qsd5
	fX65473JxBeMAVwxGVnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUk9B-0005tO-A2; Thu, 06 Dec 2018 03:16:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUk95-0005sx-Ch
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:16:15 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A14AD2082D;
 Thu,  6 Dec 2018 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544066161;
 bh=gUWmpPYRaqzu5r1Ab/DCdgbWnfFmy3O6cIJ3GlVDyBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1MOMjGdiSL46Z2JOtd/+0BWDwA58W3S9XkZaFDdC+FbQ609wcg9IoeaZ7KOzsa34U
 SvayxP2iemmIpus47zWXFBpcEuPNEUmMJHo/CIJotHAckatBLdn70Wuol+Iq3KIkgk
 U9H05M8wZoDP+vUw9LiVh6J9keF8l3zgYl1fsNBk=
Date: Thu, 6 Dec 2018 11:15:21 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Hans Ole Hatzel <hohatzel@jusst.de>
Subject: Re: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
Message-ID: <20181206031520.GE3987@dragon>
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-5-hohatzel@jusst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204110741.6943-5-hohatzel@jusst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_191611_498793_3FE445D5 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: devicetree@vger.kernel.org, Julian Scheel <jscheel@jusst.de>,
 linux-arm-kernel@lists.infradead.org, fabio.estevam@nxp.com,
 ilya@compulab.co.il, linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 12:07:41PM +0100, Hans Ole Hatzel wrote:
> Adds uart5 connections as used on the sbc.
> In the sbc's reference material this is known as uart1, it does however
> connect to the som as uart5. This uart is connected via the soc's
> pins 11 (TX) and 13 (RX). On the sbc it is pinned out on P5
> using pins 15 (TX) and 17 (RX).
> 
> Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
> Signed-off-by: Julian Scheel <jscheel@jusst.de>
> ---
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 16 ++++++++++++++++
>  arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> index 6c2c844dc052..f7c002093c67 100644
> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> @@ -223,6 +223,15 @@
>  	fsl;
>  };
>  
> +&uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;

Can we have some comments in the commit log on why we have to use this
particular clock source? 

Shawn

> +	status = "okay";
> +	fsl;
> +};
> +
>  &usbotg1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbotg1>;
> @@ -330,6 +339,13 @@
>  		>;
>  	};
>  
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
> +			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
> +		>;
> +	};
> +
>  	pinctrl_usdhc2: usdhc2grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
> diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> index 74904127fbc6..d23d62aceb82 100644
> --- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> @@ -30,6 +30,10 @@
>  	status = "okay";
>  };
>  
> +&uart5 {
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
> -- 
> 2.19.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
