Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E0C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE2A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e/Vrj5xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE2A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I6tQujT5BgzMbfWha4AieLOuiAvbSQYbJClM1IiXV8A=; b=e/Vrj5xlkFlYOPeKwvkJUupkA
	4egyN0ptzqy5egnbH2hcyOM+Q4C0HYeIw1VGfhQd6XfcRzD/z8UwZmYvemhsH8Ed9RG0umhCcpx/8
	o/1WBStjlvHv/fbAbKPBp2YYgneSA99CEfgjVOdO9v1H6OgoFjCC9DI9HtQ/GkzvtEULLaFHfpd3a
	aDhwrdDOChLngIdP1njhpGW4ZwOR1GKOAuk7L3/JY80XV4HJWvsv9zBCFW9jA5fEd8kXbJ4vxNCuW
	o0FSaS8IfQteZvqyvZZkedl8netTXWSsnDVYdA0L2h7pylxfIWQWaANC0e7gzUjY457YBSIM1uhVc
	7SwNTm7YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUPLy-0007o2-M8; Wed, 05 Dec 2018 05:04:06 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUPLv-0007mm-Rr
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 05:04:05 +0000
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 05 Dec 2018 14:03:51 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 3A5F9180B3E;
 Wed,  5 Dec 2018 14:03:51 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Wed, 5 Dec 2018 14:03:51 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id BAC9D4036C;
 Wed,  5 Dec 2018 14:03:50 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 24891120304;
 Wed,  5 Dec 2018 14:03:50 +0900 (JST)
Subject: Re: [PATCH 11/14] pinctrl: milbeaut: Add Milbeaut M10V pinctrl
To: Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589336-13925-2-git-send-email-sugaya.taichi@socionext.com>
 <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <5dcbde7f-8458-8630-9f7e-115a9c8364e4@socionext.com>
Date: Wed, 5 Dec 2018 14:03:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNASnBobLm51VL=EVt+97-KBX3vEqXGjTH-L-q1Qn8_GUQA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_210404_018936_E06983C4 
X-CRM114-Status: GOOD (  30.06  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi

Thank you for your comments.

On 2018/12/04 20:23, Masahiro Yamada wrote:
> Hi Sugaya-san
> 
> On Mon, Nov 19, 2018 at 10:01 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> Add Milbeaut M10V pinctrl.
>> The M10V has the pins that can be used GPIOs or take multiple other
>> functions.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> 
> This patch was sent to:
> 
> linux-clk@vger.kernel.org,
> devicetree@vger.kernel.org,
> linux-arm-kernel@lists.infradead.org,
> linux-kernel@vger.kernel.org,
> linux-serial@vger.kernel.org
> 
> 
> 
> 
> Unfortunately, the most important ML
> 
>    linux-gpio@vger.kernel.org
> 
> was not addressed.
> 
> 
> The pinctrl maintainer may not notice this patch.

Ah I took a critical mistake...

> 
> 
> 
> 
> 
> 
> 
>> diff --git a/drivers/pinctrl/pinctrl-m10v.c b/drivers/pinctrl/pinctrl-m10v.c
>> new file mode 100644
>> index 0000000..d4ca713
>> --- /dev/null
>> +++ b/drivers/pinctrl/pinctrl-m10v.c
>> @@ -0,0 +1,765 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Socionext Ltd.
>> + * Copyright (C) 2015 Linaro Ltd.
>> + * Author: Jassi Brar <jaswinder.singh@linaro.org>
> 
> 
> My company name is "Socionext Inc." instead of "Socionext Ltd."

Yes, modify it.

> 
> 
> 
> 
> 
> 
> 
>> +static struct platform_driver m10v_pinctrl_driver = {
>> +       .probe  = m10v_pinctrl_probe,
>> +       .driver = {
>> +               .name           = "m10v-pinctrl",
>> +               .of_match_table = m10v_pmatch,
>> +       },
>> +};
>> +
>> +static int __init m10v_pinctrl_init(void)
>> +{
>> +       return platform_driver_register(&m10v_pinctrl_driver);
>> +}
>> +arch_initcall(m10v_pinctrl_init);
> 
> 
> Can't it be builtin_platform_driver()?

I think using builtin_platform_driver() is no problem.

> 
> Which device requires this to be arch_initcall()?

This driver was originally a module, so no need to be arch_initcall().
I will use arch_initcall() instead.

Thanks
Sugaya Taichi

> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
