Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:22:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345152148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B0y73CZX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9eGdkZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345152148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uk84CY9ihJnPEjqS08Dpm44EbXYkV/+njLayxGbbvFc=; b=B0y73CZXJal4kX
	ARPTEIMzwT/b6+CezwjgiFLiY4FLm0UtZAfw2UFz4jk6QztoRbSnF2MG4xqx9dAgmIwMjscHw/BMJ
	eaHRN2YuiCwwcWxIzvShaOYdVKME8hL4M3vqTz1GbkHCmQkjesTHlkNLdNwkceBwojBIGuVWTcCbu
	fxN6WYTzxM+iCcA+e4v7a4/zt6B/xkwibikhcT00/SgVZ9UkfxGbD7powKtyPH2pNW5lWYFW17OWW
	2N7q7rSQoQVpRnMputQ6XL0HduKQJdFh9IidPP/0v7cPr8zP058zBQ6eowLwUrdEKAVRDxpzrH9uP
	qOSvPPf89EQ/ys2IlVhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goMnF-0000Eo-EU; Tue, 29 Jan 2019 06:22:45 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goMnB-0000E0-1f; Tue, 29 Jan 2019 06:22:42 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so20639267wrt.4;
 Mon, 28 Jan 2019 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OulpkHK1W3wCTLsa4tU3WH70de/mnFZqHAE3uaFmX6w=;
 b=l9eGdkZKEOKb8oFOCEU9/fk2n3CZLgcW3EjimVJqv2LtNC8uZixzSW4x+sFlBBa/LV
 l13OZTNnKkIK3HwTCHeWLSrVtcjJNXZpw86UAvwBMdgVoUqUZvQ1eEnUu2+CCOVyggOa
 2pmyRaXBFJ6FXfZnoyXwaWY/5Vm22oXiZusfSgbjcAkietIYuWHABK+fDvw7xjU9csqF
 EGre3OZ4sAV4oDyWjsQsQf6YP1RkzjVXqs8SlXpa0UaWvulz/mbhtBby98SLYRV7S9iz
 9eSl/Kk6cWv9ZoelwcFbczhxDI54iRNii4l5ZaBqYtiaoxgJG8ICdhgCUCWpPY7T21/u
 8KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OulpkHK1W3wCTLsa4tU3WH70de/mnFZqHAE3uaFmX6w=;
 b=e4uU1rvdTSBrsYUW0NQPp5CM7InYNT4xxW6yFY9eyu4pBEPs6XwsKo9JKr2xYlBuIT
 zkCj4aeBmoqIIy2ClIxlP7ruOeH6fHHxs9b+OXNY+oWSNLsD1LoULTReOSZzKn2F1hEK
 x01vPQlGgGM7ybvjTDWVc9jFxFFhKkAk/zEENXJ0iTT8VTswFHDHp6+erBvnUz/MTGKy
 743I5c4xg3YGEI05yi46nwecfo6qBIiAqn4pcSyFAxGkYI/jDWXeUL1admDf7Fwn63f4
 T0qRciXS7NH/OvlX6bxlsAbabgKaNRfSvGif3V103brBIi3TH6BLI2vF28VfFW95Aitf
 nQ7A==
X-Gm-Message-State: AJcUukd6aeEi2nF9kuniZX27fWMg4bTViaXmTdzNJ9qG4rnJWsk3N41T
 xufu4QkIZ8CzrFaezZT3Su4ZAIpNILg=
X-Google-Smtp-Source: ALg8bN4X7PD0aSauo6zQkOg/DTN1q1hXljZgcGiFO66APcZM/rsUbnTWm9ZM3sPVuE/AI1BqJZHJwQ==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr23456399wri.210.1548742957563; 
 Mon, 28 Jan 2019 22:22:37 -0800 (PST)
Received: from ?IPv6:2001:16b8:a03b:5a00:437e:83f9:772d:3f24?
 ([2001:16b8:a03b:5a00:437e:83f9:772d:3f24])
 by smtp.gmail.com with ESMTPSA id 129sm2449223wmd.18.2019.01.28.22.22.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 22:22:36 -0800 (PST)
Subject: Re: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
To: Sean Wang <sean.wang@kernel.org>
References: <20190128223521.2690-1-voytikd@gmail.com>
 <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
From: Dmitry Voytik <voytikd@gmail.com>
Message-ID: <3e1acf90-9975-12cb-5e78-24e4bd03b507@gmail.com>
Date: Tue, 29 Jan 2019 07:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_222241_114202_F9C2BE25 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/29/19 6:02 AM, Sean Wang wrote:
> On Mon, Jan 28, 2019 at 2:35 PM Dmitry Voytik <voytikd@gmail.com> wrote:
>>
>> How to reproduce the problem:
>> $ make tinyconfig
>> $ make menuconfig
>> then enable:
>>  CONFIG_COMPILE_TEST=y
>>  CONFIG_PINCTRL=y
>> and any of these:
>>  CONFIG_PINCTRL_MT7622=y
>>  CONFIG_PINCTRL_MT7629=y
>>  CONFIG_PINCTRL_MT7623=y
>>
>> This combination causes build failure.
>>
>> Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.
>>
>> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
>> ---
>>  drivers/pinctrl/mediatek/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
>> index 1817786ab6aa..a005cbccb4f7 100644
>> --- a/drivers/pinctrl/mediatek/Kconfig
>> +++ b/drivers/pinctrl/mediatek/Kconfig
>> @@ -45,12 +45,14 @@ config PINCTRL_MT2701
>>  config PINCTRL_MT7623
>>         bool "Mediatek MT7623 pin control with generic binding"
>>         depends on MACH_MT7623 || COMPILE_TEST
>> +       depends on OF
>>         default MACH_MT7623
>>         select PINCTRL_MTK_MOORE
>>
>>  config PINCTRL_MT7629
>>         bool "Mediatek MT7629 pin control"
>>         depends on MACH_MT7629 || COMPILE_TEST
>> +       depends on OF
>>         default MACH_MT7629
>>         select PINCTRL_MTK_MOORE
>>
>> @@ -92,6 +94,7 @@ config PINCTRL_MT6797
>>
>>  config PINCTRL_MT7622
>>         bool "MediaTek MT7622 pin control"
>> +       depends on OF
>>         depends on ARM64 || COMPILE_TEST
>>         default ARM64 && ARCH_MEDIATEK
>>         select PINCTRL_MTK_MOORE
>> --
>> 2.20.1
>>
> 
> It seems the commit 2d2d478576d71000b29c52668c5712c825ee9af8 already
> fixed the problem or is there something I'm missing?
> 

Opps, sorry. Should have checked linux-pinctrl.git.
Sorry for spamming.

BR,
Dmitry.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
