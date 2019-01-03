Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA84C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AFA20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPd8dvtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AFA20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=spZbPH6J0PTRQrnLCynJbBOEyaQlx+z1n+u5DodsdiI=; b=RPd8dvtV3/IbDt
	M/B/Ho/Wsnr3y3/8M50Rf/GBXs0tGUHNCK096saNl3bn3IVttrXz7PNYGubaROmgWe4c5hdgqMI4Q
	RGWUjWfn3V7mM+5mR35mCvOr5/4TujjZU+cT0b/L/ITlm9HSm1S9h/YmgAPDaLNBqjTgpv5cmtIHN
	4NfxInJP1SvLKSaLi13C955EqyEZ3S30pAcvmekZ5/V6QBmAaMy53PlQL6fQuB55mvlliFCwKiMyh
	dMIv0mhj7VRZTvZjFQzTrVx+Fpa0pkDu6RvYLxUC1oEfmMq83F3Vxb5c34iM+TOLoPXEnx/wwULh6
	Bglo8u2tTd0fnP+22cRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gevBk-0008OA-8v; Thu, 03 Jan 2019 05:05:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gevBh-0008NZ-4c
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 05:04:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 132CBEBD;
 Wed,  2 Jan 2019 21:04:51 -0800 (PST)
Received: from [10.163.1.51] (unknown [10.163.1.51])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A431C3F5D4;
 Wed,  2 Jan 2019 21:04:43 -0800 (PST)
Subject: Re: [RESEND PATCH V3 0/5] arm64/mm: Enable HugeTLB migration
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c2fbd55e-4413-1bcf-769c-fd1064e74a2c@arm.com>
Date: Thu, 3 Jan 2019 10:34:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_210457_185933_644BDDF7 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: steve.capper@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
 will.deacon@arm.com, mhocko@kernel.org, akpm@linux-foundation.org,
 Steven.Price@arm.com, n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/18/2018 01:54 PM, Anshuman Khandual wrote:
> This patch series enables HugeTLB migration support for all supported
> huge page sizes at all levels including contiguous bit implementation.
> Following HugeTLB migration support matrix has been enabled with this
> patch series. All permutations have been tested except for the 16GB.
> 
>          CONT PTE    PMD    CONT PMD    PUD
>          --------    ---    --------    ---
> 4K:         64K     2M         32M     1G
> 16K:         2M    32M          1G
> 64K:         2M   512M         16G
> 
> First the series adds migration support for PUD based huge pages. It
> then adds a platform specific hook to query an architecture if a
> given huge page size is supported for migration while also providing
> a default fallback option preserving the existing semantics which just
> checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
> HugeTLB migration on arm64 and subscribe to this new platform specific
> hook by defining an override.
> 
> The second patch differentiates between movability and migratability
> aspects of huge pages and implements hugepage_movable_supported() which
> can then be used during allocation to decide whether to place the huge
> page in movable zone or not.
> 
> This is just a resend for the previous version (V3) after the rebase
> on current mainline kernel. Also added all the tags previous version
> had received.
> 
> Changes in V3:
> 
> - Re-ordered patches 1 and 2 per Michal
> - s/Movability/Migratability/ in unmap_and_move_huge_page() per Naoya
> 
> Changes in V2: (https://lkml.org/lkml/2018/10/12/190)
> 
> - Added a new patch which differentiates migratability and movability
>   of huge pages and implements hugepage_movable_supported() function
>   as suggested by Michal Hocko.
> 
> Anshuman Khandual (5):
>   mm/hugetlb: Distinguish between migratability and movability
>   mm/hugetlb: Enable PUD level huge page migration
>   mm/hugetlb: Enable arch specific huge page size support for migration
>   arm64/mm: Enable HugeTLB migration
>   arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages
> 

Hello Andrew,

Just wondering if there are any updates on this series ? Is there something we need to
improve or fix some where in this series for it to get merged. Please do let us know.
Thank you.

- Anshuman

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
