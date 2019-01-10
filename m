Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF87C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E088206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6vLqAy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E088206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f+1cMpZxC/BDfbkFXloz2p1mQxj16YfNWYYipiGE4QU=; b=Q6vLqAy2m7i7GK
	Rz1i22SNKFLKCpozhoy9QOyev/mblS4diDv/2qqeWebqfCCAFzputWfDIDOyRqr6CYyMu/0zU3YNH
	IMsEr05FlT0GH3SI8miFWZi4XadOoeKg+mvpr/lNxp5n29Q/bCo4D8aKstsTQK78Br0jduOFSQL4C
	dfDaGuyYJ3kdWgmiaL4DN/oQ+KPEhLOPCjjpflMNs9rSQtZEyKrJ31efKn8JeCTMEDSz7Yex2ZwtE
	U4uIjGX6BBVZsk1vse6zWOBGNCyRAvias2lqxImtBgJYhW7ygiJR93cYtLlsXbvkEXlxrXssiNzoe
	9n0X75iVZSLhZ7OKmEYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdB6-0005ZM-Gh; Thu, 10 Jan 2019 16:27:32 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9p-0004HU-PK
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:16 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3UdI-1gh5Av3nYQ-000Zdl; Thu, 10 Jan 2019 17:25:08 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] ia64: add statx and io_pgetevents syscalls
Date: Thu, 10 Jan 2019 17:24:22 +0100
Message-Id: <20190110162435.309262-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:jZ+pK1soglClNV8JzDCTro7NHj/jUQtDuwPrtlNj70FE5cXaEjQ
 r+SHifgmj/OSg7YZwhAOnPSW9mMqXmoPHKnySSVlYLAvZ5Qhmn0Ta+SNUS25ZKwBP+7W0FI
 oC428/ece5QP7XVIUK6jj6GfWl2BehhsCgBk1eJ35E6ipEp+AkgoJ4p50hpr3L8WlpiANBy
 Ux+9nIr/6cdCw6+aDpHaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEnbB0N4QPA=:rFF45PK4fVaAoP1KJQfuTu
 qvzYM8C+SXZ0bdt6/VS1aHwqCz9bxt9HM0Dy+SmyNnsMPzSGOvYUznlNmPBP7WaOWN0H5/Hsk
 wxXtf6q9lDrPBVeh9tGtqh/pqc3fNDVJGBwe7R4H4MOKF5gBFDjdrUfh6kTv/6hZ4VFGEfXPu
 k9JND7wy/Q2wfIh4iR74yZ8OK6p5d2VXYILYRlJt5yqqV/4vm0mIg4RabkqYyniSDjAqoA/yR
 4neMRN765leyRi0iM7/PySopaHdETBP6GgGXogfbu1sh98uM/8LzEo5BgiQGRk3LNOPzb6kHL
 dzaPrOjflqNJGjbPhhKSRmG3IMKFRiyLtGNf0B9RcDIteLZiWGBTgOR3iASyXUwTM5jbvHYgO
 xNSP+vUMJY+PDeHm4b8Yy64mS1bUGhxJqdytmPQcSw63vqGswdT1vxlphYGiDQeqHitDVFDrI
 Soez+KleqeFa8mcLOsKe6ZMqPJTG1MqVfOmsdnuwKJy2UUWy5aNh0BsMpbD7/IwUBv+XL8MZJ
 EtPa5ZK1i/IEf6wgxy8JWdU8NQaVBJ19YEXykvAAYJ11RWKsFBUGULs64DI7sN91HITcMOMPB
 5EpGhU0ofNb/PBtMBhqlZdNvcgLmG6FvIw7LhcS+IHweR6qjnVPU+vtRy3UrhpKJiLKuQgrwS
 RgCxnAOj/yl+1DloOIxpgLtvFmKTkShVrAJU0h3SoLsnuQ3+rkRvC0iczX5xOWaXZebvIKRH/
 7WlXNpAGcwfi5K0UvkY0Ar+HWNEg1kGaLHiv6A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082614_120719_564D3626 
X-CRM114-Status: UNSURE (   9.02  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-m68k@lists.linux-m68k.org,
 ink@jurassic.park.msu.ru, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All architectures should implement these two, so assign numbers
and hook them up on ia64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index e97caf51be42..52585281205b 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -335,3 +335,5 @@
 323	common	copy_file_range			sys_copy_file_range
 324	common	preadv2				sys_preadv2
 325	common	pwritev2			sys_pwritev2
+326	common	statx				sys_statx
+327	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
