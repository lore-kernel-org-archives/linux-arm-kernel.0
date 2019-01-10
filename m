Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:12:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEB9213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DipJ0u12";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zQ6tEafk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEB9213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hDKCvTeGZTyGwgVqDn2e4Pd2wP8Hh1l6GVeTgLGT4vw=; b=DipJ0u12YD0Xyvqz+izbmpl/AP
	NWwpAKcQJGxpaq/wuLUD86FNE07nrt4XqpriYzByhZdHWqljvOBhDLpMJSDFsZl8+4toPC0mIPZ8O
	wuG1eQdqKusN7k8tyMLDKJT6v+khU0zt/MhJhfXe/NRbDaCPSdGsW2evMR1iVfkdEy7UofcRxQoc1
	BN7iJS8p5VAJJYmS2wS0hzrjC3VgIHZXjy4HGok6M6gsN4by041VFuIfr9IRYcgMx9Q9AkY+FRMr0
	ARW1+R6I8iYBoVENBLanFWyy8Bs7+DErzdK4rBh6mHXCAE0pNxkpxaGW18lmTL4DjHw7WQOPMCFa1
	xrw28hUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhcO-0002Od-2o; Thu, 10 Jan 2019 21:12:00 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhbI-0001KP-FO
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:10:54 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8up0187070;
 Thu, 10 Jan 2019 21:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=7ze7ihNQNB91qQvcMs0AZsSJuj8aoWf893BJ5dPG2Tc=;
 b=zQ6tEafkYELketM9PQGIBhEggEtIFIzXE2AsxM/vjfAsKwijBbkklOA/wPl76KxUn5Er
 MVdeIHP/9T8pCzW9SZoZghIsrZOZNKKAoGszZc9Qr6DGVzSJOzz838a2YocF87jIomut
 IgACh2Uy1NML3PSo4anLaJ1jkIZukutMnbnYxOgiQzp74Yun3c8MmQMlRDscX5LdOkuD
 yx2o0t/4gZJlb9IkGWObtSKw/0X8YYv96FPadoHq+H/eQc4qy/uxbQrk9SCnvYbKScqz
 NibBrnvTaUIwc9u7cdJBxSwRG8l7RjGH1NC22eVgRnz0OLUbT7rrDDNQzRc5gx2BuKNd Wg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp2130.oracle.com with ESMTP id 2ptj3e9tha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jan 2019 21:10:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALARtm008956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jan 2019 21:10:27 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ALAQbd003774;
 Thu, 10 Jan 2019 21:10:26 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 10 Jan 2019 13:10:26 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, konrad.wilk@oracle.com
Subject: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache regions
Date: Thu, 10 Jan 2019 14:09:39 -0700
Message-Id: <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=682
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_131052_592688_5CE928D6 
X-CRM114-Status: GOOD (  16.35  )
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
 john.haxby@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>,
 dwmw@amazon.co.uk, kirill.shutemov@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

If the page is unmapped by XPFO, a data cache flush results in a fatal
page fault, so let's temporarily map the region, flush the cache, and then
unmap it.

v6: actually flush in the face of xpfo, and temporarily map the underlying
    memory so it can be flushed correctly

CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Tycho Andersen <tycho@docker.com>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/arm64/mm/flush.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 30695a868107..f12f26b60319 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/xpfo.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cache.h>
@@ -28,9 +29,15 @@
 void sync_icache_aliases(void *kaddr, unsigned long len)
 {
 	unsigned long addr = (unsigned long)kaddr;
+	unsigned long num_pages = XPFO_NUM_PAGES(addr, len);
+	void *mapping[num_pages];
 
 	if (icache_is_aliasing()) {
+		xpfo_temp_map(kaddr, len, mapping,
+			      sizeof(mapping[0]) * num_pages);
 		__clean_dcache_area_pou(kaddr, len);
+		xpfo_temp_unmap(kaddr, len, mapping,
+			        sizeof(mapping[0]) * num_pages);
 		__flush_icache_all();
 	} else {
 		flush_icache_range(addr, addr + len);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
