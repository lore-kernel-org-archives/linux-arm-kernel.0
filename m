Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28592C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA26F21900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HcslyyaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26F21900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZRmeZs8P9DCwlgR2CJodmQPCgW02jGKrMT/Jct+Wjbc=; b=HcslyyaYVtV/eA
	JXhXQz7ybkSKmS5oT+nOwtkOMnRvH2INsQEdocsGkOj44w9JLZOSrp5ZDGIIEdRB0pQo7XLc+Ttkw
	j+4C5KGBfmMQw4OiMYuKR3Lub1j8RElGcWY1UfTCfZ2JL9/+x05SDvC3RDYSqdixmKYpZUt6OX3q1
	2ZBJAQJBDftLufIoj4OL1j1pWWqbfvaVE/4tpXR9Z8VpraxTFMhXu++mkQujHzQKerReiRTAVcPW4
	DQolb0qkqLO8aYwBK8FWi/+qAMr5gHHxAJAEtIZJyi8ugWdq/Fn07pzHD/VHwgpR7pZxxdVFvYVqo
	3ANNQbueaK0NTiXjLjtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvq8p-0005R1-Kr; Mon, 18 Feb 2019 21:07:55 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq8l-0005OY-WF; Mon, 18 Feb 2019 21:07:53 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYvHa-1gZvZR2VSy-00UtS6; Mon, 18 Feb 2019 22:07:29 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 7/8] csky: Use latest system call ABI
Date: Mon, 18 Feb 2019 22:07:11 +0100
Message-Id: <20190218210712.3503891-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:b9uGlJZjYWR0TeRDyLkO0y46fjRMT6X+cqSqFO9XKVQTCBbYU4k
 lqAzapNVCiizm6JQu9hlZXLd9zdDa9NpI6N+vWtguD18PgqQWTdIUMiNfWHZyyu1VhmCnZO
 YuhMkgj/O//KHs+9BWKQAluN3GvcadruPhi2m7LWm2ED2/epAJVhzvFqPEA0jiBJGkYNa1z
 ef5UNsDCjbuUd1nCxCBzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yfd0sA9GaOs=:n7pkNDVjGX9jsrtkpjCKIV
 MvNdGj/B2VYYToKFb9TuPve71L7+IOm3/m1RCEuBcNbHVzfi8Emh1bkaa7pEB3XdxI2f5Xxah
 G3P7RlCMPGJOigz8xG+g16DXO5WzQQ20cohHSra7HNSngbL/jBCaI9WidivWeqYD7j3r12zyi
 bFtTj44bzd4yQwNOgdkzzGMaGYuuoaTCzXqDHYAiFUL+U+dcSFJOYQW18COw8vtgi7+/H4jwA
 PKmhKUdYYTMIXfsn9UB1Ix8R+2u07rBRyPa1alYMR4rbphJdyYznT/nG8r9NkKjYVufKkeToA
 tX76RZ/OzwNr2xSpl60cgLFDy0w9YOGKAIz79D2zDSAt+ekxc/+GahpvAUk41+PZsPV/CR9am
 5ww8qcFJ7KxnfkAg9SpVSwIxHzGV0kw3SiR46FdF4IvPSMgcbpI3PX1vszcTMaNtrcMP7Ft2y
 kaiaWtwZHtdM6WnewsRAfHQJsBwF1oia3pggtfzbltLG6MkoBRjc5GAsPW4Aa/WktuMjUqbD9
 3f3eu1XmnOAQUL3mq3GJhP85UdM1qoiANVdgpWg1eFVcbc4z8NmNlIoNmIvZz387xvq69rxpQ
 YfIWJj9/ZKhwjAYQSbD/HD/MBzzwAlnybqjHn1pSWtB5hnIgVJuIDq9Kg63l/eaU4Aks2tgwv
 pAfKYIFDhID4rHBl2cJFxxCAZDvVSk3zFn2/2SWyPszeYuNF+KMp7tqDwEHKFSnpmrS8rRwlG
 vY3wB1GLQ7Vv12T2FIyyPgLmxKnAad1RKx+GDg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130752_353325_E5C79ABC 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-arch@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
 arnd@arndb.de, yury.norov@gmail.com, linux-api@vger.kernel.org,
 Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>,
 Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 linux-hexagon@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@pku.edu.cn>, Stafford Horne <shorne@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We don't yet have an upstream glibc port for csky, so there is no user
space for the existing ABI, and we can remove the definitions for 32-bit
time_t, off_t and struct resource.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                   | 1 -
 arch/csky/include/uapi/asm/unistd.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 6959e0b1e956..398113c845f5 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,6 +1,5 @@
 config CSKY
 	def_bool y
-	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index ec60e49cea66..224c9a9ab45b 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -2,8 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
