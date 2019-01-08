Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05311C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF472146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pNKWKwMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF472146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G+MfEmnp+6g1kneIJz5mjMdA2EgrAHAeitNwH/P7oyU=; b=pNKWKwMbq2nohu
	iUajjG3U2e9pE5rr/UpPSqkv190HeMvEJyq8o/ZxcllCi71O2gWMw6FGrDgmqY0PMyDGup7s4Oy04
	AkmndzH0Eqwfd9A3QtIgXP54Ck/9Cf82bAwIJ9hI5Tg0rCm+q4Gnf3683D+Lc9QHFryKuMmKT663l
	WcXStWGCk79razEJYNYRBFkvLhkm8c+x1KRZi127b9se5fmpdB9k/Ta/I41V8reX6r9+48EQRHu5e
	RnABbHYglpKq+Icqe5x7lffhlCCbN/QkUWKMIj0AVHjqtbta5MVv9uBHwlTHqefKPWUkmE5aF3N6M
	JiPtC6pboO9lCX6J4Pfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh05K-0007NX-0y; Tue, 08 Jan 2019 22:42:58 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh05F-0007Mi-Nd; Tue, 08 Jan 2019 22:42:55 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gh05D-0002aJ-Ed; Tue, 08 Jan 2019 23:42:51 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Fix nanopi4 uSD card detect
Date: Tue, 08 Jan 2019 23:42:50 +0100
Message-ID: <6925511.AQqqGbhmY3@phil>
In-Reply-To: <83098c7ecc471a77dd89564f5f98fcf30c1ed431.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
 <83098c7ecc471a77dd89564f5f98fcf30c1ed431.1546981251.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_144253_920872_BED0A8B5 
X-CRM114-Status: GOOD (  16.37  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, 8. Januar 2019, 22:57:27 CET schrieb Robin Murphy:
> For whatever reason, the sdmmc_dectn function isn't working properly
> as-is, and microSD insertion and removal goes unnoticed. Flipping the
> pin into GPIO mode, however, does do the job, so let's just handle it
> that way for now until someone feels inclined to figure out what GRF
> voodoo or otherwise is needed for correct 'native' operation.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 9c723038d8f8..2a183a6af150 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -505,6 +505,10 @@
>  		sdmmc0_pwr_h: sdmmc0-pwr-h {
>  			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> +
> +		sdmmc0_det_l: sdmmc0-det-l {

alphabetically by node-name please,
aka sdmmc0-det-* should be above sdmmc0-pwr-*

If you're respinning the whole series this should be fixed,
otherwise I can also do that when applying.


Heiko

> +			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
>  	};
>  
>  	sdio-pwrseq {
> @@ -563,9 +567,10 @@
>  	bus-width = <4>;
>  	cap-sd-highspeed;
>  	cap-mmc-highspeed;
> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cd &sdmmc_clk &sdmmc_cmd>;
> +	pinctrl-0 = <&sdmmc_bus4 &sdmmc0_det_l &sdmmc_clk &sdmmc_cmd>;
>  	sd-uhs-sdr104;
>  	vmmc-supply = <&vcc3v0_sd>;
>  	vqmmc-supply = <&vcc_sdio>;
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
