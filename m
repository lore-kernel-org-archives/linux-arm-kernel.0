Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33174C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:15:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E906F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrAW7z7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E906F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aeXFj7oVCv/Bg+2WRU45QbWZJtENtT9cJPiZq4aEQbQ=; b=rrAW7z7EMaF7AanRNlQ80m46K
	INFLkEkxrjM5DsSLBJw8EMEIshRvAJAWkRl7G8fQSdNGG7ZIe8ysC8RaEJ729WPir7UPFUmYZLvgk
	3sjnwhua/pIOg2E55yg/6lhxJ/NWBaANqdsQ7SOrvzsBt+78GZlxhTWWpqJ5bumLALu+gJBnT4b4i
	dnN6UBZpxHQPs2wnZUXcBPNa22TOREN9N/lgHTjBS0XryjeQi00wjTtQnA6X9kliyn9WsHDKLPDPZ
	T4jK9/MhKgphOoL0nE+8Dmg5m9vuCMvZqFZ1piYOHYAp1zq8up75xHOzddcVQ0EylA5ShRWJLuwVE
	tRAJlr4HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4MN-0004WC-Af; Wed, 12 Dec 2018 13:15:31 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4MK-0004V2-7C
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:15:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3C31A78;
 Wed, 12 Dec 2018 05:15:17 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29BA53F614;
 Wed, 12 Dec 2018 05:15:17 -0800 (PST)
Subject: Re: [PATCH] arm64: add <asm/asm-prototypes.h>
To: Mark Rutland <mark.rutland@arm.com>, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org
References: <20181212122219.29552-1-mark.rutland@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56035abc-53b8-ef58-6176-52cfd3db65a7@arm.com>
Date: Wed, 12 Dec 2018 13:15:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212122219.29552-1-mark.rutland@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_051528_260963_98B60C53 
X-CRM114-Status: GOOD (  23.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 12:22, Mark Rutland wrote:
> While we can export symbols from assembly files, CONFIG_MODVERIONS requires C
> declarations of anyhting that's exported.
> 
> Let's account for this as other architectures do by placing these declarations
> in <asm/asm-prototypes.h>, which kbuild will automatically use to generate
> modversion information for assembly files.
> 
> Since we already define most prototypes in existing headers, we simply need to
> include those headers in <asm/asm-prototypes.h>, and don't need to duplicate
> these.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/asm-prototypes.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 arch/arm64/include/asm/asm-prototypes.h
> 
> Hi Will,
> 
> I believe this covers all assembly exports for an arm64 allmodconfig. My laptop
> is rather slow at building all of that, so I can't confirm just yet, but I
> thought it was better to send this out in the mean time (or in case you can
> verify that locally).
> 
> Mark.
> 
> diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
> new file mode 100644
> index 000000000000..597434ea857d
> --- /dev/null
> +++ b/arch/arm64/include/asm/asm-prototypes.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PROTOTYPES_H
> +#define __ASM_PROTOTYPES_H
> +/*
> + * CONFIG_MODEVERIONS requires a C declaration to generate the appropriate CRC
> + * for each symbol. Since commit:
> + *
> + *   4efca4ed05cbdfd1 ("kbuild: modversions for EXPORT_SYMBOL() for asm")
> + *
> + * ... kbuild will automatically pick these up from <asm/asm-prototypes.h> and
> + * feed this to genksyms when building assembly files.
> + */
> +#include <linux/arm-smccc.h>
> +
> +#include <asm/ftrace.h>
> +#include <asm/string.h>

This is virtually identical to what I came up with in parallel, except I 
had <asm/page.h> here instead - I guess this still manages to pick up 
clear_page and copy_page transitively (and mine got lucky for memcmp and 
friends), but I guess it would be safer to explicitly add that as well.

With that change,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +#include <asm/uaccess.h>
> +
> +#include <asm-generic/asm-prototypes.h>
> +
> +long long __ashlti3(long long a, int b);
> +long long __ashrti3(long long a, int b);
> +long long __lshrti3(long long a, int b);
> +
> +#endif /* __ASM_PROTOTYPES_H */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
