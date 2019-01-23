Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9956FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687D620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qNCdU8bL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JI0+aiuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687D620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j6KrFIPWTx/FYngIOvuZ8cUp+2/L13M5qeFx1zPkPqo=; b=qNCdU8bLr2Wo2y
	ZSp5HnbDrlYPv1JxzIieLE2z1ormraI4Mr/Dct6vKcVXQ1+u8BAT2kdN0UInu8bD4lrIFOUzfiMaO
	li2gNci2KLaVwSX3jx5fnmJRuIT2LMaAZKvZ8GCalfk0WmoHIx8Lk1D5eDmD0Kzc6d4eOLslDX3tc
	QlDrrEUNGKI5iFjBvVwaTSo0QM/utp74rPxz6fSeb9dlqOsKGpjd8FTQahVm6Lh4zWJqerHWxWahx
	rC4UuTDAkqMXAIXel/NuoyAetHGAMoTSUd8sQIPd5VELHRb0KvK5/9h3QPhWqskpTLks/oTXga8dx
	Sr+ynugPXX4J0kzcrJNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJQs-0008Nu-A1; Wed, 23 Jan 2019 14:23:10 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJQp-0008N6-KP
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 14:23:09 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NEJH3B054119;
 Wed, 23 Jan 2019 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mtInZWeP+1nXSBmMf6rmgiXyVE9XvxmUAuy37MI+UwY=;
 b=JI0+aiuBb0WsolFazGJpEpyEyyB3xA8g/w8jK5piT+iXIyZv6jvTelIVUdWt6wI396Or
 qIn6//z0LA0EM+cuTP4DmQWHHi6g5RbUEuHPevNTsYkel8t0s5ZPxgEsdRYVZglKq9x4
 7f8/khoSLYpL0VIL9UWRc6dOpFwN6M1oc1CFY4ypIi0kJzaksMU+zaEjjzIoaOzGYM1l
 SdzFv6Ye8da3H7HeBMkC10IJ3DY35T1H2sbinbTxsOhBDud5E8OyRZkuahV6OgsnL8zl
 ZKB6HWukA3XFkuh/fZ8fzPYf05178nUUBHcl6R17h6bhRlP7zNG5DERZAczssw7i+pfc jg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2q3sdej8s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 14:21:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NELjCD026616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jan 2019 14:21:45 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NELi9t014770;
 Wed, 23 Jan 2019 14:21:44 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 23 Jan 2019 06:21:44 -0800
Date: Wed, 23 Jan 2019 09:20:49 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v7 05/16] arm64/mm: Add support for XPFO
Message-ID: <20190123142047.GB19289@Konrads-MacBook-Pro.local>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_062307_878537_A666C46D 
X-CRM114-Status: GOOD (  23.53  )
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
Cc: Tycho Andersen <tycho@docker.com>, kernel-hardening@lists.openwall.com,
 linux-mm@kvack.org, deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, tycho@tycho.ws,
 ak@linux.intel.com, hch@lst.de, kanth.ghatraju@oracle.com, jsteckli@amazon.de,
 pradeep.vincent@oracle.com, jcm@redhat.com, liran.alon@oracle.com,
 tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, juergh@gmail.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 dwmw@amazon.co.uk, keescook@google.com, torvalds@linux-foundation.org,
 kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 02:09:37PM -0700, Khalid Aziz wrote:
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> Enable support for eXclusive Page Frame Ownership (XPFO) for arm64 and
> provide a hook for updating a single kernel page table entry (which is
> required by the generic XPFO code).
> 
> v6: use flush_tlb_kernel_range() instead of __flush_tlb_one()
> 
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/arm64/Kconfig     |  1 +
>  arch/arm64/mm/Makefile |  2 ++
>  arch/arm64/mm/xpfo.c   | 58 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 arch/arm64/mm/xpfo.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..f0a9c0007d23 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -171,6 +171,7 @@ config ARM64
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select ARCH_SUPPORTS_XPFO
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 849c1df3d214..cca3808d9776 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -12,3 +12,5 @@ KASAN_SANITIZE_physaddr.o	+= n
>  
>  obj-$(CONFIG_KASAN)		+= kasan_init.o
>  KASAN_SANITIZE_kasan_init.o	:= n
> +
> +obj-$(CONFIG_XPFO)		+= xpfo.o
> diff --git a/arch/arm64/mm/xpfo.c b/arch/arm64/mm/xpfo.c
> new file mode 100644
> index 000000000000..678e2be848eb
> --- /dev/null
> +++ b/arch/arm64/mm/xpfo.c
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
> + * Copyright (C) 2016 Brown University. All rights reserved.
> + *
> + * Authors:
> + *   Juerg Haefliger <juerg.haefliger@hpe.com>
> + *   Vasileios P. Kemerlis <vpk@cs.brown.edu>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +
> +#include <asm/tlbflush.h>
> +
> +/*
> + * Lookup the page table entry for a virtual address and return a pointer to
> + * the entry. Based on x86 tree.
> + */
> +static pte_t *lookup_address(unsigned long addr)

The x86 also has level. Would it make sense to include that in here?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
