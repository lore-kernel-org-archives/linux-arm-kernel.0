Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4F5C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCFA2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jH4A8PF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCFA2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=227dyKzKAFz3k8Ksa41aeauuOfAcOtx0hFEhge594Zs=; b=jH4A8PF8FkjEAy
	7tCHAxszOIMaKFDxW1B/79X492zKR5ivefAdsw7vjoRDxamAXP5PoGOYX7oJOcCT8PkItVqw/Fn+I
	mTg4OEQ0CxZU9N89RscNSUpdlqtHOntQtpwn5TNu7PkRIv4ILHZP+MrDjBMx2DocQArTjgVObTnKq
	+QlArB4gEq+No+Eb+io7qfWy2RERL/2etwyzfwQReUwIuRfjaip+qspA+Q6WuUs/WTKuLblOlgdHe
	b8u1Kkvc+9p/3J7yUTdUBf+gTIA+AotfY7mDa1sjru+912cdd6RknpKrhfKjwRVfc0rJ3YRwg5p1i
	R0OszGaxiL0LhSjnMfEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdBM-0005pz-Oe; Thu, 10 Jan 2019 16:27:48 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9q-0004HV-7Q
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:17 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N9Mh8-1hK9GT0x08-015KyR; Thu, 10 Jan 2019 17:25:09 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] ia64: assign syscall numbers for perf and seccomp
Date: Thu, 10 Jan 2019 17:24:23 +0100
Message-Id: <20190110162435.309262-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Aqo6N9d9grrvjwZZFEqN/kvQ31MLlDiiylB1bz3l3bnWOkX29Jb
 FIpuJ/jDdTbyft/4m0XHsdrBBVlm/5kn3AxdnjdvfrdFVcnigok/cmoOYzEopX64Kvw6dls
 WX4c0A3ajbuIPBhtDJnOxItEcolnrdicUdlbDH0vyMO4tFgIrLIN3zrBeur2mEJPy3oMIBX
 ZH1cdK/uOrjSnDnCsmVEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcqPdkrtZkA=:QS9oAutwixmbvSVltaI9L6
 +m9uizBojpDw4Y/KGXSwSjuE5RFBEi7OZQFNyG/xCTeJGtb6VPYkwAOz9MsrA2pxEiUjFa9rG
 fuJdxhEHR1LixU3L7SSftPuAu/E+HMI7cMR38HXeU8sTwYxz1Lhfz/ndk7VKbWpgR6e48hHTh
 52oG4XPC5Sd/bup/d7xyO1GwtMOv8KicBE7MTnwJg30UL0KV+2zy8+uaQIIBfpCDfWM6kjw1Y
 9zf/dxhuEvLX4cTqoUgQnILjvndG21zv6xai7n9Mo8+weKMX3oFsIyKniIqcYSLZpFjZZad6J
 iFX8KqIDD2L15m14S+VUGqz3BXl9nnN+3YZmaY2aCgRLj+1lVPyqEAJNryhh8rK6FIJ8GHxDJ
 b6kKEjdlplavAtZsSD6iylVr6KSzwNw62ShZ5OZvUL5XVI3/keVLJIlNTf9Dj4xsiQPsm/3YS
 hBnYM2p500m6A4e6wcUThTchOc2YPdSSH2b1Gg0KaympGurdwlWM2AnEkcYg+rJMB8ejQK2OV
 FvODRVy/7YsxTrzkyuDInaJdUb6X2TzSWEOoqh1ifvX44kfRzsj3wFkCRTG7Tcl0WUsDB/tak
 aArpMEZ5ewfQfVdDVvG0xAc0R1LMlt+LCk6prUqgqK6D+A4b9mninT6hfcvtpKZL0P1KVrvKJ
 elmxmdqcPPwGsxzlTz8rV4AOm/8m9AoXxIvPJ0wCPLcEf+m+XNV/BH5QBhqwba8jH8VLEyHqT
 16Toqp4Rzx0iHqbsVLKUtulq49kZQX99otz0fw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082614_562758_552E04A4 
X-CRM114-Status: UNSURE (   9.09  )
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

Most architectures have assigned numbers for both seccomp and
perf_event_open, even when they do not implement either.

ia64 is an exception here, so for consistency lets add numbers for both
of them. Unless CONFIG_PERF_EVENTS and CONFIG_SECCOMP are implemented,
the system calls just return -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 52585281205b..2e93dbdcdb80 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -337,3 +337,5 @@
 325	common	pwritev2			sys_pwritev2
 326	common	statx				sys_statx
 327	common	io_pgetevents			sys_io_pgetevents
+328	common	perf_event_open			sys_perf_event_open
+329	common	seccomp				sys_seccomp
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
