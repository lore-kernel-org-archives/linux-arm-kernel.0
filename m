Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C145C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:16:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D450214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0yPIKsX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k1JUHV/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D450214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d4SSHVhnt7GEHIbA89O15dXrMJS4+u+nxNSfO/FN7LE=; b=L0yPIKsXX8wBB5
	0/4PTSNOQHacEBBZ2T31T5s28VXHqilM98QftkkQFmOYx7KYuKn4/AJ8fjDzO8072kjWoOnEqk+3Y
	MJT8nYzhJm+uQvEFcqKXYn5U125sazKL7pQEnTQc7adKxOtd06RuYs7sx2f1fGndONbUqZIdMcLxc
	7PwwIyzTgSoYa8SZ2KKo02zibw8CRIVmGV0QfzgJD3fkgx8aFvSbtkDHuY6nkoh1Ef+Kb0vd4cmMX
	kwzxmsrPBmL8mNbDt/e1qz+sMsfQyAaqWFuon9Uj8U3iXo28DyrXEt1FjQ2RvK+7AeK1AAIEnHbTN
	AoGvZtojEFD4F7ozY5cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7iD-0002u9-CC; Mon, 28 Jan 2019 14:16:33 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7i9-0002t2-EA
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:16:31 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so18203520wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WFXp9OBXvSFGVcgyvI/Y0RZSKnRdU6of7n7isfHStKw=;
 b=k1JUHV/jGT3gxCIdF5gowaJLo2tiOZhk275u/S4PoAtQ4kI2buQlguy3B3UlybqqND
 xUItBjFSKnnZjVgWxSb9JY90tinZ6WTghJG7+UnwSDWyRZdRqhwNutw0O4w0UPdasBzi
 qFNvgpbuJRfbZsvFTLOpXLSOc2/QMo9VSeuIcw738Vky973TdKcJGQc0CM4F/8yL2cNc
 chGAc8Hdg4Pq0mQZWdYi07ktNeqZ0hj7z9mFwyOzfD6S3vsI5UBfmW8kt76YDA+KQMrA
 UJc9u8Ao+PftmhqKFwllhSRs1eRBoN+bpqDOIm+dx2ZUhZp1db5iAocrV0SWpsi5MmPZ
 IQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WFXp9OBXvSFGVcgyvI/Y0RZSKnRdU6of7n7isfHStKw=;
 b=Y1DtRPwC/lM8HzJGG7pO2whIqVYRDwhJIdJ2rha7twywzuPOfoaK8ET5SARuzourhJ
 hfjy7GqpUsH31/YImBwH/W0oKVJ4ZWJ4OUHRIC7z8/N2jFH4fxT1qWtIo0ON2hAYmwmb
 l3JwZWy6haTfsIwSRlv5mBJPMXYXXok7t47QmFbru3CPI0HODS8NjG31PR38XhYv++vX
 F/rGcR7TJ/5McFsXPXpHDS9Pu6K0tY2RRWcmRciXeydyubn922ijvru5VpyUV/uLxxH3
 YIb4gTUevHsT123X+b7YzRDtqHwhG9nQQv85Xhc5ZEzpBL4muULT2KsrzHeRUaJ+Yilz
 sFlQ==
X-Gm-Message-State: AJcUukcgI0Qdandicddmm97zTkpHOGC6Thi+2XvTdqWgWW45z1OKyzyO
 GCB/WHa0Js25qlFFuEjiCu4vVZWmSGQnNA==
X-Google-Smtp-Source: ALg8bN5Nn1gvT+TK8ScyzBqXr9WeD1aDRHGjnrdGxAqN0AUBZBS50ZafVvOD6mP9IkEeTC8wpWVegg==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr21366756wrs.290.1548684987774; 
 Mon, 28 Jan 2019 06:16:27 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id z206sm90151466wmc.18.2019.01.28.06.16.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 06:16:27 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: meson: add g12a bindings
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>
References: <20190128141330.21927-1-jbrunet@baylibre.com>
 <20190128141330.21927-2-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c5bdc421-1afa-f0d3-65d6-2d062f06267e@baylibre.com>
Date: Mon, 28 Jan 2019 15:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128141330.21927-2-jbrunet@baylibre.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_061629_605232_8805FDB2 
X-CRM114-Status: GOOD (  18.09  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 15:13, Jerome Brunet wrote:
> Add device tree bindings for the reset controller of g12a SoC family.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.txt    |   7 +-
>  .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> index 28ef6c295c76..053cb1322ee3 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
> @@ -5,8 +5,11 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required properties:
> -- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset" or
> -	"amlogic,meson-axg-reset".
> +- compatible: Should be
> + * "amlogic,meson8b-reset" or
> + * "amlogic,meson-gxbb-reset" or
> + * "amlogic,meson-axg-reset" or
> + * "amlogic,meson-g12a-reset"
>  - reg: should contain the register address base
>  - #reset-cells: 1, see below
>  
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> new file mode 100644
> index 000000000000..8063e8314eef
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
> +
> +/*	RESET0					*/
> +#define RESET_HIU			0
> +/*					1	*/
> +#define RESET_DOS			2
> +/*					3-4	*/
> +#define RESET_VIU			5
> +#define RESET_AFIFO			6
> +#define RESET_VID_PLL_DIV		7
> +/*					8-9	*/
> +#define RESET_VENC			10
> +#define RESET_ASSIST			11
> +#define RESET_PCIE_CTRL_A		12
> +#define RESET_VCBUS			13
> +#define RESET_PCIE_PHY			14
> +#define RESET_PCIE_APB			15
> +#define RESET_GIC			16
> +#define RESET_CAPB3_DECODE		17
> +/*					18	*/
> +#define RESET_HDMITX_CAPB3		19
> +#define RESET_DVALIN_CAPB3		20
> +#define RESET_DOS_CAPB3			21
> +/*					22	*/
> +#define RESET_CBUS_CAPB3		23
> +#define RESET_AHB_CNTL			24
> +#define RESET_AHB_DATA			25
> +#define RESET_VCBUS_CLK81		26
> +/*					27-31	*/
> +/*	RESET1					*/
> +/*					32	*/
> +#define RESET_DEMUX			33
> +#define RESET_USB			34
> +#define RESET_DDR			35
> +/*					36	*/
> +#define RESET_BT656			37
> +#define RESET_AHB_SRAM			38
> +/*					39	*/
> +#define RESET_PARSER			40
> +/*					41	*/
> +#define RESET_ISA			42
> +#define RESET_ETHERNET			43
> +#define RESET_SD_EMMC_A			44
> +#define RESET_SD_EMMC_B			45
> +#define RESET_SD_EMMC_C			46
> +/*					47-60 */
> +#define RESET_AUDIO_CODEC		61
> +/*					62-63	*/
> +/*	RESET2					*/
> +/*					64	*/
> +#define RESET_AUDIO			65
> +#define RESET_HDMITX_PHY		66
> +/*					67	*/
> +#define RESET_MIPI_DSI_HOST		68
> +#define RESET_ALOCKER			69
> +#define RESET_GE2D			70
> +#define RESET_PARSER_REG		71
> +#define RESET_PARSER_FETCH		72
> +#define RESET_CTL			73
> +#define RESET_PARSER_TOP		74
> +/*					75-77	*/
> +#define RESET_DVALIN			78
> +#define RESET_HDMITX			79
> +/*					80-95	*/
> +/*	RESET3					*/
> +/*					96-95	*/
> +#define RESET_DEMUX_TOP			105
> +#define RESET_DEMUX_DES_PL		106
> +#define RESET_DEMUX_S2P_0		107
> +#define RESET_DEMUX_S2P_1		108
> +#define RESET_DEMUX_0			109
> +#define RESET_DEMUX_1			110
> +#define RESET_DEMUX_2			111
> +/*					112-127	*/
> +/*	RESET4					*/
> +/*					128-129	*/
> +#define RESET_MIPI_DSI_PHY		130
> +/*					131-132	*/
> +#define RESET_RDMA			133
> +#define RESET_VENCI			134
> +#define RESET_VENCP			135
> +/*					136	*/
> +#define RESET_VDAC			137
> +/*					138-139 */
> +#define RESET_VDI6			140
> +#define RESET_VENCL			141
> +#define RESET_I2C_M1			142
> +#define RESET_I2C_M2			143
> +/*					144-159	*/
> +/*	RESET5					*/
> +/*					160-191	*/
> +/*	RESET6					*/
> +#define RESET_GEN			192
> +#define RESET_SPICC0			193
> +#define RESET_SC			194
> +#define RESET_SANA_3			195
> +#define RESET_I2C_M0			196
> +#define RESET_TS_PLL			197
> +#define RESET_SPICC1			198
> +#define RESET_STREAM			199
> +#define RESET_TS_CPU			200
> +#define RESET_UART0			201
> +#define RESET_UART1_2			202
> +#define RESET_ASYNC0			203
> +#define RESET_ASYNC1			204
> +#define RESET_SPIFC0			205
> +#define RESET_I2C_M3			206
> +/*					207-223	*/
> +/*	RESET7					*/
> +#define RESET_USB_DDR_0			224
> +#define RESET_USB_DDR_1			225
> +#define RESET_USB_DDR_2			226
> +#define RESET_USB_DDR_3			227
> +#define RESET_TS_GPU			228
> +#define RESET_DEVICE_MMC_ARB		229
> +#define RESET_DVALIN_DMC_PIPL		230
> +#define RESET_VID_LOCK			231
> +#define RESET_NIC_DMC_PIPL		232
> +#define RESET_DMC_VPU_PIPL		233
> +#define RESET_GE2D_DMC_PIPL		234
> +#define RESET_HCODEC_DMC_PIPL		235
> +#define RESET_WAVE420_DMC_PIPL		236
> +#define RESET_HEVCF_DMC_PIPL		237
> +/*					238-255	*/
> +
> +#endif
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
