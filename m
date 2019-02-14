Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21FAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E68218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SfUu86BE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uIx25zRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E68218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kLxRXZtW+b26OUBd9cWvqHq4FRx2/+LnvgJuI2fAf0c=; b=SfUu86BEG/XM8em6G+yoeZu0br
	bEYowa09WEWAE88GCv12pyLYGAQaTKtJuToU1p0NeHzCsH6aUk7RtiSHJqK+LMbgrX5pAQmmyZ9iG
	YJp+wSbTWte8ojXgojkYA4TmaXuGWfD/gLx/WBNCay3FfKHW2MJQe6q+T2sjdatwDRWVJgB90Y4TN
	z2mXXkDQwrx7T6Nok6r1iNOBdB7i242GlLfeSEz7n3kZK9rXbztskgdZfBd8sf7rVQPUW0EUusCjr
	i6mHNWeAYQrEkTnVvSRH37Ivgbe07G4hcg2n+hKQZNdUDFc+/XPoMtCfJ00p8HGa6CZN3+cLE4lVA
	ztxZXdsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4V0-0007sl-1M; Thu, 14 Feb 2019 00:03:30 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4UL-00075R-9x
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:02:51 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwgkD100217;
 Thu, 14 Feb 2019 00:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=B56xy1SykMvAYC6aqGnZB/bYPtFwWukcKOnvet3ifEU=;
 b=uIx25zRg4V1mI7KE5rlBz/NOl4jvjuexvGmPkyZvqcfrmno71cCT5E+9JbWTSHC/QKat
 mwHwGgsn3lyUx7sgJV9UNpCRjTU6py7eGgk7lKgOpsDhpFjeerfPM2DbaBuKJ9UZcAKz
 DsSL/ZBoCBxdhR3YuaIpkJ3CIAyPWAuQv3sF7iGkSsqlEtLlb7Zeh/RNvN5hZ7YrOLsh
 sHsS6j1a4GAWGwWpXc9lQ+6XKaFyP9pfD/3U4ji5t9w3llUxgied6gcwwuUnMAESawHr
 XKG5wRxJo2PHsFrtNsUaPYHBCbF2txoevXeZNyWcby8O60DPcnZ1QRqSHrFDNLBVEldH TQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2qhre5n3v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02ERU026044
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:02:14 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02ELP001735;
 Thu, 14 Feb 2019 00:02:14 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:02:14 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 08/14] arm64/mm: disable section/contiguous mappings if
 XPFO is enabled
Date: Wed, 13 Feb 2019 17:01:31 -0700
Message-Id: <0b9624b6c1fe5a31d73a6390e063d551bfebc321.1550088114.git.khalid.aziz@oracle.com>
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
X-CRM114-CacheID: sfid-20190213_160249_533467_B538EB29 
X-CRM114-Status: GOOD (  17.20  )
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
 peterz@infradead.org, dave.hansen@intel.com, deepa.srinivasan@oracle.com,
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

XPFO doesn't support section/contiguous mappings yet, so let's disable it
if XPFO is turned on.

Thanks to Laura Abbot for the simplification from v5, and Mark Rutland for
pointing out we need NO_CONT_MAPPINGS too.

CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Tycho Andersen <tycho@docker.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
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
index 1ae05756344d..8b029918a958 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -47,6 +47,8 @@ void xpfo_temp_map(const void *addr, size_t size, void **mapping,
 void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
 		     size_t mapping_len);
 
+bool xpfo_enabled(void);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_kmap(void *kaddr, struct page *page) { }
@@ -69,6 +71,8 @@ static inline void xpfo_temp_unmap(const void *addr, size_t size,
 }
 
 
+static inline bool xpfo_enabled(void) { return false; }
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/xpfo.c b/mm/xpfo.c
index 92ca6d1baf06..150784ae0f08 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -71,6 +71,12 @@ struct page_ext_operations page_xpfo_ops = {
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
