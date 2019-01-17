Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E998C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EF720652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tl01j9Q7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUQLRnwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EF720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Owdtcy+KuzvHMiV9hMiA17CmCfmzDCczaSgpGmqbNqA=; b=tl01j9Q7wiv0hC
	Tg62f7nMrS4mvz+x4X6o6LH5TmNni3N/S7YSghEQG1EEnaB7WhXfY9xbwdFETt7iOxpOKLS5S39Q+
	42FKtymMuPBqXK/+WMvyBr2g3yONupG6BD0W8sHYTrappyNvFgBRTlCmO6G7aTCw5rQUilekh8tSe
	e183ta4uOSZowRoY2dkieYeVYB22O5v1nplYy+jVjOJqxdNL/9Q3jEFEPwDtlOXbPkLKxql6U+66p
	5E53pci0UJ0vPCrTBrRq4An36roLyfUEQdTTGTPsYse0YjEMQD5CpLjR59gVyqU1UpgS3YdYyvOhC
	j8QSjTTfozz90kspVysg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8xv-0000cl-Au; Thu, 17 Jan 2019 14:48:19 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8xr-0000c2-8z
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:48:16 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so11319673wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 06:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7e3Hc3JsHtEigHMcPcgMXjhVFHPtnc6gQZOtrESjsiQ=;
 b=IUQLRnwE9JYG7n8hBTfVapn0BEp5+urK6cGXOc2S/gPrj9RPS856ZLfTOFW5IOjdDf
 N5zdl55HlnShOLFAxNd5L4YTeRtPWBweQoAENVXJpxWYcD12vykxpK1v3mCS6JOM8ISR
 dt/cicnZUjM569Jx95cjs0Tb8Pcl05fpSTPWsvUJjXO4B5Z2nCcAr8mxbWKSf4/ymXft
 9tsePF46pYC/pAeEnEQs84zP3JfPK5UcgAZbRNi7/8JrWX7zJNZEMQmzTmAXLzD6C/CF
 v8FCVR+05+ifZ3eOpWumc6k2nNYGpg60gyc89+3dzUVCKWqvOeQ5dqBpX6ZG/bYmmMMY
 fJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7e3Hc3JsHtEigHMcPcgMXjhVFHPtnc6gQZOtrESjsiQ=;
 b=D9cLmNkJjvkbqvUUzFEfGWeAen1auYPqgFjxZwCl+YxBkITddxcZHmjWy89PWZV5oV
 sLwDhLWdHY0NZviCsMeYTfd+EBx1avGmAwX5E44Cmgy/WwCNIDJ+CYpTN5drFbk1G+aI
 oFClsffv3RsPiVq7ARIyz8KExfdb1YD0PirCrdlVJFZ0OejbvFQnbBiONUjgLcdt+VqH
 PKv1aW0XF9ZJig7XXiApcNltagCjrkoyQrPHmPe9/0LfO7SrRzFjsF6ERLtHYKA0TBLX
 QJJ6j6EVTfw1wO9gpVvqI/WSyKR0KsVfEf6P8lv7JmhtFLmX3aDL22vSibU/zwlj+ovL
 rDZA==
X-Gm-Message-State: AJcUukesAx+Xtb0CLo6TWK+LhRD2BFlrjsI6brGizBjkEbyX8tF+XvOp
 Gf+4TYdHI0Yf0yFkKdHPwvc=
X-Google-Smtp-Source: ALg8bN56zBJuFhGfeoLAnU/WX3LV5ITzmIITweeHtTZk0zRaK4bWWSbiHZvDv76OAn9B6YcpsWvymw==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr12530433wrc.168.1547736493002; 
 Thu, 17 Jan 2019 06:48:13 -0800 (PST)
Received: from [192.168.1.221] ([195.245.38.234])
 by smtp.gmail.com with ESMTPSA id d2sm70555202wrs.97.2019.01.17.06.48.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 06:48:12 -0800 (PST)
Subject: Re: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>, lukma@denx.de,
 hsweeten@visionengravers.com, linux@armlinux.org.uk,
 Arnd Bergmann <arnd@arndb.de>
References: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
Date: Thu, 17 Jan 2019 15:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_064815_319213_F0C87EDB 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/01/2019 15:37, Brajeswar Ghosh wrote:
> Remove mach/gpio-ep93xx.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Arnd, would you take it into one of your ARM trees?

> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index c6a533699b00..85b74ac943f0 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -26,7 +26,6 @@
>  #include <mach/gpio-ep93xx.h>
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> -#include <mach/gpio-ep93xx.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
