Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3815220866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKfSAGkF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBdGHcjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3815220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PdFNbnnrVBFTzzE5sFBKf1mMnUaF/QOykBkjwdUBGAI=; b=jKfSAGkFqGiVz6ZiCMkow58THJ
	+fDB/FB18g9j5ruFn09q/J0HV3fXigClXswLwXSU1Duugrebi/balYisHChGsWtALxDF1L78/SQst
	28bkIx3w/Ge7I7MXvTWBN8qebTQO1XxC/XMtVldQrbzqsx1Ecc7s0WPsGbcm4ye1piAsoX1lYLqfp
	uIsZJIwBRVKox2Wtdkob3FQnu0hG9U/ssuQgoks3Af2QemvoVf6MqREEXX+W0QLUDRN9Y6ZRm0JFL
	IGEUDlgjdWUee73AWourpILBCGjO7sv5NwTdcJM4Nb2rNn/Ipji20fy1ZCreK/c01htuBPXh+LLV0
	w6HXCQBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjluQ-0000j6-5D; Wed, 16 Jan 2019 14:11:10 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjluE-0000Nb-JR
 for linux-arm-kernel@bombadil.infradead.org; Wed, 16 Jan 2019 14:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:References:In-Reply-To:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+WO65qGvG92Tj9xBbhq/NTzQLjNVNHPp/uhUZMG0p7s=; b=YBdGHcjU4XCEIuEngLBX8EP+A
 86Czt6aUfRXx9B8QrpxuoC1mcAC3T5CT42X0x0lI/O2gZlKsA5SHA4ZoZ8iqiiZkXeHK2X+tvphdf
 1SSsGFLRUtK/RGtwi+hJNZqwJZ5zg9v68KpmA52+ZZ5+DvwUTTD5d9HXFdGuKNEr/mB9CRWWN2TMj
 r5fnE6GPD/lyry/UcmlmS1ohNToNIi96RbnVm7jE8xzc1HPb+DV8tsLb1ag4YqsivCPSgPrmR39v7
 i19FEENXRW1miaKWNFweNxI5HOhRMu+j4DywRFMFqdrNnFD9E8/neR49elbdnlZvtW+NwidKPskoV
 wXKBXp3gA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjlVs-0000jx-3Y
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 13:45:49 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDeY89036398
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q240wd11d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Wed, 16 Jan 2019 08:45:47 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:45:42 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:45:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDjUvO57213156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:45:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 414374C05E;
 Wed, 16 Jan 2019 13:45:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 232B64C040;
 Wed, 16 Jan 2019 13:45:26 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Jan 2019 13:45:26 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:45:25 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 13/21] arch: don't memset(0) memory returned by
 memblock_alloc()
Date: Wed, 16 Jan 2019 15:44:13 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0020-0000-0000-0000030747CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0021-0000-0000-00002158646D
Message-Id: <1547646261-32535-14-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=959 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_084548_321544_598AC5B2 
X-CRM114-Status: GOOD (  25.17  )
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

memblock_alloc() already clears the allocated memory, no point in doing it
twice.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/c6x/mm/init.c          | 1 -
 arch/h8300/mm/init.c        | 1 -
 arch/ia64/kernel/mca.c      | 2 --
 arch/m68k/mm/mcfmmu.c       | 1 -
 arch/microblaze/mm/init.c   | 6 ++----
 arch/sparc/kernel/prom_32.c | 2 --
 6 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index af5ada0..e83c046 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -40,7 +40,6 @@ void __init paging_init(void)
 
 	empty_zero_page      = (unsigned long) memblock_alloc(PAGE_SIZE,
 							      PAGE_SIZE);
-	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
 	 * Set up user data space
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 6519252..a157890 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -68,7 +68,6 @@ void __init paging_init(void)
 	 * to a couple of allocated pages.
 	 */
 	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
 	/*
 	 * Set up SFC/DFC registers (user data space).
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 74d148b..370bc34 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -400,8 +400,6 @@ ia64_log_init(int sal_info_type)
 
 	// set up OS data structures to hold error info
 	IA64_LOG_ALLOCATE(sal_info_type, max_size);
-	memset(IA64_LOG_CURR_BUFFER(sal_info_type), 0, max_size);
-	memset(IA64_LOG_NEXT_BUFFER(sal_info_type), 0, max_size);
 }
 
 /*
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 0de4999..492f953 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -44,7 +44,6 @@ void __init paging_init(void)
 	int i;
 
 	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-	memset((void *) empty_zero_page, 0, PAGE_SIZE);
 
 	pg_dir = swapper_pg_dir;
 	memset(swapper_pg_dir, 0, sizeof(swapper_pg_dir));
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 44f4b89..bd1cd4b 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -376,10 +376,8 @@ void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 
 	if (mem_init_done)
 		p = kzalloc(size, mask);
-	else {
+	else
 		p = memblock_alloc(size, SMP_CACHE_BYTES);
-		if (p)
-			memset(p, 0, size);
-	}
+
 	return p;
 }
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 38940af..e7126ca 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -33,8 +33,6 @@ void * __init prom_early_alloc(unsigned long size)
 	void *ret;
 
 	ret = memblock_alloc(size, SMP_CACHE_BYTES);
-	if (ret != NULL)
-		memset(ret, 0, size);
 
 	prom_early_allocated += size;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
