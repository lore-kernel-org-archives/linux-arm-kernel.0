Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:24:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C22081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYl+6dYT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enwcx4nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2TuIsQH5g21Z2LiAIvJVNh/gEY2V96vQJLraTnm6Ypk=; b=gYl+6dYThpE18O
	ynrZDuRPtT11rdPU2OhUpCGCS5wI0SX0nktcaozrKquvEOItqwK6vjhVqmucrqCXyCQRXl84i/lh1
	W9/nH8/E5j4UB+c/MqjjRx6FE3jdJEGUGJMV1bIkqHcLj7UlDfmv+PtGqL0YXT0MBkiBHjsLowXQZ
	hnWck/qBAG5xVmpOfmfkm4NvSrjEwwXgqmGPmp9flYJ3VywRsrfiANoDU8KQTLkN4D72DkNZkjiTq
	NllKcQGdpUxB4F1dsW8ClP5xdgqJfuZt9B3lUx9k9C8FbVYJZ4t4AqoscG1xkzvmou6aW69ftyh9x
	cnrRBGvp71uujCKy1PTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJ71-0002km-AT; Tue, 04 Dec 2018 22:24:15 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJ6x-0002jX-Qp
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:24:13 +0000
Received: by mail-yw1-xc44.google.com with SMTP id i22so7364923ywa.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I6nCkMUwljQh49NXS/ClOKHkTPzJgolIuwBRZ+snpIQ=;
 b=Enwcx4nYi6WhkOZPYYFpuGKYYzpK/yoSpN8nn56gZf7MZ0teeS9Kh+AsO50EYX+MbC
 yGILzMN246CsVbcOXF01Lp8TD1shauDu559rocut2Dc8C5XY7Wh1Jga3Zh5J3i1G27V4
 BJGKHtirxwU141ZTGyBhX6dWmjEckAdzQ7D9nieeuTaSGBNAcu6aptmZrcXiUf/xZmv0
 uQChQeCGxi2vLclOK8zwp1IFOx9bRLx2aO43o3u0EjEBl45b4FYgguPs6a97WwgzW2BB
 VLEEqow8Qg7ACZaORuI7QUBewirpwuCT8zDcFlOyMoRRrtR8v24o9QW6HYnx/onW+NgK
 cO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I6nCkMUwljQh49NXS/ClOKHkTPzJgolIuwBRZ+snpIQ=;
 b=TzRu1C5cofR6WumZRP814dVfbykAmOf6VqfaN0673G3zhNyHhNQxRYjyRij1uHD/nh
 M0O+iNAroERkPhZU03NTdfhuUupMxL7y8AlDxp6d6Xoes2gyn6t7beFhujX9QxNRuZQd
 CSiACs40BupG9rgy4G1x6TW3O93pTtCD3gN/ES3nEnnJfOIt8CmAcd0CCUifdd0E+Ntp
 0Bpm+UCnAg5TFdp5bm3SGeXroDQ+suqB2XEUtawOI3VArO36W8/MrYl/KhgX3AA0Z6DO
 DrA0d6zWGV9iIpQYKFw9gjtQZ4eBvmCNF4+NulEelFT/KStQpRmm6+ZUG32DarEpvA9Y
 v60Q==
X-Gm-Message-State: AA+aEWZJLIEn12ooJHGEU6+dd52/e58zmkioEpjis7sW7nJ9c1d3h4YN
 WbyVOKK26/7K60IiL0t2YRy2521QbqVEplyzbeE=
X-Google-Smtp-Source: AFSGD/VaqoiUCb2M/7uA1CaI9733KNeLBZjJZx33e5+95+MKsMRDDpUhT09IgyoJB467lNXpjnvXDRg0Daao5Y7dWJk=
X-Received: by 2002:a81:1fd4:: with SMTP id
 f203mr21520235ywf.422.1543962240420; 
 Tue, 04 Dec 2018 14:24:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com>
 <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
In-Reply-To: <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Dec 2018 14:23:47 -0800
Message-ID: <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
Subject: Re: [PATCH v12 05/25] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
To: Andrey Konovalov <andreyknvl@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_142411_875150_75AD45CB 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 paullawrence@google.com, linux-mm@kvack.org, glider@google.com,
 cpandya@codeaurora.org, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob.Bramley@arm.com,
 Ruben.Ayrapetyan@arm.com, markbrand@google.com, kasan-dev@googlegroups.com,
 linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, dave.martin@arm.com,
 eugenis@google.com, vishwath@google.com, Arnd Bergmann <arnd@arndb.de>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, marc.zyngier@arm.com,
 Ramana.Radhakrishnan@arm.com, rppt@linux.vnet.ibm.com,
 Dmitry Vyukov <dvyukov@google.com>, kcc@google.com, jannh@google.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ndesaulniers@google.com,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Lee.Smith@arm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Tue, Nov 27, 2018 at 9:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This commit splits the current CONFIG_KASAN config option into two:
> 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
>    that exists now);
> 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.

[...]

> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -1,35 +1,95 @@
> +# This config refers to the generic KASAN mode.
>  config HAVE_ARCH_KASAN
>         bool
>
> +config HAVE_ARCH_KASAN_SW_TAGS
> +       bool
> +
> +config CC_HAS_KASAN_GENERIC
> +       def_bool $(cc-option, -fsanitize=kernel-address)
> +
> +config CC_HAS_KASAN_SW_TAGS
> +       def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> +
>  if HAVE_ARCH_KASAN
>
>  config KASAN
> -       bool "KASan: runtime memory debugger"
> +       bool "KASAN: runtime memory debugger"
> +       help
> +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> +         designed to find out-of-bounds accesses and use-after-free bugs.
> +         See Documentation/dev-tools/kasan.rst for details.

Perhaps KASAN should depend on
CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS,
otherwise make all*config may enable KASAN
for a compiler that does not have any -fsanitize=kernel-*address
support, resulting in build failures like this:
  http://kisskb.ellerman.id.au/kisskb/buildresult/13606170/log/

-- 
Thanks.
-- Max

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
