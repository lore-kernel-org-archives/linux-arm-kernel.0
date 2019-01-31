Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09CEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2762087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPPZCChx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2762087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qPIzaUQruQ2SpDK2ecl8ywVKUSWGDk/Heeavs8aXXY=; b=bPPZCChxlKEKna
	lk/y+dPK39qurNifQ76k+KKG7cVfnEPK+0+fzFcfnhvwdWeWfGxx24ZANBv9vw6GNVWr0tVMWn8IG
	TyDEH98qWQca2nHvrt6oCtOO94CeW2PCCza1bSDDBXf7roYfofh6558u0Q5Mhf7tIf1MP8VeCgJgI
	alLiAPvch60c5mS/Flt0v3MYp/K2waECl+yWdiYHsdBbe6vLgxB9jXQZSliG99FGCOJ//U2mZbCjq
	By9qBoQ+0P5fJdIHprvsGR4l6CKyy6jro1FBIcBS4ccGt77AuODtkFH+idxF6si5ZzWnsrcmnUzDV
	Pc3zzP8uZc+esz+psnNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBX2-000710-AC; Thu, 31 Jan 2019 12:33:24 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBWy-00070X-Nq
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:33:22 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="24062346"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:33:19 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Thu, 31 Jan 2019
 05:33:18 -0700
Date: Thu, 31 Jan 2019 13:33:10 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Message-ID: <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
Mail-Followup-To: Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
 <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_043320_883211_AE4324F7 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 01:29:33PM +0100, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatibles for SAM9X60 pin controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 46443b97d811..5456a2692b8c 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1215,6 +1215,7 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
>  	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
>  	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
>  	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
> +	{ .compatible = "microchip,sam9x60-pictrl", .data = &sam9x60_ops },

Typo s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl

>  	{ /* sentinel */ }
>  };
>  
> @@ -1757,6 +1758,7 @@ static const struct gpio_chip at91_gpio_template = {
>  static const struct of_device_id at91_gpio_of_match[] = {
>  	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
>  	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
> +	{ .compatible = "microchip,sam9x60-gpio", .data = &sam9x60_ops },
>  	{ /* sentinel */ }
>  };
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
