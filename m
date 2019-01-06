Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9257C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:59:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875E9206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vDsqnHqX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWtMOrP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875E9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ekjYnxYj0vP4neiP3BLvV6Oog/EZkZlU0qJveoYjOY=; b=vDsqnHqXazX45R
	cBhprVOkXSEyLLTLZyj+dq2Y/2wB/AWCAs0bFe55HF0LWx7Y/IHIsF8AMnlWr9/Gs6jkMRC+o3i72
	FUumoXWAUv04GQZboKNzesx7y7Awi21Um5fc5ndKxPz9xVQiJOXGGUQhLJSehGyvMd3LvyuDtTnPo
	ltK0NgG8Wtf1uqoF4BJQ9wgzHRXwGqoyf6GFXZrdiIu+ENBvRj6kiBux3T5vnGLtFvrwjUxt/C+ZA
	wdsVahNED7S1KFNx3rpwLGFRIzm0xaLGJ1w6wln8LYPWG34n4po3L1W2K8CfHq3G1V9dqZciTKvcD
	ffFlqD6yOTfBYllph0Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gg75B-0002lN-34; Sun, 06 Jan 2019 11:59:09 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gg74v-0001ib-WF; Sun, 06 Jan 2019 11:58:56 +0000
Received: by mail-lf1-x143.google.com with SMTP id p6so28310501lfc.1;
 Sun, 06 Jan 2019 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T1YVVh/H4ZXqJKR4EyzOpe1vykPXUi/qY2yUy/s572s=;
 b=kWtMOrP19wga2FhOmAG3U4WSJ68TM7MKVbbQg0nBEnT9WPRLnDdnA04ch092bg9mBe
 r4jSXIAjVJcazDW1g4TovfmCVYD7PNFGbjYmBuUEU8kMt7lmsxh+NKe+zY5XyYyysPV8
 1vvj88ZfigvkqtBGOKV13N6djMbUwPuUjAxF8/XMbNeYiEzPNzMt0V6OovcBUQYtMlGB
 Yx6gDvx73uy4LBl9MdwuQcE3NeVu6K6JTSbhgOA55iTThX1PqyXgAuoh/CN6jcTHOv38
 jQn2GZ6PzRe6h9d/5bo35JOV59CgKBVLv34Ujx+XQCvElzbLZxDY9J1ftaNEVhLcxNbu
 CMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T1YVVh/H4ZXqJKR4EyzOpe1vykPXUi/qY2yUy/s572s=;
 b=c2Z6SJ3/jOhgWZy1YqlnXv2z4zkAn/wX3SW+AtHoUUI3nUzs2gtR/CdSuT+IdFBgR4
 6xCqtfUL8aOhC5bgXIpbSUu+qxt1/GLsA9LDF4luWdP++KeUQLE5k6hO6bv/wp3EkOoC
 uPq0HokBQoYU3zoUyRv0wzfV/7lxtCmbvxtf/xnlkjqVaPu9PYbouO4XSxBDrSgV+AVL
 yEBLlueaEoN1zlpgpMw9ah8J23TrxrU9hD+g0R6bnxSi+nYCHnXjpq9lxmCqwklu4OdA
 3WOxZuLZmae3g0CDEw9uepX5+2bPo3F/7Js5Hd4FpIYrMwn3/rFWmhWP9vd28N621a/H
 DiDw==
X-Gm-Message-State: AA+aEWZVBjdJ6DCqa2Cb9g1u5WJWFi9P0G11gUePSAgHjjfKtvqMqvwN
 iTlRZKi7pMVkDiQ3L+CTl0OaPH2J0e3igkhiWrM=
X-Google-Smtp-Source: AFSGD/XVBvw1ojot5A/rijs9domEzwbU0K58hSib/su4CImD7wBWLHZm8bC62vRujl18Vm/rCnJNSMJtKCgRS0r5Kag=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr27548085lfg.24.1546775929751; 
 Sun, 06 Jan 2019 03:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 6 Jan 2019 17:32:41 +0530
Message-ID: <CAFqt6zb9Wk63Mne+p9x5zfZJfADV-VOQQvGYwvky5a6nffRmhw@mail.gmail.com>
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_035854_217400_3F5CA8B7 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 chen.zhong@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 5, 2019 at 10:39 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/kernel.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..5027ebb7b4e8 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
