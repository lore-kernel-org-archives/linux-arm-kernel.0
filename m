Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC3C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:05:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A3A21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T1dMd1g3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpWYcu2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A3A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LcpuiUjzbkruiwKov7CXGyxgIJWhagoSaMKz4KGSwDI=; b=T1dMd1g3XAnSJWKQCUsCoCgNZ3
	Ih369K79W9ryAvJ/hDabYx5+flsrrEEyHEqgvDA63Agoe3M+GdDIR0x/Z6rhQ/SW9kPEStFxVScgA
	ByfSaYQvikhKOcip7Qe+wkOPzDI6jiPXCOkRqVaNRqxVjA2G2EE39QAU0Wit5F09kVW5xTKV7tyWI
	YDY9yPJaZjVl6oV/f3XbctBot1QAPy2fqX/tM9ywtN1zicemo4w+Hu2BqEkPigDQpYULg07Bi7vXq
	AmHSWdb6CTsUr6MYdr9SclldD++TpWCK+QekTgFV25cXukG71eYfyX4uBekiVeMq88KgCiCGh4yYU
	83ccws4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goizZ-0004yb-Oz; Wed, 30 Jan 2019 06:04:57 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goizW-0004xo-Hh
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 06:04:55 +0000
Received: by mail-ed1-x542.google.com with SMTP id f23so18026893edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 22:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=aJTjGP6xuRvN5ml+k+nOAP5sZjlzx1oTAMIdkprynv0=;
 b=lpWYcu2O8idu2AvZOES6EGCS7R4zW9JSKzrx9qM1j8xVnuOT6vBc2iqeD9SmfZnl5y
 yU5/U3BhAzV37UBcpsLgX6MWgQJBp/JNKOZqSV/iOsXFa4SHy2uerRdb7Sx3yP4PiCsv
 wL/i9LVhnh0CTokQkNmy4WGalv1r2zg7K+txY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=aJTjGP6xuRvN5ml+k+nOAP5sZjlzx1oTAMIdkprynv0=;
 b=TOyUr3imUz9PrOQTatAJ8IkXHNo8Et27hrrzBtJgKInNQt1AvtDzab2vEEfu3/tr03
 e5eFeLhPaUzJ22Cc26DzIfIf0vVq/piqiuVCwsrbPTHT5g4xOdS6AWlORHaXLG4ZIpZL
 YmliaqHBg6+c0VsHGVE/rII/XqDWj8gBuq48F33mFFKsWTZn1bmFavmgeLOU9wtbeOdD
 JO5qMZEyXlj4kPOF7T053IJ1m+gSN6eUvOJf0Zz8dSJJnHGjFERrF3WanwiYIAtiziHW
 GixIYWbDimzCPHBCXMQ8lSBd2x8KY+5RV8f/FBDFb6jrP0gKtsVffbyAaPott7WySt/J
 xIsQ==
X-Gm-Message-State: AJcUukceHb6NgRmGQ6Rrx9BR63REkDXIl1X5M9a9ypJ4+2Pben1QPQfj
 CKD3xJ8SIhjt/xwUgM1l1rXTBld5HN8glm8fF/h4lQ==
X-Received: by 2002:a50:f5af:: with SMTP id u44mt25022644edm.172.1548828292400; 
 Tue, 29 Jan 2019 22:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20190109055724.184692-1-pihsun@chromium.org>
In-Reply-To: <20190109055724.184692-1-pihsun@chromium.org>
From: Peter Shih <pihsun@chromium.org>
Date: Wed, 30 Jan 2019 14:04:40 +0800
Message-ID: <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_220454_590731_4C6A32D1 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adding Michael Kao to cc list.

On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
> which cause out of bound access with the ->banks[] member. Change it to
> a fixed size array instead.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/thermal/mtk_thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 0691f260f6eabe..ea11edb3fcced6 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -159,6 +159,9 @@
>  #define MT7622_NUM_SENSORS_PER_ZONE    1
>  #define MT7622_TS1     0
>
> +/* The maximum number of banks */
> +#define MAX_NUM_ZONES          8
> +
>  struct mtk_thermal;
>
>  struct thermal_bank_cfg {
> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
>         const int *sensor_mux_values;
>         const int *msr;
>         const int *adcpnp;
> -       struct thermal_bank_cfg bank_data[];
> +       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>  };
>
>  struct mtk_thermal {
> @@ -197,7 +200,7 @@ struct mtk_thermal {
>         s32 vts[MT8173_NUM_SENSORS];
>
>         const struct mtk_thermal_data *conf;
> -       struct mtk_thermal_bank banks[];
> +       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>  };
>
>  /* MT8173 thermal sensor data */
> --
> 2.20.1.97.g81188d93c3-goog
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
