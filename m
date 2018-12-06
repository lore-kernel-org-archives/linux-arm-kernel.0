Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58835C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:14:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19005214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yk2W1HCO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv7FUcUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19005214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UwZwmp25RH+VNL0xu8hZ5HhCxtEFZJzKaho5PKZd1e4=; b=Yk2W1HCOGSB7FR
	oJ9sYQrmy/Q6k2Ll0wueM6JIOolODJRXLzwcDMHqK3xLXJuAcFx9rBBZ+69KvKbYguuyhQ4X6XwkU
	QsD8nNYgRuSsIYcIjSezJxuJGEmJpx1bhQcCa+YDwnLgU6ED8gzGE9icb62YnG9nC/Mpo+JHc5/gK
	+qG6RZJfXrFn7piNIjQOlUMa1ZfzPC0BmSJOdah97Mtl0fA5mlo/eTKyw+81tWL655s/JberRqPV1
	hO0x1saibXv3gqGt+Bghg7NZz1XzIpFrmFMe110DS3mJx+TcXJ566a5b9t1r6s2/iu91DHQP0vMFI
	PjhAvfkf/FOijzxmzfxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUk6w-0004Iz-Mw; Thu, 06 Dec 2018 03:13:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUk6q-0004IN-QJ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:13:57 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CB942082D;
 Thu,  6 Dec 2018 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544066021;
 bh=72ZKv9ZJNFBGE26QmImZmJZ4+Xg1+y6YFlL1n6nKW08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qv7FUcUoLedFO+r2deyNHP/+jcs7FQEnR2tr3vxC5BvAhHOKh2rtO7IWM/H1OnoWt
 c9ok/B4B/SDFLT/DUa88K6u5bAx1GXOAuZHouHasNKRBPsU8ue6T0JhDPfn0zFyQDf
 3ADneGW87sQVeKHFNtpM9TCHiKTRs4kN5Q5tufK0=
Date: Thu, 6 Dec 2018 11:13:02 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Hans Ole Hatzel <hohatzel@jusst.de>
Subject: Re: [PATCH 3/4] ARM: dts: imx7d: sbc imx7: add uart2
Message-ID: <20181206031301.GD3987@dragon>
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-4-hohatzel@jusst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204110741.6943-4-hohatzel@jusst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_191352_904698_69983F09 
X-CRM114-Status: GOOD (  14.63  )
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

On Tue, Dec 04, 2018 at 12:07:40PM +0100, Hans Ole Hatzel wrote:
> Adds uart2 connections as used on the sbc. This uart is connected via
> the soc's pins 3 (TX) and 5 (RX). On the sbc it is pinned out on P4
> using pins 31 (RX) and 33 (TX).
> 
> Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
> Signed-off-by: Julian Scheel <jscheel@jusst.de>
> ---
>  arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 16 ++++++++++++++++
>  arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> index e77e0cc7de39..6c2c844dc052 100644
> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> @@ -214,6 +214,15 @@
>  	status = "okay";
>  };
>  
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	status = "disabled";
> +	fsl;

What is this?

Shawn

> +};
> +
>  &usbotg1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usbotg1>;
> @@ -314,6 +323,13 @@
>  		>;
>  	};
>  
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX		0x79
> +			MX7D_PAD_LCD_CLK__UART2_DCE_RX		0x79
> +		>;
> +	};
> +
>  	pinctrl_usdhc2: usdhc2grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
> diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> index f8a868552707..74904127fbc6 100644
> --- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
> @@ -26,6 +26,10 @@
>  	status = "okay";
>  };
>  
> +&uart2 {
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
