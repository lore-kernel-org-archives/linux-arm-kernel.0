Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7019C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:53:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B670A21901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pQdtV8d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B670A21901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8QkiNc3LT5oIoqta8LemTsC51k/ncbanzXepr0Pbc/g=; b=pQdtV8d1yifYSt
	IvfSgf7olmkLie1S4xDH/BK/ybqWJzGRtshI7oA8ELqPUZ6CnUNdHGPvGJBKTUFvs0KOAl0Y2U4BQ
	nw/CPTjK9aDHTS2akFv65rj5MH4BKlPfL6Afc5Iv1pTI1+KALqHO5SeI30yG8Mionq0bISDwLkVBg
	a017g0ESUpd2wM38NuADKJakTF4wCl81dAO2THArNbxdnSOHPrg2k0qz6N8KWNqgPGFfmwR6HOUOl
	BnMwyypCMtbILCiYeYWqInzpVIm1kFrJkzT59pv1bbKcwvDQjUUgie9N3eaOP+at5k4uqNSTlL/zA
	7e8EtctG+A5wTyWFSYQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsAQ-0004V9-Tg; Wed, 13 Feb 2019 10:53:26 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsAK-0004Ss-AC; Wed, 13 Feb 2019 10:53:24 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BEEB21BF20C;
 Wed, 13 Feb 2019 10:53:08 +0000 (UTC)
Date: Wed, 13 Feb 2019 11:53:08 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Tudor.Ambarus@microchip.com
Subject: Re: [PATCH 02/11] memory: atmel-ebi: add generic name for ebi regmap
Message-ID: <20190213105308.GJ10129@piout.net>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213085930.31578-3-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_025320_747004_30C2C60C 
X-CRM114-Status: GOOD (  18.20  )
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

On 13/02/2019 08:59:48+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 board defines the CCFG_EBICSA register under SFR,
> and not as a MATRIX register, as previous boards do. Add a
> more generic name for the EBI regmap as a prerequisite for
> sam9x60 ebi support.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/memory/atmel-ebi.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index c3748b414c27..b45914cfa212 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -36,6 +36,7 @@ struct atmel_ebi_dev {
>  struct atmel_ebi_caps {
>  	unsigned int available_cs;
>  	unsigned int ebi_csa_offs;
> +	const char *regmap_name;
>  	void (*get_config)(struct atmel_ebi_dev *ebid,
>  			   struct atmel_ebi_dev_config *conf);
>  	int (*xlate_config)(struct atmel_ebi_dev *ebid,
> @@ -47,7 +48,7 @@ struct atmel_ebi_caps {
>  
>  struct atmel_ebi {
>  	struct clk *clk;
> -	struct regmap *matrix;
> +	struct regmap *regmap;
>  	struct  {
>  		struct regmap *regmap;
>  		struct clk *clk;
> @@ -357,7 +358,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>  		 * one "atmel,smc-" property is present.
>  		 */
>  		if (ebi->caps->ebi_csa_offs && apply)
> -			regmap_update_bits(ebi->matrix,
> +			regmap_update_bits(ebi->regmap,
>  					   ebi->caps->ebi_csa_offs,
>  					   BIT(cs), 0);
>  
> @@ -372,6 +373,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
>  static const struct atmel_ebi_caps at91sam9260_ebi_caps = {
>  	.available_cs = 0xff,
>  	.ebi_csa_offs = AT91SAM9260_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -380,6 +382,7 @@ static const struct atmel_ebi_caps at91sam9260_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9261_ebi_caps = {
>  	.available_cs = 0xff,
>  	.ebi_csa_offs = AT91SAM9261_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -388,6 +391,7 @@ static const struct atmel_ebi_caps at91sam9261_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9263_ebi0_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI0CSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -396,6 +400,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi0_caps = {
>  static const struct atmel_ebi_caps at91sam9263_ebi1_caps = {
>  	.available_cs = 0x7,
>  	.ebi_csa_offs = AT91SAM9263_MATRIX_EBI1CSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -404,6 +409,7 @@ static const struct atmel_ebi_caps at91sam9263_ebi1_caps = {
>  static const struct atmel_ebi_caps at91sam9rl_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9RL_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -412,6 +418,7 @@ static const struct atmel_ebi_caps at91sam9rl_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9g45_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9G45_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -420,6 +427,7 @@ static const struct atmel_ebi_caps at91sam9g45_ebi_caps = {
>  static const struct atmel_ebi_caps at91sam9x5_ebi_caps = {
>  	.available_cs = 0x3f,
>  	.ebi_csa_offs = AT91SAM9X5_MATRIX_EBICSA,
> +	.regmap_name = "atmel,matrix",
>  	.get_config = at91sam9_ebi_get_config,
>  	.xlate_config = atmel_ebi_xslate_smc_config,
>  	.apply_config = at91sam9_ebi_apply_config,
> @@ -543,13 +551,14 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * The sama5d3 does not provide an EBICSA register and thus does need
> -	 * to access the matrix registers.
> +	 * to access it.
>  	 */
>  	if (ebi->caps->ebi_csa_offs) {
> -		ebi->matrix =
> -			syscon_regmap_lookup_by_phandle(np, "atmel,matrix");
> -		if (IS_ERR(ebi->matrix))
> -			return PTR_ERR(ebi->matrix);
> +		ebi->regmap =
> +			syscon_regmap_lookup_by_phandle(np,
> +							ebi->caps->regmap_name);
> +		if (IS_ERR(ebi->regmap))
> +			return PTR_ERR(ebi->regmap);
>  	}
>  
>  	ret = of_property_read_u32(np, "#address-cells", &val);
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
