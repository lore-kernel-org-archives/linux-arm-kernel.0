Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E8CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDFE2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rXi0wA1Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="fEeev61H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDFE2190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nqEmE7TzAp7p6/bKszwmKcY9NnVKVe+aSFb0IXTREhw=; b=rXi0wA1QqB2Wbr
	Hkpxg3Hd3xG1/961xEjo8HQUvBsT8Sne2x8YOa+dWgQzpSMppyhMhAIkXcrTS5+6pUOaiPSRpr3kT
	KcMKGxS9tb0fUgCIVk6OegVcsC3MUPOjtLts4ADRwjoGoPa+PhsHgwi6hqhoZ091UVqz3cdQX4Ki1
	h4GwKcvpVmUMPj8L4wr1zPIK3y+f5y1L4mT58qyflDKE4WyxORgclSHvQUZhsuA5highf+5mXviW6
	FIP2arY87XPdyhvUmE1us3f1Zi8Ro23fjFitfAmOddDmYuaP+GwjdDboStWtOU1FJ1Dvn8D9UQyEO
	ffkhMUQUYw111FZrph8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlN2-0004SJ-60; Thu, 07 Feb 2019 15:13:44 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlMy-0004Ry-Vh
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:13:42 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id DE87940354;
 Thu,  7 Feb 2019 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1549552387; bh=tckvz0Scm9xOwUcXteZ8DyWxyS+qroECcDEjDflYUPA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fEeev61HXSNF8Gu0QvIhQcIpoTyuBNmtlgqPgQdbUbHkTNXCXfuwoNKxiIyfovOyg
 CnN0d4AQ+bYVp5GF1PxNCJdoB3LTG9WDoz4fu/FcjV3ynHWrWJ0xu1vXluv2fO6eDo
 MbC0JU7R/W+V/C9GzatyJABT+g6HDhTN7F08UBgeq0LD1BWe66i52NlKS0dDm6NEJZ
 C80mUdN2Zkgfj1TrfqGrl8CMbRetsUW8mSrs7XzLPYbEUONpPjRlyKMcyzojI8gFyx
 tn4lW2LlTxOObcMcvIdrLDL3W9FpSTgkaLzXWv33qDoBoWfntCvERRCLI80pQJw6mT
 liznSxG6Zcehw==
Date: Thu, 7 Feb 2019 15:13:06 +0000
From: Priit Laes <plaes@plaes.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [RFT PATCH 7/9] mfd: axp20x: add USB power supply
 mfd cell to AXP813
Message-ID: <20190207151306.lyjcwyllshwm4o6q@plaes.org>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207064535.9226-8-wens@csie.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_071341_163134_21DE73B2 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 02:45:33PM +0800, Chen-Yu Tsai wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
> 
> The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> supports this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> [wens@csie.org: add commit message]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..17b115845993 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +/* AXP803 and AXP813/AXP818 share the same interrupts */
> +static struct resource axp803_usb_power_supply_resources[] = {

const, if possible?

> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static const struct resource axp22x_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -793,6 +799,11 @@ static const struct mfd_cell axp813_cells[] = {
>  		.of_compatible	= "x-powers,axp813-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp803_usb_power_supply_resources),
> +		.resources	= axp803_usb_power_supply_resources,
> +		.of_compatible	= "x-powers,axp813-usb-power-supply",
>  	},
>  };
>  
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
