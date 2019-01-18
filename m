Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26A9C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B520C2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BxZy4uRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B520C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f+1cMpZxC/BDfbkFXloz2p1mQxj16YfNWYYipiGE4QU=; b=BxZy4uRame5506
	K1Wf5+vgWyE4F0yY7u9O5aJGTAPpa+zh6WZC6KNQVCJUZiwyrTGaANS24qE2IHaws1DZhDcuxXyG4
	QIXxZH3lmtDpzueevOTgkRFfdWsDbP17tObWXYt1kXkYROu7+NVt9OpBteci/2wNnPGBZoMJHo539
	nYwD/qsexiQG4eL95ta3I2/eCwnxKxvX+ZQXeSE34ZyleU7dGSzIKMJXaKDuG+JieiTB5iv1/NyGX
	f8YWQ3MLeCygnUj+DIF1EQ63ajMtXaX4b08RFBCLPE2ugeLNbxkgc1ioUZNGMQPphl4ZxaWPx2CZy
	QMBukGkz/J/sA8Z6qIZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWsf-0001Oo-QO; Fri, 18 Jan 2019 16:20:29 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsb-0001My-6Z
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:26 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4i3d-1hC3o90g59-011gmK; Fri, 18 Jan 2019 17:19:18 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 02/29] ia64: add statx and io_pgetevents syscalls
Date: Fri, 18 Jan 2019 17:18:08 +0100
Message-Id: <20190118161835.2259170-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:iIDCS1VFnyKTHSdfnANmJaXoeSIZjJNeoIeNpmRgK3i74OpuB4O
 eJR7+B640nWU7cI5HbePKVHdmMw6Q9RnL4odwsk7keaOXE1tspGbmTjF+YVFfrsjlCz+8Pk
 c6LKkZNxB5SmFLtBapr7yXQckqoFa5ZTM5Ot72QtiDtCW3tiyH5ohmtPxlTlupzyYoxAsvM
 0njQaJNBq+N6Kmwm2u2RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhW8nqZCixw=:FEDmad82yIffa62QsVqnWE
 uz1Wrim1T8l4l2nNLg7tI/QVN0sQNBVXDYm/NnsKLv7zs8LehTf6t5+qBRKo/0rh35CYACfnh
 HyaRp8O9EjgYHn8q5sfTDpNC1EA1qlL2VgJV7uFhKZ42rkCb/kvXDCLTj6e4eLqMiLLHwkYgA
 tg/kcev5qJ7IM9ob7D3yzCAq8ni94r1+4puI+m2IXISBpGYQAycFdcpnkAdl25Fp/ndfEZBg4
 YXNQwxFdDSigpL4BqDznMEklcUn0WDgyBJuTIe9s/D6zDgeIZoI7nU3riAsN/dWuWcnbkNnyz
 IId+DwROqDXieCnpGuBiZvOiLBS+urH6rgeCYekmDL8q7krWCyjHp4rvWFx7xcHD1o2VXsGot
 1a/8zGhBF+fqq58MrSp3TEn+6DOva3zIrSvk4tNapXtZZZprR8T75kOgPOvix1rgRrHk4ck8Q
 XG9VJB2f13nJVdtAIWsqENy/zAmWNP8RmLku761b6Sj8zHabwSrP59tSyG90YiRFFrAcrZcBy
 KgsrDJFq33B6rFnPLS6k8KrAwUkLaKXZp2tEwUEl7UxeFy3EamT5ORoeoTGvhxuO3ffTTWGuB
 YHr09kc6nvgYBKaTNvTlODeNk5KwBw66kFtJmW65s3rJj0voBCtwT73q7zm1gdOPRYk7r4ur3
 pOK6QqhYKoWR7gOjVF2r0tazZFTLqGupgU0ddYnvBi9U45R/Ja3Ea+uhLN5Vzw87BFZJr0JNI
 ctK94+FmLls+QETWW952oM3gGqZ4wEKj7crFiQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082025_542747_D511F4DD 
X-CRM114-Status: UNSURE (   8.31  )
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
