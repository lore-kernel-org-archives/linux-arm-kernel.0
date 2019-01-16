Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE69C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:11:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D760B20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JhVUTCbO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5rmNxyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D760B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tQtYhhStqstOuiJ35z3yyeqytUm5+ob+49MNylvyAks=; b=JhVUTCbOsShSP1o7LZ6hZNxF87
	eOVyvWiP72NhIKqK8TaUcQb3zuSfBhs+IDw6uzfpeibAcP76LnV92Ni/JEDfADS4OUKyKZmCxypyn
	QqL8xchISvQUmphorgg1lhqrIX0rUCvhcJ6QmlClyogdjiVLrIXdCFshsILPXqyCnIHtUuCvqc0Zb
	d9+/g2Y/sTorV1CKXaBwazohgD8hus9wT7v1sLQkVcee95jcWe+luTEudPwfsYZkqSKbEZF2eusS5
	Pya7jSVafwkad6zctMZRp9aEuGA6bOEvB6wieghUucOS6yQ2yrtZQF/CEOA04wQ5CEOdc6ogNHKzr
	8VuwaoSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjluk-00013d-65; Wed, 16 Jan 2019 14:11:30 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjluJ-0000Nb-Sw
 for linux-arm-kernel@bombadil.infradead.org; Wed, 16 Jan 2019 14:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:References:In-Reply-To:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=krY70wr52D/oEzJgxw7FmzrHbkttubrAPMvuvDWWfzU=; b=V5rmNxylBJx0RDpHOM+ZA3Y5a
 6gbaRT+FSWCcWDcK8NPd6T9Iuxubbud3MXwHm5KFeqOPT7OxuBMtgyiquPT2clCBt+65SmRLpSVeh
 hMYUmSze3MRu65bQqavJ0DFAQKSi3VCj305SjDswEDqc5MXWAHlYQ9g301/UN5f1QK3RU0tBn8ejh
 A0w7iTRhponqdQDEloa83aD8Gapm+tBU8GcbaHkUvhA/lHggqkPWgTrFxp6LO76hG0Z77TFphSVFY
 D6sEf4ymWVV11mXu8d9DU0i20NVXt9Yc86h2P0ebc3ej4Ccp8y5OPBKL982A7+SAcaUelYZwlpXQ+
 IW/tKnaOA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlVm-0000jG-GZ
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:45:44 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDeXnO036329
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q240wd0wp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:41 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:45:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:45:26 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDjP6Z49348698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:45:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 632F711C052;
 Wed, 16 Jan 2019 13:45:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BC7111C050;
 Wed, 16 Jan 2019 13:45:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Jan 2019 13:45:21 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:45:20 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 12/21] arch: use memblock_alloc() instead of
 memblock_alloc_from(size, align, 0)
Date: Wed, 16 Jan 2019 15:44:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0012-0000-0000-000002E8D1C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0013-0000-0000-0000211FE9F4
Message-Id: <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_084542_778970_1984E1FC 
X-CRM114-Status: GOOD (  29.72  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The last parameter of memblock_alloc_from() is the lower limit for the
memory allocation. When it is 0, the call is equivalent to
memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/kernel/core_cia.c  |  2 +-
 arch/alpha/kernel/pci_iommu.c |  4 ++--
 arch/alpha/kernel/setup.c     |  2 +-
 arch/ia64/kernel/mca.c        |  3 +--
 arch/mips/kernel/traps.c      |  2 +-
 arch/sparc/kernel/prom_32.c   |  2 +-
 arch/sparc/mm/init_32.c       |  2 +-
 arch/sparc/mm/srmmu.c         | 10 +++++-----
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index 867e873..466cd44 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -331,7 +331,7 @@ cia_prepare_tbia_workaround(int window)
 	long i;
 
 	/* Use minimal 1K map. */
-	ppte = memblock_alloc_from(CIA_BROKEN_TBIA_SIZE, 32768, 0);
+	ppte = memblock_alloc(CIA_BROKEN_TBIA_SIZE, 32768);
 	pte = (virt_to_phys(ppte) >> (PAGE_SHIFT - 1)) | 1;
 
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index aa0f50d..e4cf77b 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -87,13 +87,13 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 		printk("%s: couldn't allocate arena ptes from node %d\n"
 		       "    falling back to system-wide allocation\n",
 		       __func__, nid);
-		arena->ptes = memblock_alloc_from(mem_size, align, 0);
+		arena->ptes = memblock_alloc(mem_size, align);
 	}
 
 #else /* CONFIG_DISCONTIGMEM */
 
 	arena = memblock_alloc(sizeof(*arena), SMP_CACHE_BYTES);
-	arena->ptes = memblock_alloc_from(mem_size, align, 0);
+	arena->ptes = memblock_alloc(mem_size, align);
 
 #endif /* CONFIG_DISCONTIGMEM */
 
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 4b5b1b2..5d4c76a 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -293,7 +293,7 @@ move_initrd(unsigned long mem_limit)
 	unsigned long size;
 
 	size = initrd_end - initrd_start;
-	start = memblock_alloc_from(PAGE_ALIGN(size), PAGE_SIZE, 0);
+	start = memblock_alloc(PAGE_ALIGN(size), PAGE_SIZE);
 	if (!start || __pa(start) + size > mem_limit) {
 		initrd_start = initrd_end = 0;
 		return NULL;
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 91bd1e1..74d148b 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1835,8 +1835,7 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 /* Caller prevents this from being called after init */
 static void * __ref mca_bootmem(void)
 {
-	return memblock_alloc_from(sizeof(struct ia64_mca_cpu),
-				   KERNEL_STACK_SIZE, 0);
+	return memblock_alloc(sizeof(struct ia64_mca_cpu), KERNEL_STACK_SIZE);
 }
 
 /* Do per-CPU MCA-related initialization.  */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c91097f..2bbdee5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2291,7 +2291,7 @@ void __init trap_init(void)
 		phys_addr_t ebase_pa;
 
 		ebase = (unsigned long)
-			memblock_alloc_from(size, 1 << fls(size), 0);
+			memblock_alloc(size, 1 << fls(size));
 
 		/*
 		 * Try to ensure ebase resides in KSeg0 if possible.
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 42d7f2a..38940af 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -32,7 +32,7 @@ void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret;
 
-	ret = memblock_alloc_from(size, SMP_CACHE_BYTES, 0UL);
+	ret = memblock_alloc(size, SMP_CACHE_BYTES);
 	if (ret != NULL)
 		memset(ret, 0, size);
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952..a8ff298 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -264,7 +264,7 @@ void __init mem_init(void)
 	i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
 	i += 1;
 	sparc_valid_addr_bitmap = (unsigned long *)
-		memblock_alloc_from(i << 2, SMP_CACHE_BYTES, 0UL);
+		memblock_alloc(i << 2, SMP_CACHE_BYTES);
 
 	if (sparc_valid_addr_bitmap == NULL) {
 		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b609362..a400ec3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -303,13 +303,13 @@ static void __init srmmu_nocache_init(void)
 
 	bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
 
-	srmmu_nocache_pool = memblock_alloc_from(srmmu_nocache_size,
-						 SRMMU_NOCACHE_ALIGN_MAX, 0UL);
+	srmmu_nocache_pool = memblock_alloc(srmmu_nocache_size,
+					    SRMMU_NOCACHE_ALIGN_MAX);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
 	srmmu_nocache_bitmap =
-		memblock_alloc_from(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
-				    SMP_CACHE_BYTES, 0UL);
+		memblock_alloc(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
+			       SMP_CACHE_BYTES);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
@@ -467,7 +467,7 @@ static void __init sparc_context_init(int numctx)
 	unsigned long size;
 
 	size = numctx * sizeof(struct ctx_list);
-	ctx_list_pool = memblock_alloc_from(size, SMP_CACHE_BYTES, 0UL);
+	ctx_list_pool = memblock_alloc(size, SMP_CACHE_BYTES);
 
 	for (ctx = 0; ctx < numctx; ctx++) {
 		struct ctx_list *clist;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
