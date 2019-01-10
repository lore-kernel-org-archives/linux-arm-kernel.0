Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF2CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:24:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5C920879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rJSKmkWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5C920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tGnV5xedv5s+1xJzr98axpkt4a3Nco+E+dOnEd70nxo=; b=rJSKmkWsWhc9LR
	q43GjuhxpNB5cpSSo4qQo9q4kLu8HbpzsUG6/T09uEXpgq5Bv87d1/WBOu9oo7+2QcDCdZXOWdc1s
	JI0MLC4TwjVTO9Zis+3mtumRy4bkRQ/jGrwtYyD32P/dAHtBS+mbcUcb7LPHmcoQ/CZGYNGyOZVMF
	awOeZCQqxNPFfsPqsOqW52sxdyM3L0XetpESy99rlUexTkOkXe4xhUgw+G0+G/yCkMNz4IM4q6wR3
	qpeOZetC6RuIYArOC47JzeGSBO6UTa5FgYJ+58VMSKUhZDD6yvGBXiB+1pvQ/s4XO4rloj2Z874JU
	IpQE6f4yC72CQF02XTyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghe43-0000Yv-GI; Thu, 10 Jan 2019 17:24:19 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghe3K-0008B8-4B
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:23:40 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McH1O-1hI4Fh1sui-00clIh; Thu, 10 Jan 2019 18:22:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] time: fix sys_timer_settime prototype
Date: Thu, 10 Jan 2019 18:22:08 +0100
Message-Id: <20190110172216.313063-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:3gTXRESf+h45Wvylwj9vM5Tda294DtDs8hhcZWgW4vEmMf66/zd
 hIB9vsXzYxRm5RZp35Ogjn6bqTec1vMAcTvQChqgMUCCk4LwBUmbpf4G9T4QoD3ki9A93eN
 nfkWegpv6J8c56JtHNLVhMjiBjGBTG2VcPlkL8lswl45ryU3nIXdFJRuZofh+00SPluw7pB
 Irr3BMn+tj5jjtoJ7fqtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h0tMv83ysn0=:OM4Zv09Xf1B3x0L+/3KO6x
 e04xJJ8iYmGngbOe2nReDYpA4tuZKa+1MerLoy0MrDtVhYnyD/R/DMr1TkPbJ6MVZYzCMtGdB
 x7bWaPYwUDzBW9IX4QooXgWxFSxxCifR6bvcemt6R3g8D/lo3gIXvHZ7NDC8T4lPqBgEVjdUp
 5mGQaFc486H4LzdBb3XVHnulw6TJSiRZm/EioSczE9ZRUyq1LXpL1YntwKStPelMkgoMuCI9I
 4srTCsPoYSNv7a1rzmRy4uhSHNFk5chRt2w04GOQZD6wlRbcWLj7c+0bP9gUHanTiy6k9YYVs
 1I+/gzYw3VNVWqiEU24XGmAVbWGmwqtlSIAnoC1Uzx12MK1RH8CPJhHmsEwxGlHr2EDBVcWuF
 HA+tvdiMxGiCsRnQR9VosZmKFczCJkq3xjcwDml/j8ZBVr6w2njucIHM+295fIp7lbRl/WAIg
 K/p+CbxNOaOjEEZYTcqNj+RpZW7Xe5o2BHoytjTUArg/KIlH/akMbPD1TCvjAh886BP3gQafp
 OX/8TKrMiI6LTW36MfHGMgvRQgxpW4CD+u/lLyBO7uiqMAUESBtaexZkWM4G5UEkbNKOmO24Y
 wXIL/DizPMuoMLMgXzWWrD4iZQ5pbhZ2FmXV3zCbDrRzxpZqhXC63IEnezj/qWZJPybnBUCvy
 VqHVALmlPBbAQLNfc7h3Fv0mi/yW+8fKVxIxvQVSbRN9UL2cckfBt75dWyBM3v3K+yeOt8wD1
 p3EKZTw3ihTagDKn54jsKPyk76ZV1t86nHZnUg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_092335_090655_A3564BA9 
X-CRM114-Status: GOOD (  11.68  )
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

A small typo has crept into the y2038 conversion of the timer_settime
system call. So far this was completely harmless, but once we start
using the new version, this has to be fixed.

Fixes: 6ff847350702 ("time: Change types to new y2038 safe __kernel_itimerspec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 0296772e8fe5..8e86d9623d4e 100644
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
