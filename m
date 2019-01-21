Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A2C282E9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C99A2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nT5zDqJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C99A2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=jsQJuHNCkqFjSdAXN2feXeOm+85FHjWOwKk7AhWFdZc=; b=nT5zDqJsvG52cOvIddrtXI7rih
	d22Gf66KnRjtRVKSSufaf/iYky97ThqyclRaQM2ZMveFvlXgxno2gQos3w9ElT9M7YVykbxYqHGM2
	2UXg3bS16LbpYkwvdL5/OR6s0cCAlCoJjQGHpgDMmEWQkGz6HR652Znk2F0DhoiV9+urIzwRHzMBU
	vpHgYEM26Dpc7KSw7CMjvGW+SbPFFHumBj1jHsebkA8Qppu9+pIljIW9/DNkUiTPOVRgR8Qw9Dio2
	bBxWihjvUqZAxDmZCeA3tXIvGoKMxS08uGjHkEYyYDMFuIbk/7322sk5SvwUiDlcXGRfzxPV51jgW
	GLxOxVpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUeu-0001fH-27; Mon, 21 Jan 2019 08:10:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUay-0006Ak-Up
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:06:32 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0L83oxC064617
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:06:12 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q57kw6a3v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 03:06:11 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-arm-kernel@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 21 Jan 2019 08:06:08 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Jan 2019 08:05:56 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0L85t5e37879924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 08:05:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98CFC11C05C;
 Mon, 21 Jan 2019 08:05:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1C7B11C050;
 Mon, 21 Jan 2019 08:05:50 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jan 2019 08:05:50 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Mon, 21 Jan 2019 10:05:49 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH v2 17/21] init/main: add checks for the return value of
 memblock_alloc*()
Date: Mon, 21 Jan 2019 10:04:04 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-0028-0000-0000-0000033BE195
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-0029-0000-0000-000023F915AA
Message-Id: <1548057848-15136-18-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_000613_849038_58DDF56C 
X-CRM114-Status: GOOD (  23.45  )
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

Add panic() calls if memblock_alloc() returns NULL.

The panic() format duplicates the one used by memblock itself and in order
to avoid explosion with long parameters list replace open coded allocation
size calculations with a local variable.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 init/main.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index a56f65a..d58a365 100644
--- a/init/main.c
+++ b/init/main.c
@@ -373,12 +373,20 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	saved_command_line =
-		memblock_alloc(strlen(boot_command_line) + 1, SMP_CACHE_BYTES);
-	initcall_command_line =
-		memblock_alloc(strlen(boot_command_line) + 1, SMP_CACHE_BYTES);
-	static_command_line = memblock_alloc(strlen(command_line) + 1,
-					     SMP_CACHE_BYTES);
+	size_t len = strlen(boot_command_line) + 1;
+
+	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!saved_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	initcall_command_line =	memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!initcall_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	if (!static_command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
 	strcpy(saved_command_line, boot_command_line);
 	strcpy(static_command_line, command_line);
 }
@@ -773,8 +781,14 @@ static int __init initcall_blacklist(char *str)
 			pr_debug("blacklisting initcall %s\n", str_entry);
 			entry = memblock_alloc(sizeof(*entry),
 					       SMP_CACHE_BYTES);
+			if (!entry)
+				panic("%s: Failed to allocate %zu bytes\n",
+				      __func__, sizeof(*entry));
 			entry->buf = memblock_alloc(strlen(str_entry) + 1,
 						    SMP_CACHE_BYTES);
+			if (!entry->buf)
+				panic("%s: Failed to allocate %zu bytes\n",
+				      __func__, strlen(str_entry) + 1);
 			strcpy(entry->buf, str_entry);
 			list_add(&entry->next, &blacklisted_initcalls);
 		}
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
