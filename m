Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD5B218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TrGvWzTc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eq0NRf9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD5B218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=a3fLjov8yQgKbyG304qYfIBlH2b6ocMInu26MRkei/g=; b=TrGvWzTc+V0rjEW9WuU0XxWFjT
	wd+SXPgJHj3+r3vT5CWiUXg8U0G1zQbYh2+wTYDxRTkWuh6HLEFQxsKUeE4fJgEzmw1A/7+drdEii
	gHoz5YvBUzNURSi8AQ40+nBjYqQIKsanmSQNpMiNXsclo5rin1rrhtyRzpLQZzkd8jk3wfeUC2dyT
	iVCuzRytgnuZaNpT7GZChaPNkbvMZQAR00uYut3ESrqeEThtbOr8qCn0w3lxkC4op1ejiMLLK20Ch
	N8gVt0U+QG492EieVyCV9uc0y3Spk8/2JEZar4fgP5M38KGeG2vGch8ZI/Oq0W7422ASeZ0d/8Wqj
	xANRo/EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4Vi-0000Lg-FM; Thu, 14 Feb 2019 00:04:14 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4Ue-0007W3-N0
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:03:14 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNworQ099417;
 Thu, 14 Feb 2019 00:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=lijI2dkmHOz8IBbMljD0kgh/GfNNHRB/Ww5ZCLiDpC8=;
 b=Eq0NRf9CvVjMRyqL/pJwd5gMUZxni+bHvlB5+zwob5e+xiwZT4ra0AyBxJ92DivdFLna
 97cYTFa2qe9QQ6wYiXHornwjF1eTBScwRD03REBGbSCxrGe1sHulQ2gDVu4xX3mxM/36
 3SvBa2fAgAWdU0U1FEda7/JATU3IVFLn4IveEsG+K9h5CqxCBFKvEGRJGGdkfDkYamdp
 PsnFndFcwiVrKpuBYeXNhI81MuZO4NIfCeGp/zunHR7sbKkLh0NDGuO1bP7hoZRAZp8q
 tczxkn156C41JsFvXIo8bWbOeUspWxI2rXu9qB8VJta8M6C6Ic/459RKF/2UsrhhQ7Ps Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp2120.oracle.com with ESMTP id 2qhree55nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02R97032757
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:27 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E02RfT018893;
 Thu, 14 Feb 2019 00:02:27 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:02:26 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 13/14] xpfo,
 mm: Defer TLB flushes for non-current CPUs (x86 only)
Date: Wed, 13 Feb 2019 17:01:36 -0700
Message-Id: <98134cb73e911b2f0b59ffb76243a7777963d218.1550088114.git.khalid.aziz@oracle.com>
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
X-CRM114-CacheID: sfid-20190213_160309_500872_CB42E1FC 
X-CRM114-Status: GOOD (  24.46  )
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
Cc: kernel-hardening@lists.openwall.com, peterz@infradead.org,
 dave.hansen@intel.com, Khalid Aziz <khalid.aziz@oracle.com>,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com, hch@lst.de,
 x86@kernel.org, kanth.ghatraju@oracle.com, labbott@redhat.com,
 pradeep.vincent@oracle.com, jcm@redhat.com, luto@kernel.org,
 boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com, linux-mm@kvack.org,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, tglx@linutronix.de, oao.m.martins@oracle.com,
 dwmw@amazon.co.uk, kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

XPFO flushes kernel space TLB entries for pages that are now mapped
in userspace on not only the current CPU but also all other CPUs
synchronously. Processes on each core allocating pages causes a
flood of IPI messages to all other cores to flush TLB entries.
Many of these messages are to flush the entire TLB on the core if
the number of entries being flushed from local core exceeds
tlb_single_page_flush_ceiling. The cost of TLB flush caused by
unmapping pages from physmap goes up dramatically on machines with
high core count.

This patch flushes relevant TLB entries for current process or
entire TLB depending upon number of entries for the current CPU
and posts a pending TLB flush on all other CPUs when a page is
unmapped from kernel space and mapped in userspace. Each core
checks the pending TLB flush flag for itself on every context
switch, flushes its TLB if the flag is set and clears it.
This patch potentially aggregates multiple TLB flushes into one.
This has very significant impact especially on machines with large
core counts. To illustrate this, kernel was compiled with -j on
two classes of machines - a server with high core count and large
amount of memory, and a desktop class machine with more modest
specs. System time from "make -j" from vanilla 4.20 kernel, 4.20
with XPFO patches before applying this patch and after applying
this patch are below:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20                            950.966s
4.20+XPFO                       25073.169s      26.366x
4.20+XPFO+Deferred flush        1372.874s        1.44x

Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20                            607.671s
4.20+XPFO                       1588.646s       2.614x
4.20+XPFO+Deferred flush        803.989s        1.32x

This patch could use more optimization. Batching more TLB entry
flushes, as was suggested for earlier version of these patches,
can help reduce these cases. This same code should be implemented
for other architectures as well once finalized.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 38 +++++++++++++++++++++++++++++++++
 arch/x86/mm/xpfo.c              |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f4204bf377fc..92d23629d01d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -561,6 +561,7 @@ extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 03b6b4c2238d..c907b643eecb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -35,6 +35,15 @@
  */
 #define LAST_USER_MM_IBPB	0x1UL
 
+/*
+ * When a full TLB flush is needed to flush stale TLB entries
+ * for pages that have been mapped into userspace and unmapped
+ * from kernel space, this TLB flush will be delayed until the
+ * task is scheduled on that CPU. Keep track of CPUs with
+ * pending full TLB flush forced by xpfo.
+ */
+static cpumask_t pending_xpfo_flush;
+
 /*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
@@ -319,6 +328,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
+
+	/* If there is a pending TLB flush for this CPU due to XPFO
+	 * flush, do it now.
+	 */
+	if (cpumask_test_and_clear_cpu(cpu, &pending_xpfo_flush)) {
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+		__flush_tlb_all();
+	}
+
 	this_cpu_write(cpu_tlbstate.is_lazy, false);
 
 	/*
@@ -801,6 +819,26 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	}
 }
 
+void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	struct cpumask tmp_mask;
+
+	/* Balance as user space task's flush, a bit conservative */
+	if (end == TLB_FLUSH_ALL ||
+	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
+		do_flush_tlb_all(NULL);
+	} else {
+		struct flush_tlb_info info;
+
+		info.start = start;
+		info.end = end;
+		do_kernel_range_flush(&info);
+	}
+	cpumask_setall(&tmp_mask);
+	cpumask_clear_cpu(smp_processor_id(), &tmp_mask);
+	cpumask_or(&pending_xpfo_flush, &pending_xpfo_flush, &tmp_mask);
+}
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info info = {
diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index e13b99019c47..d3833532bfdc 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -115,7 +115,7 @@ inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 		return;
 	}
 
-	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
+	xpfo_flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
 }
 
 /* Convert a user space virtual address to a physical address.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
