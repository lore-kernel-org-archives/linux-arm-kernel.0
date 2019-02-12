Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2774C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FF02083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YhUSJSH+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pSl3zbne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FF02083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YDiSnvgCRrCemNHnfxZVHvtZ5jqnpAvkc9VKtDd8o6A=; b=YhUSJSH+wIvHlh
	/wu5JCAz4q97nwCkXzEhDrZ90WRhyfP1vdUQgK5T5SMyDJ8njigMMR7wdfLstbGAS66obWs1OGZiD
	lrV8k/cv/8B9+Y8G5u4nxyiWE9Ac3zPrKWa7mzYshs0lIdoYZTG3c57AkvbMik0TwvF6T32GK3CZ8
	C624hzuQ6EWVUspSRsGoNeUlihMTKrEa9hAjr4jms8uLv+cXm0XShwtIroLCNn8Sboyhn/vq/uW4a
	R3VoxvJD/p/sO+nGAOUd10ZXuZyMB4Uh4r5QJipSO8i3i/CxcVJ8ShmNi/dK5yRw6sjfp+Iphuvh7
	9fQDcsFnPo4hxDNiwkUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZHD-0003mM-DB; Tue, 12 Feb 2019 14:43:11 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZH8-0003kr-Rq
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:43:08 +0000
Received: by mail-wm1-x344.google.com with SMTP id m1so3248812wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=ZUy0VCT1WuGXUG1KTNtWcsxFWdFXTWKSDbOTngrZcLA=;
 b=pSl3zbne4W+iYHTH/1UEv8dQigHTIrlQKSWlB+wcwUo1j7DDzFS4nHlCbmqPMSgUhq
 Lpt+B6jdgBlgyz2bXqcnse+XbxYmBSWdV039c5Kt+6KJcGCduiccf9vrtmHD3hDbGOJd
 fBPShB9QVyu18wD7dQW0pCRlsS+5ZWTDU+jc7E4ixXpLicp3+BN66cET0P32RIlEIUzn
 HJfDZnpl2qz+VSo7zLm5LvdVhTjLdI1BxYYHzekOAmKRdu9DVZf6VyA6ILuxJ/d8KD/5
 kOqc94+TY8oVn1ovW+8exY9572Ju6As+CWegMag95Ws9akJ3B++j4OjzB3fGqsnJk+um
 HCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=ZUy0VCT1WuGXUG1KTNtWcsxFWdFXTWKSDbOTngrZcLA=;
 b=gLRpgq53Ick50WtkAGBeWeonNh6RcETX55VGpCLxzxpyo803tlChbec0nFh/pIaG8f
 AjWhcB0kOtrhW0vrkohjc6h4J3rn4VlDJCcMhswOYYu4vjiXPMevO35G/W4ouiI4+BVm
 yUr78OSeTJJmZlMRQYL0cA0PLNkiWuiNibPZ8nkCHIRENiYFfEBuuhXeWz+6AtjDJH0m
 S7PTt/o2As0AJIgL1X0K+SANymJdubBWTWVxGCtjqtaiC02KCR1n5ke4t8djMrTbiOtX
 agzTPzL6kd6UitBdZq4HQTVcBbXjGpAh8JUF7USjuePGULiQVHQzAjh08oIOVBvqGwqF
 bKtg==
X-Gm-Message-State: AHQUAuYvfxBWy7Qo7H+f+VZOvke7tF7tlXeG6XdecRIrF59bMZgK/VDZ
 8mBg56Od5P4nx8qWKCB/0N9QXP0zZE0=
X-Google-Smtp-Source: AHgI3IbuPmVopWs3+dKFaWZNzP7k1eAL4Y4UJqGV0lgkEf5b9kk8sUNznwx/d7GxtOfT8shboocq0g==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr2972336wmj.130.1549982583020; 
 Tue, 12 Feb 2019 06:43:03 -0800 (PST)
Received: from boomer.baylibre.com
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id e9sm25037122wrc.56.2019.02.12.06.43.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 12 Feb 2019 06:43:02 -0800 (PST)
Message-ID: <a2475cc2b0de8a13bc103ef6f4157a4a569c4a6c.camel@baylibre.com>
Subject: Re: [PATCH 2/3] soc: amlogic: gx-socinfo: Add new SoC IDs and
 Packages IDs
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Date: Tue, 12 Feb 2019 15:43:01 +0100
In-Reply-To: <20190212142344.13634-3-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
 <20190212142344.13634-3-narmstrong@baylibre.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_064306_941588_76C8CAA7 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-12 at 15:23 +0100, Neil Armstrong wrote:
> This adds the G12A and G12B SoC ids and the S90X2 package ID.
                                                ^   
Small typo here --------------------------------|

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c
> b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 1ae339f5eadb..c1a9c34d861b 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -37,6 +37,8 @@ static const struct meson_gx_soc_id {
>  	{ "AXG", 0x25 },
>  	{ "GXLX", 0x26 },
>  	{ "TXHD", 0x27 },
> +	{ "G12A", 0x28 },
> +	{ "G12B", 0x29 },
>  };
>  
>  static const struct meson_gx_package_id {
> @@ -53,11 +55,14 @@ static const struct meson_gx_package_id {
>  	{ "S905W", 0x21, 0xa0, 0xf0 },
>  	{ "S905L", 0x21, 0xc0, 0xf0 },
>  	{ "S905M2", 0x21, 0xe0, 0xf0 },
> +	{ "S805X", 0x21, 0x30, 0xf0 },
> +	{ "S805Y", 0x21, 0xb0, 0xf0 },
>  	{ "S912", 0x22, 0, 0x0 }, /* Only S912 is known for GXM */
>  	{ "962X", 0x24, 0x10, 0xf0 },
>  	{ "962E", 0x24, 0x20, 0xf0 },
>  	{ "A113X", 0x25, 0x37, 0xff },
>  	{ "A113D", 0x25, 0x22, 0xff },
> +	{ "S905X2", 0x28, 0x40, 0xf0 },
>  };
>  
>  static inline unsigned int socinfo_to_major(u32 socinfo)



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
