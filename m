Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70963C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8D2213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FsxT653B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vcWL4IWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8D2213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=16dwu70WQkhF3lxOCkK3/oqvwCpgsWtWyXlfWultNgY=; b=FsxT653BPYT8yxZ3uzzZuEpzn/
	86iL8MS2T+ZIZbTm3sEZ6CVhSX6FQRzeZK20Y16PfK5P8W+U0SgQrCgpWa/v1VL0+gTCbrS/p1JPV
	I2pKh+Vqj47zOZ4+xZi0gyrUKIZtiojoDOJcN8t1W/MbYl9EiKdHj9YMkpwxjHJA/1AyHwAxdcyvV
	ACpHpXW5gvgs7/Mw20aMocVrURVV10WBz04XDK4/cfgwU+1dzK/NM9SPRS4wFQgJRu4b7phVj6ZSl
	2dVlKj0naU/E/sPvJfZAfbCZt2NvMIffLAk73BFr619dr8lYX/Oq3V+cLA6V6HWFQm/cM1a69pZjd
	8+yn4GQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhbS-0001Tz-KQ; Thu, 10 Jan 2019 21:11:02 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhbG-0001JX-0l
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:10:52 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8uES192919;
 Thu, 10 Jan 2019 21:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=bZUUZyFkbCMprgrasNXmseU+a3iCWM1WQZPOxRn+auM=;
 b=vcWL4IWbZwKYO2SXRab+NCyTHIBLpjZHIceUOOe25YQx4ENkJt0k1exSOtes/0a8vZYN
 8i8kYPNeIinu/be7AoDq3HqHVwO7DnGY2cyZp0ailH1N0x+XrMtBb6i8etUEhucD3NNB
 4PvYZRQCTABPDIyAK6SVpi1ngX5xHoDgc0Y4tHvnJh4wSJNVoj5aw++N1nU7Ka5qe57H
 vA4iQ9ck7Wjr57REHXLQeKTC2IMnxdS5kX7gGddyuDRwGwj5HuNWqkLxMu0IsYZzwYcD
 B5360GALRkAG7PSTM225aQeQ3tE5LIYp/o2E8IgOVDAFyYUGXTBSzk29Mhwe50XVADq3 gQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by userp2120.oracle.com with ESMTP id 2ptn7r9f42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jan 2019 21:10:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAT3Z011932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jan 2019 21:10:29 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALASwW021340;
 Thu, 10 Jan 2019 21:10:28 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 10 Jan 2019 13:10:28 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, konrad.wilk@oracle.com
Subject: [RFC PATCH v7 08/16] arm64/mm: disable section/contiguous mappings if
 XPFO is enabled
Date: Thu, 10 Jan 2019 14:09:40 -0700
Message-Id: <3dfdd42afe1749d4f82816f967532643de3a5024.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_131050_190037_8C8392FC 
X-CRM114-Status: GOOD (  21.12  )
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
 linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>,
 deepa.srinivasan@oracle.com, steven.sistare@oracle.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, hch@lst.de,
 kanth.ghatraju@oracle.com, pradeep.vincent@oracle.com, jcm@redhat.com,
 tglx@linutronix.de, chris.hyser@oracle.com,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, tyhicks@canonical.com,
 john.haxby@oracle.com, dwmw@amazon.co.uk, kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tycho Andersen <tycho@docker.com>

XPFO doesn't support section/contiguous mappings yet, so let's disable it
if XPFO is turned on.

Thanks to Laura Abbot for the simplification from v5, and Mark Rutland for
pointing out we need NO_CONT_MAPPINGS too.

CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Tycho Andersen <tycho@docker.com>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/arm64/mm/mmu.c  | 2 +-
 include/linux/xpfo.h | 4 ++++
 mm/xpfo.c            | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d1d6601b385d..f4dd27073006 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -451,7 +451,7 @@ static void __init map_mem(pgd_t *pgdp)
 	struct memblock_region *reg;
 	int flags = 0;
 
-	if (debug_pagealloc_enabled())
+	if (debug_pagealloc_enabled() || xpfo_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 2682a00ebbcb..0c26836a24e1 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -46,6 +46,8 @@ void xpfo_temp_map(const void *addr, size_t size, void **mapping,
 void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 		     size_t mapping_len);
 
+bool xpfo_enabled(void);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_kmap(void *kaddr, struct page *page) { }
@@ -68,6 +70,8 @@ static inline void xpfo_temp_unmap(const void *addr, size_t size,
 }
 
 
+static inline bool xpfo_enabled(void) { return false; }
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/xpfo.c b/mm/xpfo.c
index f79075bf7d65..25fba05d01bd 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -70,6 +70,12 @@ struct page_ext_operations page_xpfo_ops = {
 	.init = init_xpfo,
 };
 
+bool __init xpfo_enabled(void)
+{
+	return !xpfo_disabled;
+}
+EXPORT_SYMBOL(xpfo_enabled);
+
 static inline struct xpfo *lookup_xpfo(struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
