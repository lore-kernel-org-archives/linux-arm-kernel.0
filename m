Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A456320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Di/k78SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=odYsEE9okrLK+PNQnzCpyPEe8R94V9mERPHSBG9ez7o=; b=Di/k78SJAmuIdJ
	FJu7SzPgc8SmI5E6C9BhrNjRIXntwde5eYXONGTwv1+p5ivt6RHZPaGTj2m0QYgMqEkxim9H93vOj
	htYKxK8tMFf9rTnCdMgsnUp7sfxUiRZyw4c5SW5vWhnMlG4xXWoEf9GTsUP0+zaln37I2cU0f5Rsa
	2Azu4Wf8QigQPgbdTWw1hKiA3Oh9X62uoN3NVMgrfviFfP5MHcGeW6ooxmFwlO4dMQULTfSSxoDjp
	i1V9Pf2WlSv7Z945GUVJqynn+uqjppgKz8w46W3+6TfKHdrozitBiWVj0DyV079NE6LqggJFBdbuo
	oWfAA4hrwwhDPoOset2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghe8P-0003m5-CB; Thu, 10 Jan 2019 17:28:49 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe8B-0003bG-8Y
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:28:37 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MyK9S-1hVBFV3ORA-00yftj; Thu, 10 Jan 2019 18:22:34 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] y2038: remove struct definition redirects
Date: Thu, 10 Jan 2019 18:22:14 +0100
Message-Id: <20190110172216.313063-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:JFxfraV6ycMtD0g5CS6YrYFoYtT89QsNLLyOITHqT41z422VdUk
 LrBF7KqupsEuf8G5AWi7KnizntYiJSGk3aSzCC18HSoU1fI0dBkUdiedPGCRfw3YuFKI+WZ
 sn0EDd+y1lKagAVy7SNwNYRebBx2PiBsDVXU4q12xPKfpGF8+eECy1CpQL8GH5DadiLP175
 NmavfIAHIzJ7u+sIpQZQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y8V2uvPD0Lc=:23pXewO+qOOTuEOmwKX+jP
 kgFisfr5zRBzZZuJjaXma9ROzEuNKJT2knnr35Twm0RUoMnp2hqucxVC4rdVPXcNcTFpR0Sfn
 rbiKUkJQY9CuLG2wUcNPD+ombhmXiQiiGbLZeDnbamWSfrIspAq9PUXgW0Y/ouXVH1P3dFlOp
 85WCiTvqjUYqOOBL+9CGh1fcLCZ/EEOJtObyYQNX0+bmhrvIuAU3ekKvUcqhvK6lTH/VjnfzY
 9wQa7aBxZ9PkfJGY2lxmqAFTNzkF504WGbXZiK9Yp6i1YITTVJwxIH/MRyRCPS4JuiOFrU3MV
 eSef3mCQxeqKEwaIgUKdBjiWp2LcDVYSOiiLSrhzrTuVuIUFOBGKnqSJxwaH64VunRfjbBNok
 8xOTj6nxAs3HyrQSMqZYqiKmCxDi7uEm+Ti3wb1XaDfSyJbDj5++PdawZ/lqgHZA533+Szcg0
 cLDPJFjWBH0hSQE5+8BemRIEY8p3MQLCxb4v52DxN9STy5wXCTvJz0a9IN1j7O46SZYI8P3L8
 fKImA+62+KENNt62zka0WGT/U7MX3u39of/hTBUX08+nlXxIZD2IvdMW+eP9N3JNKXPXRxZaW
 0h+aYQMdseiR8JnYsU622Afkfc4GAL5wsPKjxa9o3fGH75rij5I3HvZ7We3w+TXMOgQg6eHrd
 E5ZWfhW/S4j13sg0sUJp7puicvoDt9Sb0mokUuCxN+zNN/GwtKnfbjnEWHaeGCJRvIsy+QFu1
 ntldZWOn6osKLq9kRorjVCdWnRCLvihEdGNTLw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_092835_601796_E23D89BD 
X-CRM114-Status: GOOD (  10.16  )
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, mpe@ellerman.id.au,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, benh@kernel.crashing.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We now use 64-bit time_t on all architectures, so the __kernel_timex,
__kernel_timeval and __kernel_timespec redirects can be removed
after having served their purpose.

This makes it all much less confusing, as the __kernel_* types
now always refer to the same layout based on 64-bit time_t across
all 32-bit and 64-bit architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time64.h     | 8 --------
 include/linux/timex.h      | 7 -------
 include/uapi/linux/time.h  | 4 ----
 include/uapi/linux/timex.h | 2 --
 4 files changed, 21 deletions(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 05634afba0db..f38d382ffec1 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -7,14 +7,6 @@
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
-/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
- * and 32-bit emulation.
- */
-#ifndef CONFIG_64BIT_TIME
-#define __kernel_timespec timespec
-#define __kernel_itimerspec itimerspec
-#endif
-
 #include <uapi/linux/time.h>
 
 struct timespec64 {
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 4aff9f0d1367..ce0859763670 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -53,13 +53,6 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
-/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
- * and 32-bit emulation.
- */
-#ifndef CONFIG_64BIT_TIME
-#define __kernel_timex timex
-#endif
-
 #include <uapi/linux/timex.h>
 
 #define ADJ_ADJTIME		0x8000	/* switch between adjtime/adjtimex modes */
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..b03f8717c312 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,19 +42,15 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
-#ifndef __kernel_timespec
 struct __kernel_timespec {
 	__kernel_time64_t       tv_sec;                 /* seconds */
 	long long               tv_nsec;                /* nanoseconds */
 };
-#endif
 
-#ifndef __kernel_itimerspec
 struct __kernel_itimerspec {
 	struct __kernel_timespec it_interval;    /* timer period */
 	struct __kernel_timespec it_value;       /* timer expiration */
 };
-#endif
 
 /*
  * legacy timeval structure, only embedded in structures that
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index a1c6b73016a5..9f517f9010bb 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -97,7 +97,6 @@ struct __kernel_timex_timeval {
 	long long		tv_usec;
 };
 
-#ifndef __kernel_timex
 struct __kernel_timex {
 	unsigned int modes;	/* mode selector */
 	int :32;            /* pad */
@@ -131,7 +130,6 @@ struct __kernel_timex {
 	int  :32; int  :32; int  :32; int  :32;
 	int  :32; int  :32; int  :32;
 };
-#endif
 
 /*
  * Mode codes (timex.mode)
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
