Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B29C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:22:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12BA20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o31wfQY2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwDQUy++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12BA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=92e95CAwewzuk1IspOxJyDIv60ueGosVV1HYtcTMOVI=; b=o31wfQY2gbbKiV
	YHIBZNJlN7JA/+Cv3xSFgwxCYzQIURakSwh+HyWWtgYIY1cj/YYWkny+vp6UUB79/mqbzg3p/bP49
	AxcDi3zQkWGKt0Lrw+60mYMrNHdRIQpPaYS0V2cPAKvolVelgPDgWOxBzc06wjAhOjhZ9BQckNW20
	yl2R6LaDCxyv01LWvEuUtWjPv8yCHxsU3w4awUYrzLTYJMj8ddbsMlDbztanieLE229hd/LvBv14P
	YxQkqWFfikrT/jlsijkCZFo7u+YISbDdikauwbAOWcRhw8Qv8vqMO79KoLlI8QbQRGEEbS/h4AN5h
	VjyknFbHiabcmLU69lXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giqxi-0002yq-3X; Mon, 14 Jan 2019 01:22:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giqxf-0002yU-22
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 01:22:44 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A15A320656;
 Mon, 14 Jan 2019 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547428962;
 bh=i80Wp74W2sOxNuMd/Y86tHazcE3DSqW4UO5JK2XwQuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uwDQUy++UvfFbBhvWfzWsd/gAK9FhDrZtgp0hFMJXvWVgCi6NhPGNEvvCJz5JJ06/
 GvVNW6rSPnRKWlaP7tXr/8MzxO2QFWNasnqa1DdObEB3sZwmXAJhDbyCIv1P2+jNMv
 Rmm5cYPN6g698+hfmIIWLXLiSE0Rysn1OkUz1wTw=
Date: Mon, 14 Jan 2019 09:22:24 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V6 4/4] defconfig: arm64: add imx8qxp support
Message-ID: <20190114012223.GD15371@dragon>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
 <1547206279-26169-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547206279-26169-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_172243_132921_2CE615D6 
X-CRM114-Status: GOOD (  13.41  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:37:37AM +0000, Aisheng Dong wrote:
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Please come up with a proper commit log, as it adds quite a lot of
options.

Shawn

> ---
>  arch/arm64/configs/defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 3ef443c..f0f38dd 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
>  CONFIG_ARCH_MVEBU=y
> +CONFIG_ARCH_MXC=y
>  CONFIG_ARCH_QCOM=y
>  CONFIG_ARCH_RENESAS=y
>  CONFIG_ARCH_R8A774A1=y
> @@ -113,6 +114,8 @@ CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_TI_SCI_PROTOCOL=y
>  CONFIG_EFI_CAPSULE_LOADER=y
> +CONFIG_IMX_SCU=y
> +CONFIG_IMX_SCU_PD=y
>  CONFIG_ACPI=y
>  CONFIG_ACPI_APEI=y
>  CONFIG_ACPI_APEI_GHES=y
> @@ -245,6 +248,7 @@ CONFIG_NET_XGENE=y
>  CONFIG_ATL1C=m
>  CONFIG_MACB=y
>  CONFIG_THUNDER_NIC_PF=y
> +CONFIG_FEC=y
>  CONFIG_HIX5HD2_GMAC=y
>  CONFIG_HNS_DSAF=y
>  CONFIG_HNS_ENET=y
> @@ -326,6 +330,8 @@ CONFIG_SERIAL_QCOM_GENI=y
>  CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
>  CONFIG_SERIAL_XILINX_PS_UART=y
>  CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> +CONFIG_SERIAL_FSL_LPUART=y
> +CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>  CONFIG_SERIAL_MVEBU_UART=y
>  CONFIG_SERIAL_DEV_BUS=y
>  CONFIG_VIRTIO_CONSOLE=y
> @@ -365,6 +371,7 @@ CONFIG_SPI_SPIDEV=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y
> +CONFIG_PINCTRL_IMX8QXP=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_MSM8916=y
>  CONFIG_PINCTRL_MSM8994=y
> @@ -547,6 +554,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_OF_ARASAN=y
>  CONFIG_MMC_SDHCI_OF_ESDHC=y
>  CONFIG_MMC_SDHCI_CADENCE=y
> +CONFIG_MMC_SDHCI_ESDHC_IMX=y
>  CONFIG_MMC_SDHCI_TEGRA=y
>  CONFIG_MMC_SDHCI_F_SDH30=y
>  CONFIG_MMC_MESON_GX=y
> @@ -613,6 +621,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_CLK_QORIQ=y
>  CONFIG_COMMON_CLK_PWM=y
> +CONFIG_CLK_IMX8QXP=y
>  CONFIG_TI_SCI_CLK=y
>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_QCOM_CLK_SMD_RPM=y
> @@ -627,6 +636,7 @@ CONFIG_SDM_GCC_845=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
> +CONFIG_IMX_MBOX=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
>  CONFIG_TI_MESSAGE_MANAGER=y
> -- 
> 2.7.4
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
