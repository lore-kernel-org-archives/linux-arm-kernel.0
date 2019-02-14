Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85857C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563902229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qzu6qO3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563902229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YB/lWMpqXmWY89xH2wiMMIHy6kcL3EaK9LHHZCWZTq0=; b=qzu6qO3CY/jJz6
	hpWo+Uw0CNpO8loZTTWTpbxvPoieuuNQ5vO5aSqgoQ93RizHy27NoFvMdttwpoP725UbVocUAsx6d
	eX4xVn4KKEjVHu872a1kV7i11ZFt6uKUVhfclXFofxggscc3ozgHzGv8ydgl8QBTUkOF/Wfl8FlhL
	ueWaht7jM6/iVZNmkSeok3tzOhmqLXJTtdi2Kp4ib625h5pJLffgXi7OQ6MvgyWUMv2LVjQpMJYBx
	eRTgQMgx5GjdCcGy5mV7t9IJxDWYXilNrJD6s/vYKcQC5MbsB7jjIt+eNq4C5lm1jB4A7ApBMnyHP
	ebfsaNOocOyp6MiBxcPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCT9-0002TJ-Es; Thu, 14 Feb 2019 08:34:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCT5-0002Sg-5I
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:34:04 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1E8PAxE051345
 for <linux-arm-kernel@lists.infradead.org>; Thu, 14 Feb 2019 03:34:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qn2159st5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Thu, 14 Feb 2019 03:34:00 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Thu, 14 Feb 2019 08:33:57 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Feb 2019 08:33:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1E8XrT9655744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 08:33:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0743A405B;
 Thu, 14 Feb 2019 08:33:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10414A4054;
 Thu, 14 Feb 2019 08:33:53 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 14 Feb 2019 08:33:52 +0000 (GMT)
Date: Thu, 14 Feb 2019 10:33:51 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2] arm64: account for GICv3 LPI tables in static
 memblock reserve table
References: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
 <20190213132738.10294-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213132738.10294-2-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021408-0028-0000-0000-000003486E53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021408-0029-0000-0000-0000240698F2
Message-Id: <20190214083350.GA9063@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003403_312942_0E2B20B7 
X-CRM114-Status: GOOD (  34.78  )
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
Cc: linux-efi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-mm@kvack.org, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 02:27:37PM +0100, Ard Biesheuvel wrote:
> In the irqchip and EFI code, we have what basically amounts to a quirk
> to work around a peculiarity in the GICv3 architecture, which permits
> the system memory address of LPI tables to be programmable only once
> after a CPU reset. This means kexec kernels must use the same memory
> as the first kernel, and thus ensure that this memory has not been
> given out for other purposes by the time the ITS init code runs, which
> is not very early for secondary CPUs.
> 
> On systems with many CPUs, these reservations could overflow the
> memblock reservation table, and this was addressed in commit
> eff896288872 ("efi/arm: Defer persistent reservations until after
> paging_init()"). However, this turns out to have made things worse,
> since the allocation of page tables and heap space for the resized
> memblock reservation table itself may overwrite the regions we are
> attempting to reserve, which may cause all kinds of corruption,
> also considering that the ITS will still be poking bits into that
> memory in response to incoming MSIs.
> 
> So instead, let's grow the static memblock reservation table on such
> systems so it can accommodate these reservations at an earlier time.
> This will permit us to revert the above commit in a subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/memory.h | 11 +++++++++++
>  include/linux/memblock.h        |  3 ---
>  mm/memblock.c                   | 10 ++++++++--
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index e1ec947e7c0c..7e2b13cdd970 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -332,6 +332,17 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define virt_addr_valid(kaddr)		\
>  	(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
> 
> +/*
> + * Given that the GIC architecture permits ITS implementations that can only be
> + * configured with a LPI table address once, GICv3 systems with many CPUs may
> + * end up reserving a lot of different regions after a kexec for their LPI
> + * tables, as we are forced to reuse the same memory after kexec (and thus
> + * reserve it persistently with EFI beforehand)
> + */
> +#if defined(CONFIG_EFI) && defined(CONFIG_ARM_GIC_V3_ITS)
> +#define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + 2 * NR_CPUS)
> +#endif
> +
>  #include <asm-generic/memory_model.h>
> 
>  #endif
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 64c41cf45590..859b55b66db2 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -29,9 +29,6 @@ extern unsigned long max_pfn;
>   */
>  extern unsigned long long max_possible_pfn;
> 
> -#define INIT_MEMBLOCK_REGIONS	128
> -#define INIT_PHYSMEM_REGIONS	4
> -
>  /**
>   * enum memblock_flags - definition of memory region attributes
>   * @MEMBLOCK_NONE: no special request
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cbb3618..a526c3ab8390 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -26,6 +26,12 @@
> 
>  #include "internal.h"
> 
> +#define INIT_MEMBLOCK_REGIONS		128
> +#define INIT_PHYSMEM_REGIONS		4
> +#ifndef INIT_MEMBLOCK_RESERVED_REGIONS
> +#define INIT_MEMBLOCK_RESERVED_REGIONS	INIT_MEMBLOCK_REGIONS
> +#endif
> +

I'd suggest

s/INIT_MEMBLOCK_REGIONS/INIT_MEMORY_REGIONS
s/INIT_MEMBLOCK_RESERVED_REGIONS/INIT_RESERVED_REGIONS

Except that,

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

>  /**
>   * DOC: memblock overview
>   *
> @@ -92,7 +98,7 @@ unsigned long max_pfn;
>  unsigned long long max_possible_pfn;
> 
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> -static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
> +static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>  static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
>  #endif
> @@ -105,7 +111,7 @@ struct memblock memblock __initdata_memblock = {
> 
>  	.reserved.regions	= memblock_reserved_init_regions,
>  	.reserved.cnt		= 1,	/* empty dummy entry */
> -	.reserved.max		= INIT_MEMBLOCK_REGIONS,
> +	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
>  	.reserved.name		= "reserved",
> 
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
