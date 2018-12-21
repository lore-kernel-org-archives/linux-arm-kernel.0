Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:47:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FD2218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0MazblM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgwXJ1As"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FD2218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wv4QqE6JFBU9BmI0WRDiKTNSDfiQK1sCtH7hyhakj8c=; b=G0MazblMphD5MZ
	mHHmOxTN7BCPFFWtaOZiIzWrEkW+s7qWu9Cqy8Dh8eLK+gmeLOrRdancSZprgGup/5q0WaazmoTMB
	9UDXuHjKjQOpaoyJM7f2q4N54lRfGm4qwmRwiIYy+qCxnpToJFBqi6CsDdsJuwGS+VBzLbO6PjPJn
	em4/YOyGvWgwejurysG4b0vbZBH4ojtiQmh1embbiogTjTV6KlOvm2K0p0yi3tiRPPF4y8cL2aOeH
	oDV4ArLh5DMd3HqBfc5l9jWMZ0OWkF+QXzKEIlUdf+0nLiMbt/F26K2FqqpyEJi8dk/VvTQXoB9wD
	Mwm7XOnrAmMUOeyoGkZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGSS-000117-7Y; Fri, 21 Dec 2018 08:47:00 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGSN-0000zQ-Bi; Fri, 21 Dec 2018 08:46:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so2199960pga.9;
 Fri, 21 Dec 2018 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BGxEk3/D6g1MqHex7GlE9IhaxrZrX946np858x37zqI=;
 b=mgwXJ1AsKsltgkW36r5r2eRHHndvtEmFSm3eqkfelo+HKUaIA/40YRb4bi8IyyiD15
 kP81US9EWW3GvWtWNmQQftDRsOwMPwwznDoWcgH/afWMzyA5CrQs0zZi+fmD2IiaeNHR
 jLCPBavNISuCZbZkAdkGOvdPMv5b9kpiadDhsfxbm3jwD8tKs+62QTvrQ/xXZw/rigjc
 Q9CmbaYWqCqIL+V108BU5h6l8BNCO4Vwu7darDdLr/0TO4/ETZUzsYYwAlWnhF3LPv8j
 YiMElMaS18/pZIw6Q+ujaj1cVYt/M2YEJokv0vmF5u8n455NWl2ANtERtWchsc3AnntK
 X52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BGxEk3/D6g1MqHex7GlE9IhaxrZrX946np858x37zqI=;
 b=rC+W0aMMoxo1z+K75TaGbTx3vk8QJG+AKMc+xh1nRdf0euOoxzX/8Y4ia/nXwVraws
 qCTfIVTVxRHwCPLRfGKWVWAb42+1WPpUhzFoewVJVvKpD5ZfpRKknpihAvXy1uUuDByZ
 0L6tKdZnbJgbvVt6LxTj477vhG0N+aoiqZnA3UpT0pWTOASCP78PrF1cGwgUQ+NGr+CU
 Ba3FcZgYXUy21gagwpolY7POBo+sIlEPL+uiDRb36EenF5RYE3+lzrB5aDxONVHWB9x9
 3k8YwaHYuQMV061WZcRSE6iu7MT01+haXPowuz6NbDaED5yxFliKVC3R1acv6D1x+lW0
 nJaw==
X-Gm-Message-State: AJcUukdsgmuKMY7w1ZJlfVyQ7DXI0G2GZuf1WynhtM/oNk/4+LcQPhH3
 omZkj2pVskadvx90eym8kE8=
X-Google-Smtp-Source: ALg8bN6QI0/l/vBK9caNVFvyWfATU4idnxpc45Vay4Fy1qGehGYZnyXrdFXA3JTJogAm7iFQEHMS3w==
X-Received: by 2002:a63:151f:: with SMTP id v31mr1537852pgl.34.1545382003702; 
 Fri, 21 Dec 2018 00:46:43 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id x186sm35197522pfb.59.2018.12.21.00.46.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 00:46:42 -0800 (PST)
Date: Fri, 21 Dec 2018 00:46:40 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181221084640.GI211587@dtor-ws>
References: <20181211093200.18140-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211093200.18140-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_004655_409127_13860385 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
 matthias.bgg@gmail.com, chen.zhong@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 05:32:00PM +0800, YueHaibing wrote:
> alphabetise the header files and remove duplicated include
> file linux/kernel.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
> v2: alphabetise the header files
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1..8e6ebab 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -14,18 +14,17 @@
>   *
>   */
>  
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> -#include <linux/platform_device.h>
>  #include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/regmap.h>
>  #include <linux/mfd/mt6323/registers.h>
> -#include <linux/mfd/mt6397/registers.h>
>  #include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  
>  #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
>  #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> -- 
> 2.7.4
> 
> 

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
