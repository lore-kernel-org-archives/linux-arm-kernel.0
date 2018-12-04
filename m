Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80135C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E3120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzm5zH4h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bDY/6r5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E3120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iGWwVjntfLRvVmSWj4fVOVZuUujrtaJOVKpRk308gzY=; b=gzm5zH4hPzxN8n
	rZ0icaoRmwE6k4jwsGT8LAicfGT77Vzs+nqg/8AmMKr1eOWyvlDfvjIHkL9gKbrcAqNaepWu0Gmns
	QX3/Y12PcMzjXobSgKrXvgg+pkr6G+Bggswrbak0Y7j/kjV+u3+P2Bep+1LE/tipMVFmGbkWF0W6O
	dWhRPGxYiQP36yVwzlhAtikGf8d2H+0me8sHRJIa0aXNCHjDJk3jN2FqLT9RwiNJPW/bd9I4NGphH
	X1xK62dKDpm+/9sfT4ctif/N5T0HA9K8slUHhReU3Pvk0wZleSdxA+C5EZ0z8lg5tmhmMxvBSdsxM
	s4VJcUPXfhrIMWxc4cCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8oq-0003lz-Qe; Tue, 04 Dec 2018 11:24:48 +0000
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8on-0003as-M6
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:24:47 +0000
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wB4BOEJf013545
 for <linux-arm-kernel@lists.infradead.org>; Tue, 4 Dec 2018 20:24:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wB4BOEJf013545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1543922655;
 bh=FlpS0XJ3z9z0ek44Gl7gERWZOMn7xf3fsoCpTAa2s0M=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bDY/6r5odPfRiVoJw4MrN9wl+3t+EDn8Xax/qxq7h1MVJIS+5bLlrucrtPAbAePJo
 dDJET3uiy0tNJl5XvWxUuf8zQecd6yEfDDA65hUfWEIMtOARm/upcgdAdcAeY68ArM
 8kwrq6IJlGdMd8r+XzGLoxtA5xRFWMyskujrRcnAltZQ9isT9g4XbA29CaeXE7Fac5
 tyTBFO2SRKSeLWdKTLQMDOeMKTIYifFFBuwwyINe+0npcQjMjksoiQlOIlkY/aGrBI
 q/KbCJkoE8rtm9uXxx02Mfmt54gGj3jE6mBMu8U3xxl2QOkWYXSUkfZeoaAaVU0NgL
 RhiKjNhqlaHuw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id g68so9549200vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:24:15 -0800 (PST)
X-Gm-Message-State: AA+aEWa+BEfsi/rTZjBfy//qQBAAomOeNVe3bMT85cIarFOlnhUiaTao
 /iOqFIkDL6jMPyJ2L/F10K2fMNozeyXf75YQD88=
X-Google-Smtp-Source: AFSGD/VqyZrnTs2ct8snVogSYKalfHnqVVXxUVHGSn/iKlzkXmXur/pANgXaQDNsEI2sseGB0zWEAUtH73pJh6GFu5I=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr8494079vsm.181.1543922654170; 
 Tue, 04 Dec 2018 03:24:14 -0800 (PST)
MIME-Version: 1.0
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 4 Dec 2018 20:23:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Message-ID: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Subject: Re: [PATCH 11/14] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To: sugaya.taichi@socionext.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_032445_930853_944CEFD6 
X-CRM114-Status: GOOD (  17.15  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sugaya-san

On Mon, Nov 19, 2018 at 10:01 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add Milbeaut M10V pinctrl.
> The M10V has the pins that can be used GPIOs or take multiple other
> functions.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>


This patch was sent to:

linux-clk@vger.kernel.org,
devicetree@vger.kernel.org,
linux-arm-kernel@lists.infradead.org,
linux-kernel@vger.kernel.org,
linux-serial@vger.kernel.org




Unfortunately, the most important ML

  linux-gpio@vger.kernel.org

was not addressed.


The pinctrl maintainer may not notice this patch.







> diff --git a/drivers/pinctrl/pinctrl-m10v.c b/drivers/pinctrl/pinctrl-m10v.c
> new file mode 100644
> index 0000000..d4ca713
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-m10v.c
> @@ -0,0 +1,765 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Ltd.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Jassi Brar <jaswinder.singh@linaro.org>


My company name is "Socionext Inc." instead of "Socionext Ltd."







> +static struct platform_driver m10v_pinctrl_driver = {
> +       .probe  = m10v_pinctrl_probe,
> +       .driver = {
> +               .name           = "m10v-pinctrl",
> +               .of_match_table = m10v_pmatch,
> +       },
> +};
> +
> +static int __init m10v_pinctrl_init(void)
> +{
> +       return platform_driver_register(&m10v_pinctrl_driver);
> +}
> +arch_initcall(m10v_pinctrl_init);


Can't it be builtin_platform_driver()?

Which device requires this to be arch_initcall()?





--
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
