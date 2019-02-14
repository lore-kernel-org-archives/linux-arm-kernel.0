Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B16C218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BDuur3Nw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcr+aLBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B16C218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nd9vD0q+5oktgFuNgVyifOWk/Bpqp0VgPtRC9Upg0ik=; b=BDuur3NwzWL1YdZl+nRoqAC9ay
	YSU3TyODhxKcFve3NvI7b9vzeW+CKGufjTOocLcdEKgf5OANNdKl9qrTOwrk+WvCAJrYgnomdH7ox
	MhLfdstV+5PwHaHtEkW0oXCjS5cKuUDNa3sG0B65CFdACYm0GD02u40mi9epnh1IpLER0XL911MJN
	ZIzNCnxEsr4W9Vb+H6no0XX6VLO+KtXb0H7FGg6x/mtLQY+Yowg7wmdp6vHCpaLbkezZuaRopvtyJ
	OxNfHAf2qDX9Iog9uqEgYkKVeM8lLODHOWyad65kbKzLcVVcKkluSMaCYWXyGaRNa+YPbn+cCfEoU
	gLgplt8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu4Wi-000201-SI; Thu, 14 Feb 2019 00:05:16 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu4VF-0008DR-Gq
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 00:04:15 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwsZ2100568;
 Thu, 14 Feb 2019 00:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=BnvBthvqyUR+BETbLnaqcFAixVQhrRUG4KWFDYKw33s=;
 b=mcr+aLBjXAXSptqDtlz0VxxfWE1bq8ULxWcJo1ATX2NiCgH2AWLADjbr/HqYkpk9odGK
 ChvFnz1ZxMVxKCJ0jfXdJW5TYWVBwj+Ty3/i6pxWwCEiACxkvV13/+T2YmPTX1CBTwJG
 UBQhh1BtAVY8KyQ7Wk/NDQM5Umuvxs3VEJF2d3Xv4chhe+jqnXx8PoRI61KUxuMIHH1j
 hzaCrG4RkCU1W8fxes/FLLMZ7uQSL15sc1ZI1d0I09k3vAa0Q8LpfMdnyskkbMB7yMLc
 eVkiHdh8fE/ZM3EnxXIAPz7Bn0aTkW7mrmcxMY3krFlvZUEFc5Jyqgv8meeyiWbyIGX9 Lw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qhre5n3u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:01:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E01wVi031042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Feb 2019 00:01:58 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E01tie014301;
 Thu, 14 Feb 2019 00:01:56 GMT
Received: from concerto.internal (/24.9.64.241)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Feb 2019 16:01:55 -0800
From: Khalid Aziz <khalid.aziz@oracle.com>
To: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com, 
 torvalds@linux-foundation.org, liran.alon@oracle.com,
 keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
 catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
 konrad.wilk@oracle.com
Subject: [RFC PATCH v8 01/14] mm: add MAP_HUGETLB support to vm_mmap
Date: Wed, 13 Feb 2019 17:01:24 -0700
Message-Id: <ec8d9101bea98360ef1f4c7cb5bb0450859c213b.1550088114.git.khalid.aziz@oracle.com>
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
X-CRM114-CacheID: sfid-20190213_160345_963356_1B0775D1 
X-CRM114-Status: GOOD (  17.98  )
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

vm_mmap is exported, which means kernel modules can use it. In particular,
for testing XPFO support, we want to use it with the MAP_HUGETLB flag, so
let's support it via vm_mmap.

Signed-off-by: Tycho Andersen <tycho@docker.com>
Tested-by: Marco Benatto <marco.antonio.780@gmail.com>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/mmap.c          | 19 +------------------
 mm/util.c          | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..30bddc7b3c75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2361,6 +2361,8 @@ struct vm_unmapped_area_info {
 extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
+struct file *map_hugetlb_setup(unsigned long *len, unsigned long flags);
+
 /*
  * Search for an unmapped address range.
  *
diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292e16a7..c668d7d27c2b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1582,24 +1582,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
 			goto out_fput;
 	} else if (flags & MAP_HUGETLB) {
-		struct user_struct *user = NULL;
-		struct hstate *hs;
-
-		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
-		if (!hs)
-			return -EINVAL;
-
-		len = ALIGN(len, huge_page_size(hs));
-		/*
-		 * VM_NORESERVE is used because the reservations will be
-		 * taken when vm_ops->mmap() is called
-		 * A dummy user value is used because we are not locking
-		 * memory so no accounting is necessary
-		 */
-		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
-				VM_NORESERVE,
-				&user, HUGETLB_ANONHUGE_INODE,
-				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+		file = map_hugetlb_setup(&len, flags);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 	}
diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..536c14cf88ba 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -357,6 +357,29 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	return ret;
 }
 
+struct file *map_hugetlb_setup(unsigned long *len, unsigned long flags)
+{
+	struct user_struct *user = NULL;
+	struct hstate *hs;
+
+	hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+	if (!hs)
+		return ERR_PTR(-EINVAL);
+
+	*len = ALIGN(*len, huge_page_size(hs));
+
+	/*
+	 * VM_NORESERVE is used because the reservations will be
+	 * taken when vm_ops->mmap() is called
+	 * A dummy user value is used because we are not locking
+	 * memory so no accounting is necessary
+	 */
+	return hugetlb_file_setup(HUGETLB_ANON_FILE, *len,
+			VM_NORESERVE,
+			&user, HUGETLB_ANONHUGE_INODE,
+			(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
+}
+
 unsigned long vm_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long offset)
@@ -366,6 +389,15 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 	if (unlikely(offset_in_page(offset)))
 		return -EINVAL;
 
+	if (flag & MAP_HUGETLB) {
+		if (file)
+			return -EINVAL;
+
+		file = map_hugetlb_setup(&len, flag);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+	}
+
 	return vm_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL(vm_mmap);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
