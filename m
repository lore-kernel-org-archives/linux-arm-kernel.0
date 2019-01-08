Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4522A20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q723u0SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4522A20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iSceAP8AS0ktWkdIZdDghZZZblL/LMgcBEgislWbipo=; b=Q723u0SCTjbXSK
	Tns5L3dM5bSe0ixcEoVMijG6JeLG2aWLEcv2jRyKoi+0I3ZZ+zrlSIgqZdXOl0eAMFw+07XzMvctJ
	CnNWgt3dT9ACNJnOujbN9lbLv2D4b0USrEAkgFCB3jaSMXicdRfNDZvsJBYF0IzYBVSNM9O6pz/ds
	8VeYMyzIQk3sjlGjWEQPHaaq7FllGh2lNjR6hIYMh3PizIALQaVmHCHatDtiZmde3GPTCjsNGBuqk
	P3BezIXvvkWUTOxUx/AA2QsrlnnkNhZKgeKC87H8QALWWeMY6Y3dFcPPFKPkkQHJbam5bZ/BLSmza
	oMFAwQufFUVQMw7KCFLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsIT-0001RQ-Ni; Tue, 08 Jan 2019 14:24:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsIO-0001QK-TR
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:23:59 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x08EKE48064676
 for <linux-arm-kernel@lists.infradead.org>; Tue, 8 Jan 2019 09:23:55 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pvurc6apx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Tue, 08 Jan 2019 09:23:54 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Tue, 8 Jan 2019 14:23:52 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 8 Jan 2019 14:23:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x08ENjnw56295606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 14:23:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B191A4054;
 Tue,  8 Jan 2019 14:23:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B5E5A405C;
 Tue,  8 Jan 2019 14:23:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.241])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Jan 2019 14:23:43 +0000 (GMT)
Date: Tue, 8 Jan 2019 16:23:41 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4 1/6] powerpc: prefer memblock APIs returning virtual
 address
References: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
 <1546248566-14910-2-git-send-email-rppt@linux.ibm.com>
 <282fd5d1-24b5-81ac-b7ff-7329fe3c0fe1@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <282fd5d1-24b5-81ac-b7ff-7329fe3c0fe1@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19010814-0012-0000-0000-000002E3F66B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010814-0013-0000-0000-0000211B03C6
Message-Id: <20190108142341.GA14063@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_062357_075912_6B74FEEB 
X-CRM114-Status: GOOD (  30.27  )
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
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Jan 08, 2019 at 11:02:24AM +0100, Christophe Leroy wrote:
> =

> Le 31/12/2018 =E0 10:29, Mike Rapoport a =E9crit=A0:
> >There are a several places that allocate memory using memblock APIs that
> >return a physical address, convert the returned address to the virtual
> >address and frequently also memset(0) the allocated range.
> >
> >Update these places to use memblock allocators already returning a virtu=
al
> >address. Use memblock functions that clear the allocated memory instead =
of
> >calling memset(0) where appropriate.
> >
> >The calls to memblock_alloc_base() that were not followed by memset(0) a=
re
> >replaced with memblock_alloc_try_nid_raw(). Since the latter does not
> >panic() when the allocation fails, the appropriate panic() calls are add=
ed
> >to the call sites.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/powerpc/kernel/paca.c             | 16 ++++++----------
> >  arch/powerpc/kernel/setup_64.c         | 24 ++++++++++--------------
> >  arch/powerpc/mm/hash_utils_64.c        |  6 +++---
> >  arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
> >  arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
> >  arch/powerpc/mm/pgtable-radix.c        | 25 +++++++------------------
> >  arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
> >  arch/powerpc/platforms/pseries/setup.c | 18 ++++++++++++++----
> >  arch/powerpc/sysdev/dart_iommu.c       |  7 +++++--
> >  9 files changed, 51 insertions(+), 63 deletions(-)
> >
> >diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> >index 913bfca..276d36d4 100644
> >--- a/arch/powerpc/kernel/paca.c
> >+++ b/arch/powerpc/kernel/paca.c
> >@@ -27,7 +27,7 @@
> >  static void *__init alloc_paca_data(unsigned long size, unsigned long =
align,
> >  				unsigned long limit, int cpu)
> >  {
> >-	unsigned long pa;
> >+	void *ptr;
> >  	int nid;
> >  	/*
> >@@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long si=
ze, unsigned long align,
> >  		nid =3D early_cpu_to_node(cpu);
> >  	}
> >-	pa =3D memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
> >-	if (!pa) {
> >-		pa =3D memblock_alloc_base(size, align, limit);
> >-		if (!pa)
> >-			panic("cannot allocate paca data");
> >-	}
> >+	ptr =3D memblock_alloc_try_nid(size, align, MEMBLOCK_LOW_LIMIT,
> >+				     limit, nid);
> >+	if (!ptr)
> >+		panic("cannot allocate paca data");
> =

> AFAIKS, memblock_alloc_try_nid() panics if memblock_alloc_internal() retu=
rns
> NULL, so the above panic is useless, isn't it ?
 =

My plan is to make all memblock_alloc() APIs to return NULL rather then
panic and then get rid of _nopanic variants. It's currently WIP and
hopefully I'll have the patches ready next week.

> >  	if (cpu =3D=3D boot_cpuid)
> >  		memblock_set_bottom_up(false);
> >-	return __va(pa);
> >+	return ptr;
> >  }
> >  #ifdef CONFIG_PPC_PSERIES
> >@@ -118,7 +116,6 @@ static struct slb_shadow * __init new_slb_shadow(int=
 cpu, unsigned long limit)
> >  	}
> >  	s =3D alloc_paca_data(sizeof(*s), L1_CACHE_BYTES, limit, cpu);
> >-	memset(s, 0, sizeof(*s));
> >  	s->persistent =3D cpu_to_be32(SLB_NUM_BOLTED);
> >  	s->buffer_length =3D cpu_to_be32(sizeof(*s));
> >@@ -222,7 +219,6 @@ void __init allocate_paca(int cpu)
> >  	paca =3D alloc_paca_data(sizeof(struct paca_struct), L1_CACHE_BYTES,
> >  				limit, cpu);
> >  	paca_ptrs[cpu] =3D paca;
> >-	memset(paca, 0, sizeof(struct paca_struct));
> >  	initialise_paca(paca, cpu);
> >  #ifdef CONFIG_PPC_PSERIES
> >diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_=
64.c
> >index 236c115..3dcd779 100644
> >--- a/arch/powerpc/kernel/setup_64.c
> >+++ b/arch/powerpc/kernel/setup_64.c
> >@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
> >  static void *__init alloc_stack(unsigned long limit, int cpu)
> >  {
> >-	unsigned long pa;
> >+	void *ptr;
> >  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
> >-	pa =3D memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> >-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> >-	if (!pa) {
> >-		pa =3D memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> >-		if (!pa)
> >-			panic("cannot allocate stacks");
> >-	}
> >+	ptr =3D memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
> >+				     MEMBLOCK_LOW_LIMIT, limit,
> >+				     early_cpu_to_node(cpu));
> >+	if (!ptr)
> >+		panic("cannot allocate stacks");
> =

> Same ?
> =

> Christophe
> =

> >-	return __va(pa);
> >+	return ptr;
> >  }
> >  void __init irqstack_early_init(void)
> >@@ -739,20 +737,17 @@ void __init emergency_stack_init(void)
> >  		struct thread_info *ti;
> >  		ti =3D alloc_stack(limit, i);
> >-		memset(ti, 0, THREAD_SIZE);
> >  		emerg_stack_init_thread_info(ti, i);
> >  		paca_ptrs[i]->emergency_sp =3D (void *)ti + THREAD_SIZE;
> >  #ifdef CONFIG_PPC_BOOK3S_64
> >  		/* emergency stack for NMI exception handling. */
> >  		ti =3D alloc_stack(limit, i);
> >-		memset(ti, 0, THREAD_SIZE);
> >  		emerg_stack_init_thread_info(ti, i);
> >  		paca_ptrs[i]->nmi_emergency_sp =3D (void *)ti + THREAD_SIZE;
> >  		/* emergency stack for machine check exception handling. */
> >  		ti =3D alloc_stack(limit, i);
> >-		memset(ti, 0, THREAD_SIZE);
> >  		emerg_stack_init_thread_info(ti, i);
> >  		paca_ptrs[i]->mc_emergency_sp =3D (void *)ti + THREAD_SIZE;
> >  #endif
> >@@ -933,8 +928,9 @@ static void __ref init_fallback_flush(void)
> >  	 * hardware prefetch runoff. We don't have a recipe for load patterns=
 to
> >  	 * reliably avoid the prefetcher.
> >  	 */
> >-	l1d_flush_fallback_area =3D __va(memblock_alloc_base(l1d_size * 2, l1d=
_size, limit));
> >-	memset(l1d_flush_fallback_area, 0, l1d_size * 2);
> >+	l1d_flush_fallback_area =3D memblock_alloc_try_nid(l1d_size * 2,
> >+						l1d_size, MEMBLOCK_LOW_LIMIT,
> >+						limit, NUMA_NO_NODE);
> >  	for_each_possible_cpu(cpu) {
> >  		struct paca_struct *paca =3D paca_ptrs[cpu];
> >diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_util=
s_64.c
> >index 0cc7fbc..bc6be44 100644
> >--- a/arch/powerpc/mm/hash_utils_64.c
> >+++ b/arch/powerpc/mm/hash_utils_64.c
> >@@ -908,9 +908,9 @@ static void __init htab_initialize(void)
> >  #ifdef CONFIG_DEBUG_PAGEALLOC
> >  	if (debug_pagealloc_enabled()) {
> >  		linear_map_hash_count =3D memblock_end_of_DRAM() >> PAGE_SHIFT;
> >-		linear_map_hash_slots =3D __va(memblock_alloc_base(
> >-				linear_map_hash_count, 1, ppc64_rma_size));
> >-		memset(linear_map_hash_slots, 0, linear_map_hash_count);
> >+		linear_map_hash_slots =3D memblock_alloc_try_nid(
> >+				linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
> >+				ppc64_rma_size,	NUMA_NO_NODE);
> >  	}
> >  #endif /* CONFIG_DEBUG_PAGEALLOC */
> >diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-=
book3e.c
> >index e0ccf36..53cbc7d 100644
> >--- a/arch/powerpc/mm/pgtable-book3e.c
> >+++ b/arch/powerpc/mm/pgtable-book3e.c
> >@@ -57,12 +57,8 @@ void vmemmap_remove_mapping(unsigned long start,
> >  static __ref void *early_alloc_pgtable(unsigned long size)
> >  {
> >-	void *pt;
> >-
> >-	pt =3D __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
> >-	memset(pt, 0, size);
> >-
> >-	return pt;
> >+	return memblock_alloc_try_nid(size, size, MEMBLOCK_LOW_LIMIT,
> >+				      __pa(MAX_DMA_ADDRESS), NUMA_NO_NODE);
> >  }
> >  /*
> >diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtabl=
e-book3s64.c
> >index f3c31f5..55876b7 100644
> >--- a/arch/powerpc/mm/pgtable-book3s64.c
> >+++ b/arch/powerpc/mm/pgtable-book3s64.c
> >@@ -195,11 +195,8 @@ void __init mmu_partition_table_init(void)
> >  	unsigned long ptcr;
> >  	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too la=
rge.");
> >-	partition_tb =3D __va(memblock_alloc_base(patb_size, patb_size,
> >-						MEMBLOCK_ALLOC_ANYWHERE));
> >-
> >  	/* Initialize the Partition Table with no entries */
> >-	memset((void *)partition_tb, 0, patb_size);
> >+	partition_tb =3D memblock_alloc(patb_size, patb_size);
> >  	/*
> >  	 * update partition table control register,
> >diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-r=
adix.c
> >index 9311560..29bcea5 100644
> >--- a/arch/powerpc/mm/pgtable-radix.c
> >+++ b/arch/powerpc/mm/pgtable-radix.c
> >@@ -51,26 +51,15 @@ static int native_register_process_table(unsigned lo=
ng base, unsigned long pg_sz
> >  static __ref void *early_alloc_pgtable(unsigned long size, int nid,
> >  			unsigned long region_start, unsigned long region_end)
> >  {
> >-	unsigned long pa =3D 0;
> >-	void *pt;
> >+	phys_addr_t min_addr =3D MEMBLOCK_LOW_LIMIT;
> >+	phys_addr_t max_addr =3D MEMBLOCK_ALLOC_ANYWHERE;
> >-	if (region_start || region_end) /* has region hint */
> >-		pa =3D memblock_alloc_range(size, size, region_start, region_end,
> >-						MEMBLOCK_NONE);
> >-	else if (nid !=3D -1) /* has node hint */
> >-		pa =3D memblock_alloc_base_nid(size, size,
> >-						MEMBLOCK_ALLOC_ANYWHERE,
> >-						nid, MEMBLOCK_NONE);
> >+	if (region_start)
> >+		min_addr =3D region_start;
> >+	if (region_end)
> >+		max_addr =3D region_end;
> >-	if (!pa)
> >-		pa =3D memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
> >-
> >-	BUG_ON(!pa);
> >-
> >-	pt =3D __va(pa);
> >-	memset(pt, 0, size);
> >-
> >-	return pt;
> >+	return memblock_alloc_try_nid(size, size, min_addr, max_addr, nid);
> >  }
> >  static int early_map_kernel_page(unsigned long ea, unsigned long pa,
> >diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platfo=
rms/pasemi/iommu.c
> >index f297152..f62930f 100644
> >--- a/arch/powerpc/platforms/pasemi/iommu.c
> >+++ b/arch/powerpc/platforms/pasemi/iommu.c
> >@@ -208,7 +208,9 @@ static int __init iob_init(struct device_node *dn)
> >  	pr_debug(" -> %s\n", __func__);
> >  	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
> >-	iob_l2_base =3D (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80=
000000));
> >+	iob_l2_base =3D memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
> >+					MEMBLOCK_LOW_LIMIT, 0x80000000,
> >+					NUMA_NO_NODE);
> >  	pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
> >@@ -269,4 +271,3 @@ void __init iommu_init_early_pasemi(void)
> >  	pasemi_pci_controller_ops.dma_bus_setup =3D pci_dma_bus_setup_pasemi;
> >  	set_pci_dma_ops(&dma_iommu_ops);
> >  }
> >-
> >diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platf=
orms/pseries/setup.c
> >index 41f62ca2..e4f0dfd 100644
> >--- a/arch/powerpc/platforms/pseries/setup.c
> >+++ b/arch/powerpc/platforms/pseries/setup.c
> >@@ -130,8 +130,13 @@ static void __init fwnmi_init(void)
> >  	 * It will be used in real mode mce handler, hence it needs to be
> >  	 * below RMA.
> >  	 */
> >-	mce_data_buf =3D __va(memblock_alloc_base(RTAS_ERROR_LOG_MAX * nr_cpus,
> >-					RTAS_ERROR_LOG_MAX, ppc64_rma_size));
> >+	mce_data_buf =3D memblock_alloc_try_nid_raw(RTAS_ERROR_LOG_MAX * nr_cp=
us,
> >+					RTAS_ERROR_LOG_MAX, MEMBLOCK_LOW_LIMIT,
> >+					ppc64_rma_size, NUMA_NO_NODE);
> >+	if (!mce_data_buf)
> >+		panic("Failed to allocate %d bytes below %pa for MCE buffer\n",
> >+		      RTAS_ERROR_LOG_MAX * nr_cpus, &ppc64_rma_size);
> >+
> >  	for_each_possible_cpu(i) {
> >  		paca_ptrs[i]->mce_data_buf =3D mce_data_buf +
> >  						(RTAS_ERROR_LOG_MAX * i);
> >@@ -140,8 +145,13 @@ static void __init fwnmi_init(void)
> >  #ifdef CONFIG_PPC_BOOK3S_64
> >  	/* Allocate per cpu slb area to save old slb contents during MCE */
> >  	size =3D sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
> >-	slb_ptr =3D __va(memblock_alloc_base(size, sizeof(struct slb_entry),
> >-					   ppc64_rma_size));
> >+	slb_ptr =3D memblock_alloc_try_nid_raw(size, sizeof(struct slb_entry),
> >+					MEMBLOCK_LOW_LIMIT, ppc64_rma_size,
> >+					NUMA_NO_NODE);
> >+	if (!slb_ptr)
> >+		panic("Failed to allocate %zu bytes below %pa for slb area\n",
> >+		      size, &ppc64_rma_size);
> >+
> >  	for_each_possible_cpu(i)
> >  		paca_ptrs[i]->mce_faulty_slbs =3D slb_ptr + (mmu_slb_size * i);
> >  #endif
> >diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart=
_iommu.c
> >index a5b40d1..25bc25f 100644
> >--- a/arch/powerpc/sysdev/dart_iommu.c
> >+++ b/arch/powerpc/sysdev/dart_iommu.c
> >@@ -251,8 +251,11 @@ static void allocate_dart(void)
> >  	 * 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
> >  	 * will blow up an entire large page anyway in the kernel mapping.
> >  	 */
> >-	dart_tablebase =3D __va(memblock_alloc_base(1UL<<24,
> >-						  1UL<<24, 0x80000000L));
> >+	dart_tablebase =3D memblock_alloc_try_nid_raw(SZ_16M, SZ_16M,
> >+					MEMBLOCK_LOW_LIMIT, SZ_2G,
> >+					NUMA_NO_NODE);
> >+	if (!dart_tablebase)
> >+		panic("Failed to allocate 16MB below 2GB for DART table\n");
> >  	/* There is no point scanning the DART space for leaks*/
> >  	kmemleak_no_scan((void *)dart_tablebase);
> >
> =


-- =

Sincerely yours,
Mike.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
