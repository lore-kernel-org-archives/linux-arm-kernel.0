Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AFAC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:49:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CC120661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gU94VYFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CC120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i5H7mEC15Y6hCdOiPXujHSDudjDbhOekucKb3MFONnA=; b=gU94VYFQai2DooJ6xlsqWdbyvg
	Z0gr4iAGHtEnK8d6Lq6WSALpfcR+HzeYCGAjEpqN/KDG7ECuOuTHtiNvnrn+QunF/0HPRoDCfkIEM
	POic9/wWzKZrejSMCBSCdWQl4gxfRk9rSCUfqrUs5a/YqR/KcIrVen1T57yb909G0KDWXcJR6Orfu
	8BoE0oxJS3pN9mZEiyg3Xf7aTJaPJg2jjSpKk5jHX6F1y6DaspJ5VPFYCX7xRRR5jEoeV/ukYCeH/
	R6Ji6xeTF9kYeZ6CyfY7ir1HGiks25errEoCxM4SG2/Cz3mIo8ojNbl0vJSHB52eQbA4drDincdcX
	gAYh75tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqTI-0008LK-JW; Mon, 03 Dec 2018 15:49:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqSf-0007dC-3A
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:48:59 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3Fiw5o045019
 for <linux-arm-kernel@lists.infradead.org>; Mon, 3 Dec 2018 10:48:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p56rfav43-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 03 Dec 2018 10:48:28 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 15:47:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 15:47:48 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3Fllek29229290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 15:47:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68D62A4062;
 Mon,  3 Dec 2018 15:47:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C56AA4064;
 Mon,  3 Dec 2018 15:47:44 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 15:47:44 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 03 Dec 2018 17:47:43 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
Date: Mon,  3 Dec 2018 17:47:15 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120315-4275-0000-0000-000002EB6079
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120315-4276-0000-0000-000037F86483
Message-Id: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074841_567233_F766BFF0 
X-CRM114-Status: GOOD (  22.85  )
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

On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
oneliner wrappers for memblock_alloc.

Replace their usage with direct call to memblock_alloc.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c       | 11 +++--------
 arch/unicore32/mm/mmu.c | 12 ++++--------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0a04c9a5..57de0dd 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
-{
-	return memblock_alloc(sz, align);
-}
-
 static void __init *early_alloc(unsigned long sz)
 {
-	return early_alloc_aligned(sz, sz);
+	return memblock_alloc(sz, sz);
 }
 
 static void *__init late_alloc(unsigned long sz)
@@ -998,7 +993,7 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	if (!nr)
 		return;
 
-	svm = early_alloc_aligned(sizeof(*svm) * nr, __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm) * nr, __alignof__(*svm));
 
 	for (md = io_desc; nr; md++, nr--) {
 		create_mapping(md);
@@ -1020,7 +1015,7 @@ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
 	struct vm_struct *vm;
 	struct static_vm *svm;
 
-	svm = early_alloc_aligned(sizeof(*svm), __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm), __alignof__(*svm));
 
 	vm = &svm->vm;
 	vm->addr = (void *)addr;
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 50d8c1a..a402192 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -141,16 +141,12 @@ static void __init build_mem_type_table(void)
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
-{
-	return memblock_alloc(sz, sz);
-}
-
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
 		unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte_t *pte = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t),
+					    PTRS_PER_PTE * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
@@ -352,7 +348,7 @@ static void __init devicemaps_init(void)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = early_alloc(PAGE_SIZE);
+	vectors = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -429,7 +425,7 @@ void __init paging_init(void)
 	top_pmd = pmd_off_k(0xffff0000);
 
 	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	bootmem_init();
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
