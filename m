Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA125C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:19:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842A62073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TfVKWA3/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNS100Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842A62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCikdEWBltAHJuRN0xjs+Y+pjzEV2rDAMat/3UcLXls=; b=TfVKWA3/qOTFx4
	hvDDEmAl0h8wNnpfX9ohFJv+4Ya9cabg5Y7RmnLbgRES9EYnQww/8iMYVeiw+B1nhzjVj0XwGlRkz
	jxj9zEsx3YmnqTnYbBI2raSn+oKAXOfJZPrUt8OkEIZpn4YHjyaO/4+OFF1iraXo/tItZ1cEWNt1U
	amV/VeHG03QUgabznCW8jp2usihNe++IdkeN4cLor7i88xDLN97AQpBuyiD0TpHMjHYh35sggx987
	ODcn8Kd2vfdIB05d1eEfMznyZI8TyRljOpxpIaDb1cU4VJFqye0Onj9ycuCv3qYqzWRopDTASKIkD
	iERxyug6VNRVlim7bIbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7aX-0006lJ-5q; Thu, 03 Jan 2019 18:19:25 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7aS-0006ky-Iy
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 18:19:22 +0000
Received: by mail-io1-xd2b.google.com with SMTP id k2so5088558iog.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f3YOV3iEGb1kfgnWZmED5sGLPo7JKmxwG/tly29Y2HQ=;
 b=VNS100MrHoyK+LaRwzN1vB+p9IQTr9WFpOf9WMT9HfQB9kLE0CTKxpnYPbMYF7rInr
 O0QS8jR+UD9+6cazEKElz9lpR8qyEHjwDHuuPCOdRibEzqWwFsqOXUQgG7wOskdHaAu9
 DARnX6fpsMFc1sGAur5RvckhBrGveV3sBmXM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f3YOV3iEGb1kfgnWZmED5sGLPo7JKmxwG/tly29Y2HQ=;
 b=CUprW6HoPWUFm1DxcoWFMNH5dhGBXVJFTTPNxtUZpuuawHBVRZ34OAhkH3ww2BiNOD
 rqiRsHwCs63cgTR3o8duxtYWbtvE3Dt5JOBMdB+s/hcn7unW6e5U936ihqy5VLetKrkf
 Ytnd8QCATRBXANFPo/MbxgZkCW3lEr8Vpfq/3N86tcPCRiwzljmb9kmBQPjKPnc3oZHf
 lm20R9DsytvTkcNlrfxVINy3K9CByxYNqoYYZI2tR/Xo9damAJO2Uureywqwt3ePYUdH
 AVv4VEHogW/MONrVXlHfjam2Ba1/fPOdezdCCtpqryeSAX9KUOzdJqaOFAsFxJbwuGGH
 Y4dg==
X-Gm-Message-State: AJcUukeL0HsWMnsX3FGT9K8s2K0/sH/MwbDunSIqSgJes3SlDOLwgw0N
 y1+0Fznk8wyM5/d1xdKaMAFJaWn0RViXq/Estq98Tw==
X-Google-Smtp-Source: ALg8bN4lr+Rsvorn2dfrBXJfMAK+IVWYYP/SxofcOkp520ZC7ObuDrcYqBT7E+rpK6IcMNIrywNGx3QXNNRBXMa+3Vk=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr21300599ion.173.1546539558838; 
 Thu, 03 Jan 2019 10:19:18 -0800 (PST)
MIME-Version: 1.0
References: <1546518769-114424-1-git-send-email-huanglingyan2@huawei.com>
In-Reply-To: <1546518769-114424-1-git-send-email-huanglingyan2@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 3 Jan 2019 19:19:07 +0100
Message-ID: <CAKv+Gu8GvO6L0++3VnRaCkRYfF6VMBGayqto-kgerdJvaoyxHw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: lib: accelerate do_csum with NEON instruction
To: Lingyan Huang <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_101920_631623_338057A5 
X-CRM114-Status: GOOD (  26.00  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019 at 13:32, Lingyan Huang <huanglingyan2@huawei.com> wrote:
>
> Function do_csum() in lib/checksum.c is used to compute checksum,
> which is turned out to be slowly and costs a lot of resources.
> Let's use neon instructions to accelerate the checksum computation
> for arm64.
>
> ------
> V1 ==> V2:
>     Change NEON assembly code to NEON intrinsic code which is built
>     on top of arm_neon.h to avoid dropping into assembly.
> ------
>
> Here is the comparison results of function ip_compute_csum() between
> general do_csum() and neon instruction do_csum().
>
>         len(1000cycle)      general(ns)        do_csum_neon(ns)
>           64B:                58060                 59460
>          128B:                82930                 83930
>          256B:               132480                 73570
>          512B:               230100                 86230
>         1024B:               426600                 98200
>

Very nice! Which CPU did you test this on?

>
> ---
>  arch/arm64/lib/Makefile        |   4 ++
>  arch/arm64/lib/checksum.c      | 140 +++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/checksum.h |   1 +
>  lib/checksum.c                 |   8 ++-
>  4 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/lib/checksum.c
>
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 5540a16..ec2fcd3 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -9,6 +9,10 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
>  obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
>  CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
>  CFLAGS_xor-neon.o              += -ffreestanding
> +
> +obj-y    += checksum.o
> +CFLAGS_REMOVE_checksum.o       += -mgeneral-regs-only
> +CFLAGS_checksum.o              += -ffreestanding
>  endif
>
>  # Tell the compiler to treat all general purpose registers (with the
> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
> new file mode 100644
> index 0000000..48f4ead
> --- /dev/null
> +++ b/arch/arm64/lib/checksum.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * arch/arm64/lib/checksum.c

Drop this line

> + *
> + * Authors: Lingyan Huang <huanglingyan2@huawei.com>
> + * Copyright (C) 2018 Hisilicon, Inc. All Rights Reserved.
> + *
> + * Generic C or neon implementation of do_csum operations.
> + * Choose faster neon instructions when NEON is supported.
> + *
> + */
> +
> +#include <asm/neon.h>
> +#include <asm/simd.h>
> +#include <asm/checksum.h>
> +#include <asm/byteorder.h>
> +#include <asm/neon-intrinsics.h>
> +
> +#define CSUM_NEON_THRESHOLD 128
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +static inline u32 from64to16(u64 x)
> +{
> +       /* add up 32-bit and 32-bit for 32+c bit */
> +       x = (x & 0xffffffff) + (x >> 32);
> +       /* add up carry.. */
> +       x = (x & 0xffffffff) + (x >> 32);
> +       /* add up 16-bit and 16-bit for 16+c bit */
> +       x = ((u32)x & 0xffff) + ((u32)x >> 16);
> +       /* add up carry.. */
> +       x = ((u32)x & 0xffff) + ((u32)x >> 16);
> +       return x;
> +}
> +
> +unsigned int do_csum_neon(const unsigned char *buff, unsigned int len)
> +{
> +       unsigned int odd, count;
> +       uint64_t result = 0;
> +       unsigned int count64;
> +       uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
> +
> +       register uint32x4_t v0, v1, v2, v3;
> +
> +       if (unlikely(len <= 0))

len is unsigned so '== 0' is sufficient

> +               return result;
> +
> +       odd = 1 & (unsigned long) buff;

No space after () cast please

> +       if (unlikely(odd)) {
> +               result = *buff;
> +               len--;
> +               buff++;
> +       }
> +
> +       count = len >> 1;
> +       if (count) {
> +               if (2 & (unsigned long) buff) {
> +                       result += *(unsigned short *)buff;
> +                       count--;
> +                       len -= 2;
> +                       buff += 2;
> +               }
> +               count >>= 1;            /* nr of 32-bit words.. */
> +               if (count) {
> +                       if (4 & (unsigned long) buff) {
> +                               result += *(unsigned int *) buff;
> +                               count--;
> +                               len -= 4;
> +                               buff += 4;
> +                       }
> +                       count >>= 1;    /* nr of 64-bit words.. */
> +
> +                       v0 = vzero;
> +                       v1 = vzero;
> +                       v2 = vzero;
> +                       v3 = vzero;
> +
> +                       count64 = count >> 3;  /* compute 64 Byte circle */
> +                       while (count64) {
> +                               v0 = vpadalq_u16(v0,
> +                                       vld1q_u16((uint16_t *)buff + 0));
> +                               v1 = vpadalq_u16(v1,
> +                                       vld1q_u16((uint16_t *)buff + 8));
> +                               v2 = vpadalq_u16(v2,
> +                                       vld1q_u16((uint16_t *)buff + 16));
> +                               v3 = vpadalq_u16(v3,
> +                                       vld1q_u16((uint16_t *)buff + 24));
> +                               buff += 64;
> +                               count64--;
> +                       }
> +                       v0 = vaddq_u32(v0, v1);
> +                       v2 = vaddq_u32(v2, v3);
> +                       v0 = vaddq_u32(v0, v2);
> +
> +                       count %= 8;
> +                       while (count >= 2) { /* compute 16 byte circle */
> +                               v0 = vpadalq_u16(v0,
> +                                       vld1q_u16((uint16_t *)buff + 0));
> +                               buff += 16;
> +                               count -= 2;
> +                       }
> +
> +                       result += vgetq_lane_u32(v0, 0);
> +                       result += vgetq_lane_u32(v0, 1);
> +                       result += vgetq_lane_u32(v0, 2);
> +                       result += vgetq_lane_u32(v0, 3);
> +                       if (count & 1) {
> +                               result += *(unsigned long long *) buff;
> +                               buff += 8;
> +                       }
> +                       if (len & 4) {
> +                               result += *(unsigned int *) buff;
> +                               buff += 4;
> +                       }
> +               }
> +               if (len & 2) {
> +                       result += *(unsigned short *) buff;
> +                       buff += 2;
> +               }
> +       }
> +       if (len & 1)
> +               result += *buff;
> +       result = from64to16(result);
> +       if (odd)
> +               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> +       return result;
> +}
> +#endif
> +
> +
> +unsigned int do_csum(const unsigned char *buff, unsigned int len)
> +{
> +       if ((len >= CSUM_NEON_THRESHOLD) && may_use_simd()) {
> +               unsigned int res;
> +
> +               kernel_neon_begin();
> +               res = do_csum_neon(buff, len);
> +               kernel_neon_end();
> +               return res;
> +       } else
> +               return do_csum_generic(buff, len);
> +}
> diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
> index 34785c0..041063c 100644
> --- a/include/asm-generic/checksum.h
> +++ b/include/asm-generic/checksum.h
> @@ -33,6 +33,7 @@ extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum)
>   */
>  extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
>                                         int len, __wsum sum, int *csum_err);
> +extern unsigned int do_csum_generic(const unsigned char *buff, int len);
>

Surely, we can find a better way to hook up this code than modifying
headers under asm-generic and code in lib/checksum.c

Is arm64 the only arch that has an optimized checksum() function?

>  #ifndef csum_partial_copy_nocheck
>  #define csum_partial_copy_nocheck(src, dst, len, sum)  \
> diff --git a/lib/checksum.c b/lib/checksum.c
> index d3ec93f..83392db 100644
> --- a/lib/checksum.c
> +++ b/lib/checksum.c
> @@ -47,7 +47,7 @@ static inline unsigned short from32to16(unsigned int x)
>         return x;
>  }
>
> -static unsigned int do_csum(const unsigned char *buff, int len)
> +unsigned int do_csum_generic(const unsigned char *buff, int len)
>  {
>         int odd;
>         unsigned int result = 0;
> @@ -100,6 +100,12 @@ static unsigned int do_csum(const unsigned char *buff, int len)
>  out:
>         return result;
>  }
> +
> +static unsigned int do_csum(const unsigned char *buff, int len)
> +{
> +       return do_csum_generic(buff, len);
> +}
> +
>  #endif
>
>  #ifndef ip_fast_csum
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
