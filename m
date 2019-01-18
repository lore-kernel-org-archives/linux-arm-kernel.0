Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A088C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C17C20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJypnIww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C17C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=227dyKzKAFz3k8Ksa41aeauuOfAcOtx0hFEhge594Zs=; b=EJypnIwwEde4xw
	fo2cc+eIgMq2GlMh1i6LfQW1tuBPorDNKtoMbQXflwCpo2CVbhuHxAw1AtHO/RClogX+RZsFa7+Au
	8iCH9KWTdnN5g9l41VSiJQ4zyMktakanwyuln4XmENpS8MVyCcizjcib+rozb7B9Z91gtEcWcqTOU
	LZyIjKcIY8vvL08p2iV/YuuLP0tzhKuf75aX6W+jI/e+vre8QfaY/TK9lAFFT6VCTfdmwbE43ia1q
	+PlfbFLJvWYwb9Lk+PidzQPkigyr2oTO7eJAPiV9WEp1WnffmaFNnMjkNWEwAg3Glrswz2bZRcLw8
	nYo9dXR3L/E8+s0NOq+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWtm-0002V6-GG; Fri, 18 Jan 2019 16:21:38 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsc-0001Mz-D7
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:28 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9d7-1h6a9s2Fm7-00wCau; Fri, 18 Jan 2019 17:19:19 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 03/29] ia64: assign syscall numbers for perf and seccomp
Date: Fri, 18 Jan 2019 17:18:09 +0100
Message-Id: <20190118161835.2259170-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:2+79bnr8ZMppmGxfaffVCG2dp2/wwc6gEdzbYANW5JYZND/0OwS
 MAt33/0YNXlbqd4mO5SoIU4aXs5yE3a789oiPqsjKE3w1+eLlrkfY674jum0juRLN7MOuaL
 i0PBboitySA9E6k0frFnstFkZCm1ySbhyQqt95A4tdxW+Hr/ScPMoiVcmlREtKxzMCkToGj
 Md1rhYzZ2FzECNJvkjCmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipIgTsan9yc=:0MeISoJzpLGvk/kWrCIBlv
 S+Yw/qQPnhjymS19cJ/UIUWkohjKJyNd8hwSs5uQStf5qGBeQGt4lidllvnuoi2JQUe1aaNAu
 wAUx4uxnjlHNMprhMTX8qQu2QtxYfjuHBG/4kpgbsZo+toZ0ty7UAaD50PDiySl0LcdI7QbR3
 r52Qm/078mebTyywwL/QBoniWGO1Z2t1jDfOovAQnxNofzf2V/kEReO2RkVGFmTdizU8RrAFt
 KQzu2z/2pU1b/90ZpGBykBm14Sul0qRK3gdWRdSQsNfxtgqDixdwEwgZC8KN0JLJiqiyRbNcK
 btfjx3QOj1GgQiTw+nLdhduXDaOxDNN8LOhDH+CbNlqqa4GBRg3EUSD2AT7Vk1xoZWZjpX9dI
 vrnMSvJKOh0qBopear2NsMeNciro1+A2M067Lf+D51UMrp5aFr39y0RnVSAeTLUR7O5hc9IHt
 nlHo6D/XmhGtdnXx1s9tHkTONpiNJyd0WhXsABDf5GmlPZQW0TT2n5Q4jhHT2tX5zAXqROdyK
 PQfa5ZtBKGQKVQpwQkf2IMyMvKpvSVugsw+At8Qm6XRs0QZo+4yJ1dpzEyEhGMTqEfVjWu+zg
 8N6buvae3MJrPiQ46uDjQr9ykQkEREpv6gdpV9J+Syg41c/SFkqsqNVbzDU01S0/c2FEtaPH7
 3VbtQ55muhFQhJjw6VnbM1w8SqUKPBYMbF+3e3HcXW4JIGzx3sUorsx4D/f+kUH16UkUFZlrY
 ruE6J/9I90uB5Q+0TZ3djyNQLumSrHOHI2enUQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082026_748446_0A903250 
X-CRM114-Status: UNSURE (   8.99  )
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
