Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24177206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VzqS2m9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24177206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=veVAAa0or+FnS+PCrGT08hAANf97TMDL2sqlOVrJ9Zo=; b=VzqS2m9voC2BSh
	GbK6CNn+4JBzqsNkq1NMvFWBcwS9Kwt8JZRvGp3IABMdQHIZBecuKz4Wbpp5P0+mY990rQAlQGnrv
	EuEfLRPPHmBTrFMYXGML+jcUBm8OJqvtZhpOvxIta+/sblC+LRdZkzHd7czFa+K8of+6sgcnv+oLd
	NXNHZBIH4TQ/XsIiEjnpmYE89VgjqbUk3Y2M24jls291M5+KCgbg6xqdeDq+zwC+Ym6VpO31b4OhW
	G28Vz/b4J5oJ9H35m7Mtn3tRFhsm1cx2NowRI59mlxMD1CN+zjaz6jJUwVU27DkUGYPKnUhNo7BAb
	6AQQ4xkSkB5Vp1iuogYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFJ8-00087P-6Q; Wed, 09 Jan 2019 14:58:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFJ4-00086h-30
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:58:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9288680D;
 Wed,  9 Jan 2019 06:58:09 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1EA3F694;
 Wed,  9 Jan 2019 06:58:08 -0800 (PST)
Date: Wed, 9 Jan 2019 14:58:02 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Lingyan Huang <huanglingyan2@huawei.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
Message-ID: <20190109142513.GA3554@e103592.cambridge.arm.com>
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_065810_139714_DC18F088 
X-CRM114-Status: GOOD (  35.20  )
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
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 06, 2019 at 09:55:29AM +0800, Lingyan Huang wrote:
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

For testing purposes, you would need to cover all possible aligments of
buff and all values of (len % 16), as well as testing on big- and
little-endian.

Otherwise, a lot of code for handling edge cases won't be tested.


Also, it would be interesting to know which sizes are actually most
common at runtime, to avoid falling into the trap of optimising for
rare cases at the expense of the more common cases.

You could try adding some instrumentation to collect some statistics on
this.

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
>  	__uint128_t tmp;
> @@ -46,6 +50,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  }
>  #define ip_fast_csum ip_fast_csum
>  
> +
>  #include <asm-generic/checksum.h>
>  
>  #endif	/* __ASM_CHECKSUM_H */
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 5540a16..c0b5b8c 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -3,12 +3,12 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
>  		   copy_to_user.o copy_in_user.o copy_page.o		\
>  		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
>  		   memcmp.o strcmp.o strncmp.o strlen.o strnlen.o	\
> -		   strchr.o strrchr.o tishift.o
> +		   strchr.o strrchr.o tishift.o checksum.o
>  
>  ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
> -obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> -CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
> -CFLAGS_xor-neon.o		+= -ffreestanding

Did you mean to delete these lines?

> +obj-y    += do_csum.o
> +CFLAGS_REMOVE_do_csum.o	+= -mgeneral-regs-only
> +CFLAGS_do_csum.o		+= -ffreestanding
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
> +	if (len >= CSUM_NEON_THRESHOLD)
> +		return do_csum_arm(buff, len);
> +#endif  /* CONFIG_KERNEL_MODE_NEON */
> +#undef do_csum
> +	return 0;
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

Unless you call may_use_simd() (see below) I can't see why you need to
include <asm/simd.h>.

> +#include <asm/checksum.h>
> +#include <asm/byteorder.h>
> +#include <asm/neon-intrinsics.h>
> +
> +#define CSUM_NEON_THRESHOLD 128
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +static inline u32 from64to16(u64 x)
> +{
> +	/* add up 32-bit and 32-bit for 32+c bit */
> +	x = (x & 0xffffffff) + (x >> 32);
> +	/* add up carry.. */
> +	x = (x & 0xffffffff) + (x >> 32);
> +	/* add up 16-bit and 16-bit for 16+c bit */
> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
> +	/* add up carry.. */
> +	x = ((u32)x & 0xffff) + ((u32)x >> 16);
> +	return x;
> +}
> +
> +unsigned int do_csum_neon(const unsigned char *buff, int len)
> +{
> +	unsigned int odd, count;
> +	uint64_t result = 0;
> +	unsigned int count64;
> +	uint32x4_t vzero = (uint32x4_t){0, 0, 0, 0};
> +
> +	register uint32x4_t v0, v1, v2, v3;

Is "register" needed here?  Is there any impact on performance?

Usually it's best to leave register allocation decisions up to the
compiler.

> +
> +	if (unlikely(len <= 0))
> +		return result;
> +
> +	odd = 1 & (unsigned long)buff;
> +	if (unlikely(odd)) {
> +		result = *buff;

The generic code has a shift here for the little-endian case.  Why don't
we need that here?

> +		len--;
> +		buff++;
> +	}
> +
> +	count = len >> 1;
> +	if (count) {
> +		if (2 & (unsigned long)buff) {
> +			result += *(unsigned short *)buff;
> +			count--;
> +			len -= 2;
> +			buff += 2;
> +		}
> +		count >>= 1;            /* nr of 32-bit words.. */
> +		if (count) {
> +			if (4 & (unsigned long)buff) {
> +				result += *(unsigned int *)buff;
> +				count--;
> +				len -= 4;
> +				buff += 4;
> +			}
> +			count >>= 1;    /* nr of 64-bit words.. */
> +
> +			v0 = vzero;
> +			v1 = vzero;
> +			v2 = vzero;
> +			v3 = vzero;
> +
> +			count64 = count >> 3;  /* compute 64 Byte circle */
> +			while (count64) {
> +				v0 = vpadalq_u16(v0,
> +					vld1q_u16((uint16_t *)buff + 0));

Can this loop iterate more than 65536 times?  If it can, it looks like
we can overflow.

(I think the initial value of len would have to be > 0x400000 in order
for this to happen.)

> +				v1 = vpadalq_u16(v1,
> +					vld1q_u16((uint16_t *)buff + 8));
> +				v2 = vpadalq_u16(v2,
> +					vld1q_u16((uint16_t *)buff + 16));
> +				v3 = vpadalq_u16(v3,
> +					vld1q_u16((uint16_t *)buff + 24));
> +				buff += 64;
> +				count64--;
> +			}
> +			v0 = vaddq_u32(v0, v1);
> +			v2 = vaddq_u32(v2, v3);
> +			v0 = vaddq_u32(v0, v2);

Can't we defer the folding down until later?  We could just accumulate
the next 16 bytes' result into v0, and do the folding all in one go
later on.

> +
> +			count %= 8;
> +			while (count >= 2) { /* compute 16 byte circle */
> +				v0 = vpadalq_u16(v0,
> +					vld1q_u16((uint16_t *)buff + 0));
> +				buff += 16;
> +				count -= 2;
> +			}
> +
> +			result += vgetq_lane_u32(v0, 0);
> +			result += vgetq_lane_u32(v0, 1);
> +			result += vgetq_lane_u32(v0, 2);
> +			result += vgetq_lane_u32(v0, 3);
> +			if (count & 1) {
> +				result += *(unsigned long long *)buff;
> +				buff += 8;
> +			}
> +			if (len & 4) {
> +				result += *(unsigned int *)buff;
> +				buff += 4;
> +			}
> +		}
> +		if (len & 2) {
> +			result += *(unsigned short *)buff;
> +			buff += 2;
> +		}
> +	}
> +	if (len & 1)
> +		result += *buff;

What about the little-endian case?

> +	result = from64to16(result);
> +	if (odd)
> +		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> +	return result;
> +}
> +#endif
> +
> +
> +unsigned int do_csum_arm(const unsigned char *buff, int len)
> +{
> +	unsigned int res;
> +
> +	kernel_neon_begin();
> +	res = do_csum_neon(buff, len);

If len can be large, you should split into smaller blocks, with
kernel_neon_end()/_begin() between to provide a change to preempt if len
is large.  (Splitting into smaller blocks may also help avoid overflow.)

Ard may have may able to suggest how often this should be done.

Also, there is no guarantee that you can use NEON in softirq context,
because the kernel may already have been using NEON when the softirq
fired.  If this code may get called from softirq context, then you would
need something along the lines of

	if (may_use_simd()) {
		kernel_neon_begin();
		/* NEON accelerated code */
		kernel_neon_end();
	} else {
		/* Fallback C code */
	}

[...]

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
