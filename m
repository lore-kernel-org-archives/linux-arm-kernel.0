Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EEC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:11:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E3D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CaZDxQgp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lh8TxG2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E3D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FjUwj4zufepaNcLZc8mqDJsJnxqfrT17onc2h4H8tS4=; b=CaZDxQgpOd77SnmkuwlJAOzPI4
	jw2ElWM2RFhehUbj1t43dva0pGY8PwWubwcQC+dZGBlvbJHiNe+ujqynLTFce5+zfzNhPMpSeuTUK
	iFHhKLnMDeVLRxFyMalFR/IMd7ZYSh0Ff1tPXkIP2V0zxcGlFqc6GM9TdFK+tjthZgpHyt/jKeMkl
	aEI+K4HABw727/CYKxzh8i4qZsSmMvvRgUN02AbuiXt1DHP2EI0HV51k6832+et78RSRrfH0J62St
	ZGucM4hfejKkq7zpus0yLHA4iNnbVnhWCK4AxbNFQ8QR8/xSmnw39NNtXgUpoIpPxjujUxraeIGv7
	jtCPIxOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVc6-00041m-I8; Mon, 21 Jan 2019 09:11:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVbV-0003Tm-Oi
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 09:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Message-Id:References:In-Reply-To:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2sJII4e1upoFOyrcnYmC+9z2fapNjkcGCiyXUZ46T0U=; b=lh8TxG2zKfru+8bRDOZm96+X5
 vQ5aQEiCrs8LGb73lhudSXAEczA2Zo6bebs5tj55/WA+fVuYp8exbND8Dgy+dw6RPfVpBCJh3YhvI
 frdzd1evZZjSZMwm7lFfb2CqYpvqK8MvGHjjflb5HAVQqk3mcvV9BIP83WJoTWCJgzi2ynnRAEMX2
 IevWfAPa6jWd/4WGGPzF1DvrUw79nm0KaGykXJ2A/8dKSsVLQIreE+1pnm5rvsM1i5OQ5wU6Ijq4s
 trDESGcxIr6F0mQJfnMQrWrr++Bfpxf5bOBoZnL84Oh3OoPtwOXg4fhdgwDBCLntyee4K0hfyIhlU
 HXewtG/xA==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUbH-0008GM-3A
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:06:31 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L83pLS064676
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:06:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q57kw6aj0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:06:30 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:06:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:06:14 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L86DUX57606264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:06:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 095F35204E;
 Mon, 21 Jan 2019 08:06:13 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2FD2852059;
 Mon, 21 Jan 2019 08:06:08 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:06:07 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 20/21] memblock: memblock_alloc_try_nid: don't panic
Date: Mon, 21 Jan 2019 10:04:07 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-4275-0000-0000-00000301EA20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-4276-0000-0000-0000381015ED
Message-Id: <1548057848-15136-21-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_030631_302271_D38EFF06 
X-CRM114-Status: GOOD (  28.19  )
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

As all the memblock_alloc*() users are now checking the return value and
panic() in case of error, the panic() call can be removed from the core
memblock allocator, namely memblock_alloc_try_nid().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 03b3929..7164275 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1526,7 +1526,7 @@ void * __init memblock_alloc_try_nid_nopanic(
 }
 
 /**
- * memblock_alloc_try_nid - allocate boot memory block with panicking
+ * memblock_alloc_try_nid - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
  * @align: alignment of the region and block's size
  * @min_addr: the lower bound of the memory region from where the allocation
@@ -1536,9 +1536,8 @@ void * __init memblock_alloc_try_nid_nopanic(
  *	      allocate only from memory limited by memblock.current_limit value
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
- * Public panicking version of memblock_alloc_try_nid_nopanic()
- * which provides debug information (including caller info), if enabled,
- * and panics if the request can not be satisfied.
+ * Public function, provides additional debug information (including caller
+ * info), if enabled. This function zeroes the allocated memory.
  *
  * Return:
  * Virtual address of allocated memory block on success, NULL on failure.
@@ -1555,14 +1554,10 @@ void * __init memblock_alloc_try_nid(
 		     &max_addr, (void *)_RET_IP_);
 	ptr = memblock_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-	if (ptr) {
+	if (ptr)
 		memset(ptr, 0, size);
-		return ptr;
-	}
 
-	panic("%s: Failed to allocate %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa\n",
-	      __func__, (u64)size, (u64)align, nid, &min_addr, &max_addr);
-	return NULL;
+	return ptr;
 }
 
 /**
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
