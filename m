Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAAAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:22:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E79720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YzF4FixR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E79720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0nRx+uIZVy6LFxpvyGPIsn+yqzLIFkychJzdpPRIyU0=; b=YzF4FixR4yDrC5
	Phecu2DsafVRCaZovXEChWKtCLDB4wMhCUZdwXgOv4jwIYpbT0ieK6n0s5OkvTGoGZ4VsaAIud7lE
	0sxKj1JH/HSz+3YG2/iBkPaiX2X19ny/e4ZHJdrIP4dCeFDkanaAuj7rV0CEgwjEdJJm2iAR0A+V+
	CKQ3fHtdcUYDteNkhD5XuR6iulURDMxfhqSU6bfRvbLg51Qw7HpGrBUUU0+58scES1sDYCniSMReQ
	pD25rkdZ/Fr2zk+/TU0CK3aUF4kNsZV1L2fTUrinHp7WbhL8HiHugpH3HRvK5ARWlRhIM7+w8BD1Y
	iOShl4ZZEcBmi46X5/uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gg9K0-000760-TZ; Sun, 06 Jan 2019 14:22:36 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gg9Jx-00075K-Dl; Sun, 06 Jan 2019 14:22:35 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 530B72735FE
Message-ID: <50db3bc3faea97182b7fe18b4d9677f7e1563eaa.camel@collabora.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add video codec for rk3399
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Randy Li <ayaka@soulik.info>, linux-rockchip@lists.infradead.org, Tomasz
 Figa <tfiga@chromium.org>
Date: Sun, 06 Jan 2019 11:22:17 -0300
In-Reply-To: <20190105183150.20266-5-ayaka@soulik.info>
References: <20190105183150.20266-1-ayaka@soulik.info>
 <20190105183150.20266-5-ayaka@soulik.info>
Organization: Collabora
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_062233_720832_FD4996B8 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: hverkuil@xs4all.nl, nicolas.dufresne@collabora.com, heiko@sntech.de,
 linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com, myy@miouyouyou.fr,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Randy,

Thanks a lot for this patches. They are really useful
to provide more insight into the VPU hardware.

This change will make the vpu encoder and vpu decoder
completely independent, can they really work in parallel?

Could you provide more details about what is
shared between these devices?

Thanks a lot!

On Sun, 2019-01-06 at 02:31 +0800, Randy Li wrote:
> It offers an example how a full features video codec
> should be configured.
> 
> The original clocks assignment don't look good, if the clocks
> lower than 300MHZ, most of decoing tasks would suffer from
> timeout problem, 500MHZ is also a little high for RK3399
> running in a stable state.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    | 29 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 68 +++++++++++++++++--
>  2 files changed, 90 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> index 946d3589575a..c3db878bae45 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> @@ -632,6 +632,35 @@
>  	dr_mode = "host";
>  };
>  
> +&rkvdec {
> +	status = "okay";
> +};
> +
> +&rkvdec_srv {
> +	status = "okay";
> +};
> +
> +&vdec_mmu {
> +	status = "okay";
> +};
> +
> +&vdpu {
> +	status = "okay";
> +};
> +
> +&vepu {
> +	status = "okay";
> +};
> +
> +&vpu_service {
> +	status = "okay";
> +};
> +
> +&vpu_mmu {
> +	status = "okay";
> +
> +};
> +
>  &vopb {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index b22b2e40422b..5fa3247e7bf0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1242,16 +1242,39 @@
>  		status = "disabled";
>  	};
>  
> -	vpu: video-codec@ff650000 {
> -		compatible = "rockchip,rk3399-vpu";
> -		reg = <0x0 0xff650000 0x0 0x800>;
> -		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>,
> -			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
> -		interrupt-names = "vepu", "vdpu";
> +	vpu_service: vpu-srv {
> +		compatible = "rockchip,mpp-service";
> +		status = "disabled";
> +	};
> +
> +	vepu: vpu-encoder@ff650000 {
> +		compatible = "rockchip,vpu-encoder-v2";
> +		reg = <0x0 0xff650000 0x0 0x400>;
> +		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "irq_enc";
>  		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> -		clock-names = "aclk", "hclk";
> +		clock-names = "aclk_vcodec", "hclk_vcodec";
> +		resets = <&cru SRST_H_VCODEC>, <&cru SRST_A_VCODEC>;
> +		reset-names = "video_h", "video_a";
>  		iommus = <&vpu_mmu>;
>  		power-domains = <&power RK3399_PD_VCODEC>;
> +		rockchip,srv = <&vpu_service>;
> +		status = "disabled";
> +	};
> +
> +	vdpu: vpu-decoder@ff650400 {
> +		compatible = "rockchip,vpu-decoder-v2";
> +		reg = <0x0 0xff650400 0x0 0x400>;
> +		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "irq_dec";
> +		iommus = <&vpu_mmu>;
> +		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
> +		clock-names = "aclk_vcodec", "hclk_vcodec";
> +		resets = <&cru SRST_H_VCODEC>, <&cru SRST_A_VCODEC>;
> +		reset-names = "video_h", "video_a";
> +		power-domains = <&power RK3399_PD_VCODEC>;
> +		rockchip,srv = <&vpu_service>;
> +		status = "disabled";
>  	};
>  
>  	vpu_mmu: iommu@ff650800 {
> @@ -1261,11 +1284,42 @@
>  		interrupt-names = "vpu_mmu";
>  		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
>  		clock-names = "aclk", "iface";
> +		assigned-clocks = <&cru ACLK_VCODEC_PRE>;
> +		assigned-clock-parents = <&cru PLL_GPLL>;
>  		#iommu-cells = <0>;
>  		power-domains = <&power RK3399_PD_VCODEC>;
>  		status = "disabled";
>  	};
>  
> +	rkvdec_srv: rkvdec-srv {
> +		compatible = "rockchip,mpp-service";
> +		status = "disabled";
> +	};
> +
> +	rkvdec: video-decoder@ff660000 {
> +		compatible = "rockchip,video-decoder-v1";
> +		reg = <0x0 0xff660000 0x0 0x400>;
> +		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names = "irq_dec";
> +		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
> +			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
> +		clock-names = "aclk_vcodec", "hclk_vcodec",
> +			      "clk_cabac", "clk_core";
> +		assigned-clocks = <&cru ACLK_VDU_PRE>, <&cru SCLK_VDU_CA>,
> +				  <&cru SCLK_VDU_CORE>;
> +		assigned-clock-parents = <&cru PLL_NPLL>, <&cru PLL_NPLL>,
> +					 <&cru PLL_NPLL>;
> +		resets = <&cru SRST_H_VDU>, <&cru SRST_A_VDU>,
> +			 <&cru SRST_VDU_CORE>, <&cru SRST_VDU_CA>,
> +			 <&cru SRST_A_VDU_NOC>, <&cru SRST_H_VDU_NOC>;
> +		reset-names = "video_h", "video_a", "video_core", "video_cabac",
> +			      "niu_a", "niu_h";
> +		power-domains = <&power RK3399_PD_VDU>;
> +		rockchip,srv = <&rkvdec_srv>;
> +		iommus = <&vdec_mmu>;
> +		status = "disabled";
> +	};
> +
>  	vdec_mmu: iommu@ff660480 {
>  		compatible = "rockchip,iommu";
>  		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
