Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB4C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865C620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPJruIW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865C620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IRe9EBQblWtSgOzb0Mfrg0nARnQuz8M7JTgwEx63MCI=; b=cPJruIW1UDJXSP
	qJUK+V8LtxlwbQtvzWhWeU3cwfwxhf+HU+y0qKVMHnVUouDZfeckXJjkqwQbaAqbCNfefAKzWwd49
	7XE3fw5Pf3KbGMkpYUs8XRoRTSTeVpnGsuvjjJO0jmdKEyfdLtKKL6IVPHEEjl09eC2PJIO34yOO2
	gOB0BSPETAsPUeNvMbytlKHWVQ+0JqYFp81G1xeB0GNWDevYeiU4Y+ym3QTFvJccV3Q/uQZXc4znR
	QpkYR8d6lBUP3sEwrzEU3iPsU84BzfhvCuEDeh3Mj7uIWyuOsCvOPEDF15ajlwJ2E68LigSCSjaoq
	01ma5pHaA6Gl5wa5dXEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWzc-00006h-NQ; Fri, 18 Jan 2019 16:27:40 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWt1-0001mf-TE
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:21:18 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Moex5-1hYebH2yzJ-00p534; Fri, 18 Jan 2019 17:19:42 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 20/29] time: fix sys_timer_settime prototype
Date: Fri, 18 Jan 2019 17:18:26 +0100
Message-Id: <20190118161835.2259170-21-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:r9zYRN1bn3jR2apA4gH3kpzMsx6Z1jHN7Z6MVMR9SqgauRuwsGW
 g3AmYvhN48u7jGc9XyjbvqlEZyc2h5boSgVfbDl8HeTDSZJ7+36lDncKb0n8beoPpyVukaj
 I9WNJZ4OTm1Rgh/HwlzJTCDaYv/uB9ZvTrwC0JiXRRAA8+HE+ofgv2cP5P9nOGaG6S/KU8p
 4ViaO2EbrciAIgouxqIxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XASFSNdrSgg=:32sZlMVf4NdP/xRX5FSGsS
 1hID4IEHQyAvdyxeMVrUXuJ+NLrCJ5uDZE7FzjkhtHtfx/SENRonZqNBSFj7g2GBc6UcqbiYC
 4y0jx7WV8+9rDgN4Xnu6qMhTRFef+AdfgNDekGoN42LaT+CSo3SDr1bnE423lcTizBLhs7zyN
 24zAC1s+Tfpd8KRGJDPXFwoaKKr+rz3J+FdnX2yHY7NLpGcBbBRTUzqtT2wSP5aYdH8mO5eNd
 8kseNM2Pn7nHdd5nlCRV6RbmORl+zSQligYu1x5aZeuQne0SAotmLENDMqidJetBLTFCUDL0Z
 3h9iy6002wHYr9AAb5Ja4LmZ7NrJ8sHnnShepAP6/cvb9hQRSqAv9OKi2BNGx+kYUtUXaoUB4
 LfLbaI+YEEyJxsf84pqG5FUT76vOIUTMH7CCDWJvEdRNKA5ZkNsI1+bSk4XqCGy/cOVvmpxeu
 nGxza1i8A+ACBnz0IH7AqpEV60bzcx8rrlOVuX73nsGvgCJLaKzzcLxDe9T/LwSLvuwPmfDDY
 V8hDNOLQeyPO7rK7V2YnmtGE/Q2S6odeUtznHsJefZy8VlgA0H4l4W/YVHfpoxOiqq2JmpNrE
 l10cLnzMxgSLcVHJdMMAPcY49WQfbo9aSPXl0CyX6i1vTMTPaOwDRL94bv0rOfl38+ea8x4Iz
 b7ArQdZVUEWmatIdXq25G2pktwQtICJR0s577+vznODrG5wDttLBMXvHeGtrU72aZWSQ64ghA
 jxdzIhiv6Z/liKFKlOc2lyxLatu/RdmJblr4rQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082052_673756_C8228A93 
X-CRM114-Status: GOOD (  10.89  )
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

A small typo has crept into the y2038 conversion of the timer_settime
system call. So far this was completely harmless, but once we start
using the new version, this has to be fixed.

Fixes: 6ff847350702 ("time: Change types to new y2038 safe __kernel_itimerspec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 938d8908b9e0..baa4b70b02d3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -591,7 +591,7 @@ asmlinkage long sys_timer_gettime(timer_t timer_id,
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				const struct __kernel_itimerspec __user *new_setting,
-				struct itimerspec __user *old_setting);
+				struct __kernel_itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
 				const struct __kernel_timespec __user *tp);
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
