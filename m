Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99956C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B3321872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="COgR/iud";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCSEAKnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B3321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IW+pzceCZzbH/dIwxS5J0LWWiS2mMKCwgWwcQaJFsxI=; b=COgR/iudnCZNqj
	0l2SHkg1synVuTovP4iYgOdpPOLxYmS5UDe6i3ip76JRVndQqei6P6h8L2yya+PMa396tO9Jc1Mv8
	oZK+JJH5xmv91zirjQjkuaNyDGPcD22KH/UxNtv6FsCPmcwAeg8Us3fWR7UA9OqlU/tk8g4cPMZkZ
	yYNmifnU3ARxLbyD3hV/SP8wMjU12OMEAgdrqZmkI+0Mu8dOYcgn6JYDbk7aLnbuqLPqKbgBPhfv2
	07xCTA6yh0AHPpnuGdO/eUje4Z/6ZFUgBsHhRtVb2HQ1jqtXXlNhvwrUhSM/3NyKpwVdDBREKq0Lr
	G38w/tLJ+3qrHljPOe9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gg3lq-0002hZ-Ht; Sun, 06 Jan 2019 08:26:58 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gg3lm-0002hC-Ka
 for linux-arm-kernel@lists.infradead.org; Sun, 06 Jan 2019 08:26:56 +0000
Received: by mail-it1-x142.google.com with SMTP id x124so4804506itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 00:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3LYR6z0W0JIyMr5pxsP8mOBRvxfidxzH+v2I2FN10pA=;
 b=HCSEAKnOlL5MJdu33zmbFLhxE8Za7PIb+MOCowvG44jhdB4RT2m9ABuaxNLQKxdJRl
 rydBpns6DIIviY/YGPhOmrnrNB96sEpdVwERzeEj/SNxKZChL/hbmGvScxJnfcbQnZtp
 mufeFMnc+N3/fMVt42X+wji7jx5mLf52h10Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3LYR6z0W0JIyMr5pxsP8mOBRvxfidxzH+v2I2FN10pA=;
 b=A7mJLj0TRZEIMhgc3jEk9a5/raaYMaEqDnJUbmT+HRcxpH0h+d+G5838Ki6kLjjMZV
 n38bM8Jlq8m7fpokuQGPFPgPpwKxmSYGsc644MzUKKn0oxvDpzrMtJPe+L1D5TNS4Yam
 xgUOSeaXliToIdkMSFDt1jNL+Wo4VATtwY5Jlzdqi9cKh/hKZhdovqXQSdXqImJT6RWW
 SJC+eYjba2VbqllZ4j/PIO3997gsi1cGC23xIn0UoqplR50tFvP5I6itY9WeFvHL0fE/
 SoueQKmFl+3FCFat4n5kM0bGkGwANzDgugdmvpls/6cfiWE0njGF4W9yh0/Y23S3fUkj
 85Fw==
X-Gm-Message-State: AJcUukewe8cAJVH4yKxmTIZQrLcp3nDZ0vNRLPEd+WSCL1TOB6TlPs9j
 D8xZGRBlrJ2AYjwrbEFPRsgJbZQjktZQZn0cbHVHsg==
X-Google-Smtp-Source: ALg8bN5EnDAPaG7pAOBt7HLN0VrrUqDg51XA5aa9PGH9C0cp2WRZlVhoRVCpnMP2NegupfiJnPjoAEL3KGFMdOurM+A=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr4916519itk.71.1546763211632; 
 Sun, 06 Jan 2019 00:26:51 -0800 (PST)
MIME-Version: 1.0
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
In-Reply-To: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 6 Jan 2019 09:26:39 +0100
Message-ID: <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: Lingyan Huang <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_002654_694608_6BAD1793 
X-CRM114-Status: GOOD (  26.16  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 6 Jan 2019 at 02:56, Lingyan Huang <huanglingyan2@huawei.com> wrote:
>
> Function do_csum() in lib/checksum.c is used to compute checksum,
> which is turned out to be slowly and costs a lot of resources.
> Let's use neon instructions to accelerate the checksum computation
> for arm64.
>
> ------
> V2 ==> V3:
>     only modify the arm64 codes instead of modifying headers
>     under asm-generic and code in lib/checksum.c.
> ------
> ------
> V1 ==> V2:
>     Change NEON assembly code to NEON intrinsic code which is built
>     on top of arm_neon.h to avoid dropping into assembly.
> ------
>

Please put the changelog between the --- below and the diffstat

> Here is the comparison results of function ip_compute_csum() between
> general do_csum() and neon instruction do_csum(). The test platform
> is HUAWEI 1620 server with TAISHAN cores.
>
>         len(1000cycle)      general(ns)        do_csum_neon(ns)
>           64B:                58060                 59460
>          128B:                82930                 83930
>          256B:               132480                 73570
>          512B:               230100                 86230
>         1024B:               426600                 98200
>

Again, very nice performance. How did you test for correctness?

>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Lingyan Huang <huanglingyan2@huawei.com>
> ---
>  arch/arm64/include/asm/checksum.h |   5 ++
>  arch/arm64/lib/Makefile           |   8 +--
>  arch/arm64/lib/checksum.c         |  26 ++++++++
>  arch/arm64/lib/do_csum.c          | 136 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 171 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/lib/checksum.c
>  create mode 100644 arch/arm64/lib/do_csum.c
>
> diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
> index 0b6f5a7..7acd713 100644
> --- a/arch/arm64/include/asm/checksum.h
> +++ b/arch/arm64/include/asm/checksum.h
> @@ -26,6 +26,10 @@ static inline __sum16 csum_fold(__wsum csum)
>  }
>  #define csum_fold csum_fold
>
> +#define do_csum do_csum
> +unsigned int do_csum(const unsigned char *buff, int len);
> +extern unsigned int do_csum_arm(const unsigned char *buff, int len);
> +
>  static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  {
>         __uint128_t tmp;
> @@ -46,6 +50,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  }
>  #define ip_fast_csum ip_fast_csum
>
> +

Drop this whitespace-only change

>  #include <asm-generic/checksum.h>
>
>  #endif /* __ASM_CHECKSUM_H */
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 5540a16..c0b5b8c 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -3,12 +3,12 @@ lib-y         := clear_user.o delay.o copy_from_user.o                \
>                    copy_to_user.o copy_in_user.o copy_page.o            \
>                    clear_page.o memchr.o memcpy.o memmove.o memset.o    \
>                    memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
> -                  strchr.o strrchr.o tishift.o
> +                  strchr.o strrchr.o tishift.o checksum.o
>
>  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> -obj-$(CONFIG_XOR_BLOCKS)       += xor-neon.o
> -CFLAGS_REMOVE_xor-neon.o       += -mgeneral-regs-only
> -CFLAGS_xor-neon.o              += -ffreestanding
> +obj-y    += do_csum.o

Please indent aligned with the others

> +CFLAGS_REMOVE_do_csum.o        += -mgeneral-regs-only
> +CFLAGS_do_csum.o               += -ffreestanding
>  endif
>
>  # Tell the compiler to treat all general purpose registers (with the
> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
> new file mode 100644
> index 0000000..15a31bb
> --- /dev/null
> +++ b/arch/arm64/lib/checksum.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
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
> +
> +#define CSUM_NEON_THRESHOLD 128
> +
> +unsigned int do_csum(const unsigned char *buff, int len)
> +{
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +       if (len >= CSUM_NEON_THRESHOLD)

Please change this into

if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
    len >= CSUM_NEON_THRESHOLD &&
    may_use_simd()) {
        kernel_neon_begin();
        res = do_csum_neon(buff, len);
        kernel_neon_end();
    }

and drop the intermediate do_csum_arm()

> +               return do_csum_arm(buff, len);
> +#endif  /* CONFIG_KERNEL_MODE_NEON */

No else? What happens if len < CSUM_NEON_THRESHOLD ?

> +#undef do_csum

Can we drop this?

> +       return 0;
> +}
> diff --git a/arch/arm64/lib/do_csum.c b/arch/arm64/lib/do_csum.c
> new file mode 100644
> index 0000000..893583f
> --- /dev/null
> +++ b/arch/arm64/lib/do_csum.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
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

Drop this - it is not used in this file

> +#ifdef CONFIG_KERNEL_MODE_NEON

This file is only built if KERNEL_MODE_NEON=y so the #ifdef can be dropped

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
> +unsigned int do_csum_neon(const unsigned char *buff, int len)
> +{
> +       unsigned int odd, count;
> +       uint64_t result = 0;
> +       unsigned int count64;
> +       uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
> +
> +       register uint32x4_t v0, v1, v2, v3;
> +
> +       if (unlikely(len <= 0))
> +               return result;
> +
> +       odd = 1 & (unsigned long)buff;
> +       if (unlikely(odd)) {
> +               result = *buff;
> +               len--;
> +               buff++;
> +       }
> +
> +       count = len >> 1;
> +       if (count) {
> +               if (2 & (unsigned long)buff) {
> +                       result += *(unsigned short *)buff;
> +                       count--;
> +                       len -= 2;
> +                       buff += 2;
> +               }
> +               count >>= 1;            /* nr of 32-bit words.. */
> +               if (count) {
> +                       if (4 & (unsigned long)buff) {
> +                               result += *(unsigned int *)buff;
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
> +                               result += *(unsigned long long *)buff;
> +                               buff += 8;
> +                       }
> +                       if (len & 4) {
> +                               result += *(unsigned int *)buff;
> +                               buff += 4;
> +                       }
> +               }
> +               if (len & 2) {
> +                       result += *(unsigned short *)buff;
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
> +unsigned int do_csum_arm(const unsigned char *buff, int len)
> +{
> +       unsigned int res;
> +
> +       kernel_neon_begin();
> +       res = do_csum_neon(buff, len);
> +       kernel_neon_end();
> +       return res;
> +}

As I said above, please drop this intermediate function and fold the
logic into do_csum()

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
