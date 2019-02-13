Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC6F2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oPxMmD5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC6F2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i8rjge3BD3Q6OuVMdRwasP5JEZ1xPQXMAVI+abIcNf0=; b=oPxMmD5jpj90sI
	H9j2iDZ9qTFgPiVaBDENrAiC/xgZcbFdVcFQFUL2IOC/1ynG+nxoQ1OMwWKhIK7iGFfZ0Q6Smnt/R
	kuobboCl1BWL2XTjcCXa4l05a921bJN6fhY32XzCYRY2qjp8j3BRABTVNoUfia0Kzp9JP0xDCZdWn
	SW1Z25kdTKRSWcBX+TogBE0PM4ws0cQAStSK7xPh09ccDfFOZBbpnsIJXXJfnkWY11qe3hxvq2jDS
	xJk1yPYz8RxE6RiYTLgBHiUEofjSpYojlQPmMo2sNBJ+Qp9jvvtIubH8YJbuj8yTi+LfauIm8T/Ei
	m1/N4LC7HXnQ+JbS/Vng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsBi-0005vg-VF; Wed, 13 Feb 2019 10:54:46 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsBL-0005Ru-QF; Wed, 13 Feb 2019 10:54:27 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id DC4591C0011;
 Wed, 13 Feb 2019 10:54:10 +0000 (UTC)
Date: Wed, 13 Feb 2019 11:54:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Tudor.Ambarus@microchip.com
Subject: Re: [PATCH 04/11] memory: atmel-ebi: add sam9x60 EBI support
Message-ID: <20190213105410.GL10129@piout.net>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-5-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-5-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025424_136916_4BB0A1AD 
X-CRM114-Status: GOOD (  14.21  )
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

On 13/02/2019 08:59:55+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 board defines the CCFG_EBICSA register under SFR,
> and not as a MATRIX register, as previous boards do.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/memory/atmel-ebi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index b45914cfa212..0322df9dc249 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -17,6 +17,7 @@
>  #include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <soc/at91/atmel-sfr.h>
>  
>  struct atmel_ebi_dev_config {
>  	int cs;
> @@ -440,6 +441,15 @@ static const struct atmel_ebi_caps sama5d3_ebi_caps = {
>  	.apply_config = sama5_ebi_apply_config,
>  };
>  
> +static const struct atmel_ebi_caps sam9x60_ebi_caps = {
> +	.available_cs = 0x3f,
> +	.ebi_csa_offs = AT91_SFR_CCFG_EBICSA,
> +	.regmap_name = "microchip,sfr",
> +	.get_config = at91sam9_ebi_get_config,
> +	.xlate_config = atmel_ebi_xslate_smc_config,
> +	.apply_config = at91sam9_ebi_apply_config,
> +};
> +
>  static const struct of_device_id atmel_ebi_id_table[] = {
>  	{
>  		.compatible = "atmel,at91sam9260-ebi",
> @@ -473,6 +483,10 @@ static const struct of_device_id atmel_ebi_id_table[] = {
>  		.compatible = "atmel,sama5d3-ebi",
>  		.data = &sama5d3_ebi_caps,
>  	},
> +	{
> +		.compatible = "microchip,sam9x60-ebi",
> +		.data = &sam9x60_ebi_caps,
> +	},
>  	{ /* sentinel */ }
>  };
>  
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
