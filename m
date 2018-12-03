Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4928C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B572087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pGjix9LF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFEnIRfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B572087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Gj9I4u0My2WAU5WRQHa2Kc6qHYbKTfWTY5xTpsoKfY=; b=pGjix9LF3GM5Bi
	xf7KJiQYPhl1IBiZEiAepGNGCnh8NJjR4B4kckixnEL32YH/mBLARB2P/BcQuFjIBbIiuZ3teKJJI
	nII5sdmcdDOod1zoYDIdzw9NX67kkcapLrpwWJmT1n6wnxMmfFFGOh/7Ad/MNAnnhVozKndGlO5ZK
	lEE/lgOfpI2RH4bu2CPy03LJo/dsORPA7mv13DMxNSr43qnBmdQBObdBq7z6Tk6xlGmiEBOKLuNua
	z3eaRRTeW7DIMAGgFoh4CCrVcNxD8gGgrOfjd02i8KknvX6bpnrXvGgOgrN4viLnE0ztdBDHcJs2w
	/mB1UaJIAdsvcbcTztfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTuTy-0000e7-IQ; Mon, 03 Dec 2018 20:06:18 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTuTv-0000dK-IM
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:06:17 +0000
Received: by mail-it1-x144.google.com with SMTP id c9so10631891itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8MuAW2wYrnSpr7RW3J4Vo9qLQIWIcepPDrYMFFF3sQE=;
 b=fFEnIRfi5YkkUkRBdjsNHxmhjdmo/ziDwlwkW8gdHQ5BnL/jEfgjopJA69y9tFYUks
 0QboPyY9AKTOZchijzuIUaAvsvuqxWJRceNNVHUjq9onh5WDpD1G3YXYXGI45yGMZoWq
 83sDUN5++w5osGDuu8Vs8+VwvhjFcWGfUZoXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8MuAW2wYrnSpr7RW3J4Vo9qLQIWIcepPDrYMFFF3sQE=;
 b=Wxju+wyW2IDJ7SfQuDic6wjSbui5qXzAs9IV+KQjBSrwfn1/zLpX8xhOMshlICoehI
 7csgS0/Joq+WyFrghMhtuO7Y9q3KXbHTmI1AjiKzRlL/uZ64UMsIp4UduQnz4Dae7eBF
 a5IJmc7ZRFwHAE02KcZXRUQ/zdx2UaH+Ul4DdYZkawH9j1DsPIVUoNlmhSXxX/K654Kq
 kO4jpTu6N4rA2bzJvwIsqDReSOVInWCt5JxCfGfu6roFrmzfnRIE+T1LOPwsumcdxpMT
 40VQDa0T14K5M+BqKQ7pjykKCrC6fgaP6JvAuJari3t7b7TTn6922bgU38l+tIa76rV0
 +uMg==
X-Gm-Message-State: AA+aEWaDUFB7sK1/6yphuNdWrX457UykZ/CE5j/rOdwcc/ynwcSVwTnF
 9dP7Hu7W1F/Uo/qrQ87fvMrpHQ98hfUWAMomNRSzNVki
X-Google-Smtp-Source: AFSGD/U3eP5kEDjeM63Sy5qrNlPN3brESbbrjxREIvocXgzQIodgkzbBN6rh2qGFx1TaJu3pwRIqO64bVGhP2DMI2+Q=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr9465968itk.71.1543867564341; 
 Mon, 03 Dec 2018 12:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20181128010901.1052-1-liuyun01@kylinos.cn>
 <20181203192310.GG29028@arm.com>
In-Reply-To: <20181203192310.GG29028@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 21:05:52 +0100
Message-ID: <CAKv+Gu_CwVt_-HDvaV+VBaFzA+u3RqBKhd9c7tOkGQxC8pZMjQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64/neon: add workaround for ambiguous C99
 stdint.h types
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_120615_609822_00F6C00A 
X-CRM114-Status: GOOD (  28.46  )
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
Cc: linux-block@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 liuyun01 <liuyun01@kylinos.cn>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 at 20:22, Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Nov 28, 2018 at 09:09:00AM +0800, Jackie Liu wrote:
> > In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> > for ambiguous C99 stdint.h types"), this patch redefines the macros that
> > are used in stdint.h so its definitions of uint64_t and int64_t are
> > compatible with those of the kernel.
> >
> > This patch comes from: https://patchwork.kernel.org/patch/3540001/
> > Wrote by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > We mark this file as a private file and don't have to override asm/types.h
> >
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > ---
> >  arch/arm64/include/asm/neon-intrinsics.h | 34 ++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
> >
> > diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
> > new file mode 100644
> > index 0000000..e378766
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/neon-intrinsics.h
> > @@ -0,0 +1,34 @@
> > +#ifndef _NEON_INTRINSICS_H
> > +#define _NEON_INTRINSICS_H
>
> We tend to name these with an __ASM_ prefix, so it should be:
>
> #ifndef __ASM_NEON_INTRINSICS_H
>
> That said, I notice that the commit you refer to for arch/arm/ actually
> places this stuff under uapi/. Is that needed?
>

No, it doesn't. It creates asm/types.h which has been moved into uap/
at a later date (which I guess means we're stuck with it). In
hindsight, it would have been better for ARM to create a neon
instrinsics header file such as this one, since the override is only
needed when you include <arm_neon.h>.

> > +#include <asm-generic/int-ll64.h>
> > +
> > +/*
> > + * For Aarch64, there is some ambiguity in the definition of the types below
> > + * between the kernel and GCC itself. This is usually not a big deal, but it
> > + * causes trouble when including GCC's version of 'stdint.h' (this is the file
> > + * that gets included when you #include <stdint.h> on a -ffreestanding build).
> > + * As this file also gets included implicitly when including 'arm_neon.h' (the
> > + * NEON intrinsics support header), we need the following to work around the
> > + * issue if we want to use NEON intrinsics in the kernel.
> > + */
>
> Could you elaborate on what the ambiguities / conflicts in the types are
> please? I think you can also remove the sentence about directly including
> stdint on a freestanding build, since it doesn't seem relevant to the
> kernel afaict (we only pull it in via arm_neon.h).
>

In the kernel, u64/s64 are [un]signed long long, not [un]signed long.
So by redefining these macros to the former, we can force gcc-stdint.h
to define uint64_t / in64_t in a compatible manner.

> > +
> > +#ifdef __INT64_TYPE__
> > +#undef __INT64_TYPE__
> > +#define __INT64_TYPE__               __signed__ long long
>
> Do we need this __signed__ part?
>

No that seems redundant to me.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
