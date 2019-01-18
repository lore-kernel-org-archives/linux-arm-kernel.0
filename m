Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51807C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7E520883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0UmWCU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7E520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Emdtf/vNvaxNMSCr6rbp+4oMUzrKfW4LOvQkSsrx9I4=; b=W0UmWCU//6WyMg
	C+um7zIqu/ce/FD/XFhD6fPOF3eX1cpVhaYB7alClXqPKcryzz1oYDUAxZIegGnfrCv0etNV7pLd3
	8OJzWGy3PLcBhBXFK0ondntqAtaqjOaGmva5wH7jBY5cIrKhsYhD3XKhQeOmR8QP5fCt9VPIajLJG
	GCxK38P7UgFtTmdc8qkzdvj7NLhp6tSa3DZYo44Bg6Wd3cqi2yjY8aGC8Enrhb63ubROewMV3/AMa
	ZsU5BfbowJdhUpjQIhCftqPyXakbXoB49sPj70BT2HwQJmv9YOjHkXqhuzaWHZaJtBv3pgUeXGwEQ
	FsElLMqoSnub/taEpJsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWvV-00047H-Ad; Fri, 18 Jan 2019 16:23:25 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWst-0001cR-8V
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:49 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M4s8v-1glu2i4Ab9-0023hU; Fri, 18 Jan 2019 17:19:36 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 15/29] alpha: add standard statfs64/fstatfs64 syscalls
Date: Fri, 18 Jan 2019 17:18:21 +0100
Message-Id: <20190118161835.2259170-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:rSakGMBaEBbAtQUcV3qv3NM7i+OWluASRZee787Xpo3/o23caVn
 QWs5OY5vh9opxy1/zCZ9LY9N9pIJScThNKTMUOE8nA6un262wDIq2Fjhg5yIiWEmn82x0g9
 8p3VeDjI0Rm19xjqPj0Z3FbT5slvuvHZtcUqZPj+gSCMB48TPbdYEEw4VLMKLx07SalqB3b
 h3OVH5LxVZJKnyB7bc21Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lg2Zcst79FI=:RjM/7u0hFuGHZ2BRfjTPMD
 8fbJ1Oqm5cIPC9GeaHvhUwxiy6Kjrm/A90avnT4gPYEGG3drhLEmcVMffAdNdtsLTT2kOQu/9
 9U1iqxCzfMtamHuo+Lvykvje1o1aTsd2rp+F0IR9Sf+vhzfs3Ry1952VDFu0nPS2jVP/yso/5
 /zohi1guOX5+PufGw5W40eWBbQtN7cydGZxEf3WMCnZ1zcVlXCx6sY9+1Rjbyvf1+k0f18R8K
 T2QJYu7012AdY16U6LfPR/21li2ADSjVByZ8E43b8tHba6P1U7dW1+DOogZ+wfBjkG0FW+22+
 hK/j1NbUyVDgs/0sAib43CUyRFQovnEdIJiz9ogsL8XY5ptvCVdCiXlgq8U4xBKgcba8zQ2zK
 zP7aq+pVaAWVNpRw9ucrV0CNZqVVkj6exO56AwQ7TSrWLv2er5omNVTKolhgh+K3vCud/MP3k
 QFUAdqHPpxJFDVWW0QclTKKiM+AqrHzrkW5L2rYyv0TKN+BltH3vLxKleH3bq4UKU3V9M54VY
 149cHyT5F0DL6qHinYu9NHirim1imOhLAhDnmiVl43A3WqSlfS3sTrd2jeYunrJrgAn5huc69
 rDrSDi5snBC3J6gkHsCqMxkqovxLuN0yASzWROjAAglW0rMvI5oSBu5kz+U6ziG7P0chho9G4
 NVjYAQ/GPHW1EJskkpatgeukn2lCfJ97qsSET1mX9q1QVgyHAWcBLswP9TPLd0jQA+/DMuOon
 r0AZp67Be14b8gSfAB9zm3btQOHXBPlWLDZnkQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082044_208963_86C6C39E 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As Joseph Myers points out, alpha has never had a standard statfs64
interface and instead returns only 32-bit numbers here.

While there is an old osf_statfs64 system call that returns additional
data, this has some other quirks and does not get used in glibc.

I considered making the stat64 structure layout compatible with
with the one used by the kernel on most other 64 bit architecture that
implement it (ia64, parisc, powerpc, and sparc), but in the end
decided to stay with the one that was traditionally defined in
the alpha headers but not used, since this is also what glibc
exposes to user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 25b4a7e76943..0ebd59fdcb8b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 525	common	pkey_free			sys_pkey_free
 526	common	pkey_mprotect			sys_pkey_mprotect
 527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
