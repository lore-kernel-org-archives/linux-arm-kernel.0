Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:49:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687E02087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N1YAcue9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687E02087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9lR9oCX5vQz4b2uoH8nqJZdATqXrWhya8AiGUYZdVeY=; b=N1YAcue9Fs+jqIUsbSJiCvWa2r
	3vsGXBjHIwwygnY3bv/G0gKSBhrOKajue4PHK7CvkWUvcvxoaUXDp2PHwja4j3CazKEeH2ntwMJUo
	TLRO2qbVYd+Ri+FUNAu5tl4GDdqRd5Tmk+iylPvlHIFx3vSCH2Q4b6GgAoPWiG61/weSbMKpZhDrm
	rQSmnImTfw3oY9GZqONm2VOFuD8jepyyByMAa2IzmrtBNP9RmfOVd56Dq278Kl/nHjddyWHAPUq7Y
	psWVq5rDmMufO0iW1AOCQcz3hCbpAmCDOMy3oAJFrB7EyYCnjs6CgBDGl/QPJ0GJvnxzwZfm/tT+b
	x6z/Tzlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqTX-00009d-HH; Mon, 03 Dec 2018 15:49:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqSf-00071F-OL
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:48:59 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3FlPhW078156
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 10:47:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p56j4bn4q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 10:47:41 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 15:47:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 15:47:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3FlROS59637860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 15:47:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010524C052;
 Mon,  3 Dec 2018 15:47:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B318D4C044;
 Mon,  3 Dec 2018 15:47:23 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 15:47:23 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 03 Dec 2018 17:47:22 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/6] powerpc: prefer memblock APIs returning virtual address
Date: Mon,  3 Dec 2018 17:47:10 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120315-4275-0000-0000-000002EB6069
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120315-4276-0000-0000-000037F86472
Message-Id: <1543852035-26634-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074842_318659_7C7902C0 
X-CRM114-Status: GOOD (  26.97  )
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are a several places that allocate memory using memblock APIs that
return a physical address, convert the returned address to the virtual
address and frequently also memset(0) the allocated range.

Update these places to use memblock allocators already returning a virtual
address; use memblock functions that clear the allocated memory instead of
calling memset(0).

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/kernel/paca.c             | 14 ++++++--------
 arch/powerpc/kernel/setup_64.c         | 21 ++++++++++-----------
 arch/powerpc/mm/hash_utils_64.c        |  6 +++---
 arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
 arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
 arch/powerpc/mm/pgtable-radix.c        | 24 +++++++++---------------
 arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
 arch/powerpc/platforms/pseries/setup.c | 11 +++++++----
 arch/powerpc/sysdev/dart_iommu.c       |  5 +++--
 9 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 913bfca..fa884ad 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -27,7 +27,7 @@
 static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 				unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 	int nid;
 
 	/*
@@ -42,17 +42,15 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 		nid = early_cpu_to_node(cpu);
 	}
 
-	pa = memblock_alloc_base_nid(size, align, limit, nid, MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(size, align, limit);
-		if (!pa)
-			panic("cannot allocate paca data");
-	}
+	ptr = memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
+					 limit, nid);
+	if (!ptr)
+		panic("cannot allocate paca data");
 
 	if (cpu == boot_cpuid)
 		memblock_set_bottom_up(false);
 
-	return __va(pa);
+	return ptr;
 }
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c115..d11ee7f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
 
 static void *__init alloc_stack(unsigned long limit, int cpu)
 {
-	unsigned long pa;
+	void *ptr;
 
 	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
 
-	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
-					early_cpu_to_node(cpu), MEMBLOCK_NONE);
-	if (!pa) {
-		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
-		if (!pa)
-			panic("cannot allocate stacks");
-	}
+	ptr = memblock_alloc_try_nid_raw(THREAD_SIZE, THREAD_SIZE,
+					 MEMBLOCK_LOW_LIMIT, limit,
+					 early_cpu_to_node(cpu));
+	if (!ptr)
+		panic("cannot allocate stacks");
 
-	return __va(pa);
+	return ptr;
 }
 
 void __init irqstack_early_init(void)
@@ -933,8 +931,9 @@ static void __ref init_fallback_flush(void)
 	 * hardware prefetch runoff. We don't have a recipe for load patterns to
 	 * reliably avoid the prefetcher.
 	 */
-	l1d_flush_fallback_area = __va(memblock_alloc_base(l1d_size * 2, l1d_size, limit));
-	memset(l1d_flush_fallback_area, 0, l1d_size * 2);
+	l1d_flush_fallback_area = memblock_alloc_try_nid(l1d_size * 2,
+						l1d_size, MEMBLOCK_LOW_LIMIT,
+						limit, NUMA_NO_NODE);
 
 	for_each_possible_cpu(cpu) {
 		struct paca_struct *paca = paca_ptrs[cpu];
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc..bc6be44 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -908,9 +908,9 @@ static void __init htab_initialize(void)
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
 		linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
-		linear_map_hash_slots = __va(memblock_alloc_base(
-				linear_map_hash_count, 1, ppc64_rma_size));
-		memset(linear_map_hash_slots, 0, linear_map_hash_count);
+		linear_map_hash_slots = memblock_alloc_try_nid(
+				linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
+				ppc64_rma_size,	NUMA_NO_NODE);
 	}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
diff --git a/arch/powerpc/mm/pgtable-book3e.c b/arch/powerpc/mm/pgtable-book3e.c
index e0ccf36..53cbc7d 100644
--- a/arch/powerpc/mm/pgtable-book3e.c
+++ b/arch/powerpc/mm/pgtable-book3e.c
@@ -57,12 +57,8 @@ void vmemmap_remove_mapping(unsigned long start,
 
 static __ref void *early_alloc_pgtable(unsigned long size)
 {
-	void *pt;
-
-	pt = __va(memblock_alloc_base(size, size, __pa(MAX_DMA_ADDRESS)));
-	memset(pt, 0, size);
-
-	return pt;
+	return memblock_alloc_try_nid(size, size, MEMBLOCK_LOW_LIMIT,
+				      __pa(MAX_DMA_ADDRESS), NUMA_NO_NODE);
 }
 
 /*
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 9f93c9f..70d5478 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -195,11 +195,8 @@ void __init mmu_partition_table_init(void)
 	unsigned long ptcr;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
-	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
-						MEMBLOCK_ALLOC_ANYWHERE));
-
 	/* Initialize the Partition Table with no entries */
-	memset((void *)partition_tb, 0, patb_size);
+	partition_tb = memblock_alloc(patb_size, patb_size);
 
 	/*
 	 * update partition table control register,
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 9311560..415a1eb0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -51,24 +51,18 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
 static __ref void *early_alloc_pgtable(unsigned long size, int nid,
 			unsigned long region_start, unsigned long region_end)
 {
-	unsigned long pa = 0;
+	phys_addr_t min_addr = MEMBLOCK_LOW_LIMIT;
+	phys_addr_t max_addr = MEMBLOCK_ALLOC_ANYWHERE;
 	void *pt;
 
-	if (region_start || region_end) /* has region hint */
-		pa = memblock_alloc_range(size, size, region_start, region_end,
-						MEMBLOCK_NONE);
-	else if (nid != -1) /* has node hint */
-		pa = memblock_alloc_base_nid(size, size,
-						MEMBLOCK_ALLOC_ANYWHERE,
-						nid, MEMBLOCK_NONE);
+	if (region_start)
+		min_addr = region_start;
+	if (region_end)
+		max_addr = region_end;
 
-	if (!pa)
-		pa = memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE);
-
-	BUG_ON(!pa);
-
-	pt = __va(pa);
-	memset(pt, 0, size);
+	pt = memblock_alloc_try_nid_nopanic(size, size, min_addr, max_addr,
+					    nid);
+	BUG_ON(!pt);
 
 	return pt;
 }
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index f297152..f62930f 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -208,7 +208,9 @@ static int __init iob_init(struct device_node *dn)
 	pr_debug(" -> %s\n", __func__);
 
 	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
-	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
+	iob_l2_base = memblock_alloc_try_nid_raw(1UL << 21, 1UL << 21,
+					MEMBLOCK_LOW_LIMIT, 0x80000000,
+					NUMA_NO_NODE);
 
 	pr_info("IOBMAP L2 allocated at: %p\n", iob_l2_base);
 
@@ -269,4 +271,3 @@ void __init iommu_init_early_pasemi(void)
 	pasemi_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pasemi;
 	set_pci_dma_ops(&dma_iommu_ops);
 }
-
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0f553dc..715ed61 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -130,8 +130,10 @@ static void __init fwnmi_init(void)
 	 * It will be used in real mode mce handler, hence it needs to be
 	 * below RMA.
 	 */
-	mce_data_buf = __va(memblock_alloc_base(RTAS_ERROR_LOG_MAX * nr_cpus,
-					RTAS_ERROR_LOG_MAX, ppc64_rma_size));
+	mce_data_buf = memblock_alloc_try_nid_raw(RTAS_ERROR_LOG_MAX * nr_cpus,
+					RTAS_ERROR_LOG_MAX, MEMBLOCK_LOW_LIMIT,
+					ppc64_rma_size, NUMA_NO_NODE);
+
 	for_each_possible_cpu(i) {
 		paca_ptrs[i]->mce_data_buf = mce_data_buf +
 						(RTAS_ERROR_LOG_MAX * i);
@@ -140,8 +142,9 @@ static void __init fwnmi_init(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Allocate per cpu slb area to save old slb contents during MCE */
 	size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
-	slb_ptr = __va(memblock_alloc_base(size, sizeof(struct slb_entry),
-					   ppc64_rma_size));
+	slb_ptr = memblock_alloc_try_nid_raw(size, sizeof(struct slb_entry),
+					MEMBLOCK_LOW_LIMIT, ppc64_rma_size,
+					NUMA_NO_NODE);
 	for_each_possible_cpu(i)
 		paca_ptrs[i]->mce_faulty_slbs = slb_ptr + (mmu_slb_size * i);
 #endif
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a5b40d1..ac6d235 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -251,8 +251,9 @@ static void allocate_dart(void)
 	 * 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
 	 * will blow up an entire large page anyway in the kernel mapping.
 	 */
-	dart_tablebase = __va(memblock_alloc_base(1UL<<24,
-						  1UL<<24, 0x80000000L));
+	dart_tablebase = memblock_alloc_try_nid_raw(1UL << 24, 1UL << 24,
+					MEMBLOCK_LOW_LIMIT, 0x80000000L,
+					NUMA_NO_NODE);
 
 	/* There is no point scanning the DART space for leaks*/
 	kmemleak_no_scan((void *)dart_tablebase);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
