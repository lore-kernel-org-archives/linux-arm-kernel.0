Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53B222CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qr6a9Oqr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2PAnanOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53B222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JRfXiFgnazcRsf4TH/7Uq54U7wHuJjcX/GVS2x9cf7s=; b=qr6a9OqraNTVrV11j0WCElnlZs
	7OwtjqG7S6+M2C9LjRp8ILzWSngVe7khmN/rxY2ne9I3gIn18IqKjE92VqSHCQN8yORUuNvmDjPVB
	qJkIAlZ4QM1KGvZZ9ia0gHG491ExC02PLJ+Xui55XrST3IlkUaG9768IcvORjcKZ1O5rK/0ruXqHF
	Mo7Da4enkb+7gk28eLTWAVnPlQvWScBOc7cGvk3lhm7/mvCKEe5Mj9xM+8P/kh+DNUzy679fg+I6Z
	NkjYUTXyuGhN4rodBB76fRk9S+Dj7rcgNanTIx5PNoAqPvEv1vG/KQSampJck2WC3HUPMaA3iQ05k
	GRjhchgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4WR-00013D-Ht; Thu, 14 Feb 2019 00:04:59 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4Ul-0007ec-B4
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:03:20 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNx9xx093658;
 Thu, 14 Feb 2019 00:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=TQlIsuP1ag8N8cWtIZarXg5qzwt4o6eHPtANA79RWaM=;
 b=2PAnanOtADcxei1cy8BlTb/qU5ZZ7i0wqibFXPa9bnInPG/bvReURBWdV7oqlHHKB04P
 eJe2e67nu+luxcdvC3UBRDtvbK4t0fpRO4v+csDCFP/QjO2HMEGx/ANYI0/HgjyJOXBQ
 A+HhQpvU1Zm+os48RbnhGhjXf13nrybGW9Q+s+JqmKbNdQ6NQ9nWd7faph98x/U5WFsQ
 GP3HR7Iu2pYrMuqLFfE3A+sddb/2CPIRd3PP80otI32ENy8xTiH9Z0CLXt9neXDuvRjw
 swjC9f3y4oeNAID085G4bmwvjmiQzHs2QY3PeVUXmX6gdeHyJcTl0BfB9Kn9iJyjhaP4 ZQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2130.oracle.com with ESMTP id 2qhrekn4kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:20 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02I6f026212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:19 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E02Hqw032540;
 Thu, 14 Feb 2019 00:02:17 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:02:16 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 09/14] mm: add a user_virt_to_phys symbol
Date: Wed, 13 Feb 2019 17:01:32 -0700
Message-Id: <b96108404af22ac25a0b62b81d338bf511002f63.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_160315_630364_F4E8A105 
X-CRM114-Status: GOOD (  17.30  )
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
 peterz@infradead.org, dave.hansen@intel.com,
 Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
 steven.sistare@oracle.com, hch@lst.de, x86@kernel.org,
 kanth.ghatraju@oracle.com, labbott@redhat.com, pradeep.vincent@oracle.com,
 jcm@redhat.com, luto@kernel.org, boris.ostrovsky@oracle.com,
 chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, linux-mm@kvack.org, andrew.cooper3@citrix.com,
 linux-kernel@vger.kernel.org, tyhicks@canonical.com, john.haxby@oracle.com,
 tglx@linutronix.de, oao.m.martins@oracle.com, dwmw@amazon.co.uk,
 kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tycho Andersen <tycho@docker.com>

We need someting like this for testing XPFO. Since it's architecture
specific, putting it in the test code is slightly awkward, so let's make it
an arch-specific symbol and export it for use in LKDTM.

CC: linux-arm-kernel@lists.infradead.org
CC: x86@kernel.org
Signed-off-by: Tycho Andersen <tycho@docker.com>
Tested-by: Marco Benatto <marco.antonio.780@gmail.com>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
v6: * add a definition of user_virt_to_phys in the !CONFIG_XPFO case
v7: * make user_virt_to_phys a GPL symbol

 arch/x86/mm/xpfo.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/xpfo.h |  8 +++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index 6c7502993351..e13b99019c47 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -117,3 +117,60 @@ inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 
 	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
 }
+
+/* Convert a user space virtual address to a physical address.
+ * Shamelessly copied from slow_virt_to_phys() and lookup_address() in
+ * arch/x86/mm/pageattr.c
+ */
+phys_addr_t user_virt_to_phys(unsigned long addr)
+{
+	phys_addr_t phys_addr;
+	unsigned long offset;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(current->mm, addr);
+	if (pgd_none(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return 0;
+
+	if (p4d_large(*p4d) || !p4d_present(*p4d)) {
+		phys_addr = (unsigned long)p4d_pfn(*p4d) << PAGE_SHIFT;
+		offset = addr & ~P4D_MASK;
+		goto out;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return 0;
+
+	if (pud_large(*pud) || !pud_present(*pud)) {
+		phys_addr = (unsigned long)pud_pfn(*pud) << PAGE_SHIFT;
+		offset = addr & ~PUD_MASK;
+		goto out;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return 0;
+
+	if (pmd_large(*pmd) || !pmd_present(*pmd)) {
+		phys_addr = (unsigned long)pmd_pfn(*pmd) << PAGE_SHIFT;
+		offset = addr & ~PMD_MASK;
+		goto out;
+	}
+
+	pte =  pte_offset_kernel(pmd, addr);
+	phys_addr = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
+	offset = addr & ~PAGE_MASK;
+
+out:
+	return (phys_addr_t)(phys_addr | offset);
+}
+EXPORT_SYMBOL_GPL(user_virt_to_phys);
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 8b029918a958..117869991d5b 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -24,6 +24,10 @@ struct page;
 
 #ifdef CONFIG_XPFO
 
+#include <linux/dma-mapping.h>
+
+#include <linux/types.h>
+
 extern struct page_ext_operations page_xpfo_ops;
 
 void set_kpte(void *kaddr, struct page *page, pgprot_t prot);
@@ -49,6 +53,8 @@ void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 
 bool xpfo_enabled(void);
 
+phys_addr_t user_virt_to_phys(unsigned long addr);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_kmap(void *kaddr, struct page *page) { }
@@ -73,6 +79,8 @@ static inline void xpfo_temp_unmap(const void *addr, size_t size,
 
 static inline bool xpfo_enabled(void) { return false; }
 
+static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
