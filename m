Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B12AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:49:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B39520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZuqiAC/m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VHqQZv4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B39520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rK9loifQ2CT3jIPvTzcq3Dfg42cupX8TylfgPp3mVcY=; b=ZuqiAC/m9HwktT
	8k8wgIibiqgKiIYex37mAYfbqmXvjuxKAiVEvbn+X3vnmw4yW3JD+T1sDwBkH3KNpPZHZqp9C1ylW
	64nltF8E+El6V4LYqia8LaRx9YOqxdOP9V/Akn09TYTgwkGFNJ7xm//u4XDHuqZxvTciMM8oVDO72
	paWweQTesszlIS7kpCewd4S0MrcSHwx4tiWprl9FWrG91gBLxkdXg0Q4ZG0XSrqP35HRhSacu56lu
	B3GT5WMO8mE8TvxdVMVM0IshbR85BqBu1NNLLtxLLwOOfKeN+qfJAgift57j7fAK5e+f2lSNK1hBh
	5CHoGSCIG9+4tQEaLAcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfnS-0000MB-Nz; Sat, 08 Dec 2018 16:49:42 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfnO-0000KP-QK; Sat, 08 Dec 2018 16:49:40 +0000
Received: by mail-oi1-x242.google.com with SMTP id a77so5847930oii.5;
 Sat, 08 Dec 2018 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u90qm1lo7zTFrCsP0QkupscbeCB3oj/DeM1IBcmae7A=;
 b=VHqQZv4xqGsWOCX6VjS22EXP/xM1K5bJ3skQu82H51mdnHqkr6EPBhi3HIsxkH0BP5
 RKxa9j1MsbRb9r3pwF7YHwZ8OIx31J+l49Xtx7gYiGnOt1ky1wiD2u8h1f1fYQ6zrIak
 klyPw1fu6wkJ/JBspCmeLBdVwikp5NbIYa4ioJYtPiuTQ8ll/WMnTC9tVJAvuzbcf4kh
 3QAyTCydjThnN4D1htuh6qyJCD+mBWA6BY/XA2u11M0UxSCEpx8+NLlWSjELGEwY8Krp
 BF7ApDW7CZqW7h0Mh2cHmHPMi/bvDISAztc3iaqyu1/o6OsxruWHpYubnMYqjp1XlTOU
 3I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u90qm1lo7zTFrCsP0QkupscbeCB3oj/DeM1IBcmae7A=;
 b=CiCTMEc15YV8Q59eT/OmS/mBB3iN/E6/9JwfvTkE4sfwIe0C+azCIiSnbQc+tBLqC5
 /SgHi0bGyte2EchlqWE4wuFjeh/IKPUd9eKzTBgQLAefHyHTir45yeumjqFbIFAhFRrW
 P04HEL1rA3QYBc3doCykOrIDB2t49/34i9U5tbSKntx8jT+0WwRskiEdKXvblgE3y0SS
 qqD3toLO4aqyYxMVs6OKoPrirxa6kyCCgKSaWYximp316HedUuJO6TX0ZFyqk3kYOnx7
 lmLfNTtvuzIj1//5RiVWLE8zQaDH5zSni4TrnlR/uEpcTBivbTmZIcX9dFeJY1pRCCwR
 mhhA==
X-Gm-Message-State: AA+aEWYUvd0zu/f8k4rzW4AV7ZfOGh9ofBqchKZTVKsnXMxHp29TZQmZ
 mlEaYjPdWlz8V5KCY6giKiz3G89FRln9XJ3PrIfNNtHCh7w=
X-Google-Smtp-Source: AFSGD/Wqz50QtT39QED0fEXerJkV6pJrc4q3XpoPITTO87pXZWMLSj4wX+8UfnwnFWAvgG28gN6nwouRgewXO1QfMCg=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr3644106oib.41.1544287767599; 
 Sat, 08 Dec 2018 08:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Dec 2018 17:49:16 +0100
Message-ID: <CAFBinCDuFCrJHrzY_98REiwnZMcezxUbth8Sd+Bz0jxipPhyWQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: add the APB/APB2 busses
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084938_860175_AE70D981 
X-CRM114-Status: GOOD (  11.83  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 5:46 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
> Meson6. This is preparation work for adding the Mali GPU which is
> located on theses busses.
>
> Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
> region at 0xd0000000 is called APB2 or A9_APB and it has a different
> size (256k) compared to Meson8 and Meson8b (2M).
>
> Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
> - Meson6: [0]
> - Meson8: [1]
> - Meson8b: [2]
>
>
> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
> [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
> [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
>
>
> Martin Blumenstingl (3):
>   ARM: dts: meson6: add the APB2 bus
>   ARM: dts: meson8: add the APB bus
>   ARM: dts: meson8b: add the APB bus
I incorrectly sent this series with the patches twice (once with a
typo in APB and once without the typo).
I'll re-send a fixed v2 - sorry for the noise


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
