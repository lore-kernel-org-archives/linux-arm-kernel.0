Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8A1C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDEF21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJVsX2cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDEF21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+egIYpFJ264avVUd6hnWTBGaio4r1pOALG8ekZMsmuU=; b=rJVsX2cpw5T9zK
	NJNfzOdu+ocqBCr5wFN3jNtPBdBvOIzwvjUVcJiioTH6v2j2+4tXObQzvb2T/GkLj4Ta6kb87qKfx
	QE7XJWGDsahV2W+CeX6TGZ2CpmgjBJJ+CEnEC3r14bWIbnLUSEbOH1RKajeFGlF4cl2qCjkScWOiI
	wkz5JpJtAlf/fCd0FipqTFDqQS5AWg6R8jUtahGNHKixP1eJoiBSr7/MgSsfBzKq4+r/xtLGOr21j
	E28+ZEd+hCYTWaoPpvVzsXsaQUX/jW/RVgtEsMsXPpSe1wCuud3/vwIlcaivgOT1OTmWuRrOJu2jy
	pAwC3WXTbVs+R2rmDL5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gts9v-00040O-FP; Wed, 13 Feb 2019 10:52:55 +0000
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gts9r-0003zm-LC; Wed, 13 Feb 2019 10:52:53 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BB21420006;
 Wed, 13 Feb 2019 10:52:38 +0000 (UTC)
Date: Wed, 13 Feb 2019 11:52:38 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Tudor.Ambarus@microchip.com
Subject: Re: [PATCH 01/11] ARM: at91: add sam9x60 SFR definitions
Message-ID: <20190213105238.GI10129@piout.net>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-2-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025251_990450_17E65CCC 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bbrezillon@kernel.org,
 richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, lee.jones@linaro.org,
 computersforpeace@gmail.com, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/02/2019 08:59:44+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Keep generic names, as there are no conflicts with previous
> SFR definitions.
> 
> While touching bits, update AT91_OHCIICR_USB_SUSPEND to use
> GENMASK, replace unused AT91_OHCIICR_SUSPEND_A/B/C with a more
> generic macro, align values on tab-width.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  include/soc/at91/atmel-sfr.h | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
> index 482337af06b8..532fd784e86c 100644
> --- a/include/soc/at91/atmel-sfr.h
> +++ b/include/soc/at91/atmel-sfr.h
> @@ -14,21 +14,41 @@
>  #define _LINUX_MFD_SYSCON_ATMEL_SFR_H
>  
>  #define AT91_SFR_DDRCFG		0x04	/* DDR Configuration Register */
> +#define AT91_SFR_CCFG_EBICSA	0x04	/* EBI Chip Select Register */
>  /* 0x08 ~ 0x0c: Reserved */
>  #define AT91_SFR_OHCIICR	0x10	/* OHCI INT Configuration Register */
>  #define AT91_SFR_OHCIISR	0x14	/* OHCI INT Status Register */
>  #define AT91_SFR_UTMICKTRIM	0x30	/* UTMI Clock Trimming Register */
> +#define AT91_SFR_UTMISWAP	0x3c	/* UTMI DP/DM Pin Swapping Register */
> +#define AT91_SFR_LS		0x7c	/* Light Sleep Register */
>  #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
> +#define AT91_SFR_WPMR		0xe4	/* Write Protection Mode Register */
>  
>  /* Field definitions */
> -#define AT91_OHCIICR_SUSPEND_A	BIT(8)
> -#define AT91_OHCIICR_SUSPEND_B	BIT(9)
> -#define AT91_OHCIICR_SUSPEND_C	BIT(10)
> +#define AT91_SFR_CCFG_EBI_CSA(cs, val)		((val) << (cs))
> +#define AT91_SFR_CCFG_EBI_DBPUC			BIT(8)
> +#define AT91_SFR_CCFG_EBI_DBPDC			BIT(9)
> +#define AT91_SFR_CCFG_EBI_DRIVE			BIT(17)
> +#define AT91_SFR_CCFG_NFD0_ON_D16		BIT(24)
> +#define AT91_SFR_CCFG_DDR_MP_EN			BIT(25)
>  
> -#define AT91_OHCIICR_USB_SUSPEND	(AT91_OHCIICR_SUSPEND_A | \
> -					 AT91_OHCIICR_SUSPEND_B | \
> -					 AT91_OHCIICR_SUSPEND_C)
> +#define AT91_SFR_OHCIICR_RES(x)			BIT(x)
> +#define AT91_SFR_OHCIICR_ARIE			BIT(4)
> +#define AT91_SFR_OHCIICR_APPSTART		BIT(5)
> +#define AT91_SFR_OHCIICR_USB_SUSP(x)		BIT(8 + (x))
> +#define AT91_SFR_OHCIICR_UDPPUDIS		BIT(23)
> +#define AT91_OHCIICR_USB_SUSPEND		GENMASK(10, 8)
>  
> -#define AT91_UTMICKTRIM_FREQ	GENMASK(1, 0)
> +#define AT91_SFR_OHCIISR_RIS(x)			BIT(x)
> +
> +#define AT91_UTMICKTRIM_FREQ			GENMASK(1, 0)
> +
> +#define AT91_SFR_UTMISWAP_PORT(x)		BIT(x)
> +
> +#define AT91_SFR_LS_VALUE(x)			BIT(x)
> +#define AT91_SFR_LS_MEM_POWER_GATING_ULP1_EN	BIT(16)
> +
> +#define AT91_SFR_WPMR_WPEN			BIT(0)
> +#define AT91_SFR_WPMR_WPKEY_MASK		GENMASK(31, 8)
>  
>  #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */
> -- 
> 2.9.5
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
