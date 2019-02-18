Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37F02070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oyFLBZo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37F02070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IXT/wu4JmiQ3uAt9SfIOp4nEpPssExtmzFUxB10hTkQ=; b=oyFLBZo42r+2+B
	04+yqAtvCYpdRh5+OvOiNrR8LANFwvMNIk9GAYOZa+raNdUG6a6GO7DUOXleyCdTyCa5aRMBPM59v
	Pqsm6rLSS1X0+xgKWLSs09MQtunjc2sN1mIF3YnfdzSVTgfj2BJLhHaS0cRdbBTJyjN+Kalx/MJsL
	Oy/zACslCtOA8IDBAZHENEs3KvLnrHdRE+CL5rRKGpJY4wCTaxJiSVl0ZZU0g3AFNNEl43gxmueL+
	KI/aYlA0Tit3kiuQyNZf87jdA6NtREM7Ufq3rmHfbxJEHLW971VQMI2v8uPdpQnzkbmpb3+xxQirz
	tGwW4EgmbE9aO5jt1RXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqAD-00071i-A5; Mon, 18 Feb 2019 21:09:21 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq8m-0005Oe-KQ; Mon, 18 Feb 2019 21:07:55 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mbj7g-1hTVem3oWU-00dE5E; Mon, 18 Feb 2019 22:07:23 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 0/8] y2038: remove time32 ABI on rv32 and csky
Date: Mon, 18 Feb 2019 22:07:04 +0100
Message-Id: <20190218210712.3503891-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:bewU9ZGmWDBtcDorCLKIF2OaAK8VSnBIubbe5DS6pS/6b8qt/SS
 f6LXyp4kr6e6Z3kldb3eHoHSBObighrIEpHcdRLjtlUPPrk5QaLjeSKlsAalGwaRwzXX4i9
 I83r7JDkzhbY1oGOcJJFrP/4x2NukuhHqN2o+gloMkAatap4+DzKebOdWAJ22I/7kBwNYRi
 1mAoh4l7XSz+NHzV2I+ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:++/WGXsV8HA=:0G8jutlWE0HQkQ4WJ8Mb7c
 KiLTRFlvlB8D5fy2LLKwEBvdniXHVLQV/K02hHS0WqbLmncvVe9AO/1/nOwnpTNMPA1W/Uho8
 IcoZGgfbRm0vGPpPsIfypOitumOArxmY/Vs6CNuM7akXOgVqwFd2ineAvikWOCzEobBxGakGd
 7AleQ8CwfhvspfbAQbk2LS0SaSJkHRQVHJEOCyuP/wlz5budE5RuA1gdrdFB/wzqs2Y2ikqg2
 wQifJ1JpoGpCzNexZvBEw61IhCOd7J5zv6OVwCQOHHGuDwTQ3HQfTyI011wozNiwu2SIBqOkn
 E1cI2rmf6MdhLdAkPtUhYwUWPs8TZY43ERGOWO8FjeCk33FQZXbWNjOdbO67u/5iZI5RVH59+
 GUZqpSIRTFMwS1BewtQz/J0DOeQ/6VeHxTeSTgiptXAbdcY0/bpNLgf8e68qhrnov48b2VUJm
 BMHkXb/DJXGgoWJNGbmCVG/chPZI0HvUvUXY6tAWGK0r+Cx3OZCBJwm068oRCLs0b/cJSa/LS
 JQemRph4DrHk//s+R+YfjRnXaelFSEW6uTnjgbm4L1fVOhoqDV3sdL3bPwM6zsaCmJY1UEGH1
 ROzslqjkbtkvJagvVWMVIEkWjTQ9H+ENnSfylSAz2AIYZX1JlVEguoT7+yom8s95pckxI1BUE
 +SfLFDshAmo1Iz+rTA+QYorObhMRmETUNiseYSOOx8yjZfOUfYG83cQQ08crrIoNv6o3uKdWE
 YTKfcKNTEPtOrDWOeBedIyB8a+3LOR22Eh10vg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130752_968773_E6B34006 
X-CRM114-Status: GOOD (  10.48  )
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

This is a follow-up to the y2038 syscall patches that Thomas already
merged. Both the csky and riscv maintainers have requested that the
time_t syscall ABI should be completely converted before an official
glibc port is merged.

The series achieves this in a few steps:

- A couple of bug fixes for minor regressions I introduced
  in the original series

- A couple of older patches from Yury Norov that I had never
  merged in the past, these fix up the openat/open_by_handle_at
  and getrlimit/setrlimit syscalls to disallow the old versions
  of off_t and rlimit.

- Hiding the deprecated system calls behind an #ifdef in
  include/uapi/asm-generic/unistd.h

- Changing the two architectures to use the new style
  syscall ABI for all three types: loff_t, rusage, and
  time_t.

Arnd Bergmann (5):
  asm-generic: Make time32 syscall numbers optional
  unicore32: Fix __ARCH_WANT_STAT64 definition
  checksyscalls: fix up mq_timedreceive and stat exceptions
  csky: Use latest system call ABI
  riscv: Use latest system call ABI

Yury Norov (3):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
  asm-generic: Drop getrlimit and setrlimit syscalls from default list

 arch/Kconfig                             | 15 ++++++++
 arch/arc/Kconfig                         |  1 +
 arch/arc/include/uapi/asm/unistd.h       |  2 ++
 arch/arm/Kconfig                         |  1 +
 arch/arm64/include/uapi/asm/unistd.h     |  2 ++
 arch/c6x/Kconfig                         |  1 +
 arch/c6x/include/uapi/asm/unistd.h       |  2 ++
 arch/h8300/Kconfig                       |  1 +
 arch/h8300/include/uapi/asm/unistd.h     |  2 ++
 arch/hexagon/Kconfig                     |  1 +
 arch/hexagon/include/uapi/asm/unistd.h   |  2 ++
 arch/m68k/Kconfig                        |  1 +
 arch/microblaze/Kconfig                  |  1 +
 arch/mips/Kconfig                        |  1 +
 arch/nds32/Kconfig                       |  1 +
 arch/nds32/include/uapi/asm/unistd.h     |  2 ++
 arch/nios2/Kconfig                       |  1 +
 arch/nios2/include/uapi/asm/unistd.h     |  2 ++
 arch/openrisc/Kconfig                    |  1 +
 arch/openrisc/include/uapi/asm/unistd.h  |  2 ++
 arch/parisc/Kconfig                      |  1 +
 arch/powerpc/Kconfig                     |  1 +
 arch/riscv/include/uapi/asm/unistd.h     |  1 +
 arch/riscv/kernel/vdso/Makefile          |  2 ++
 arch/sh/Kconfig                          |  1 +
 arch/sparc/Kconfig                       |  1 +
 arch/unicore32/Kconfig                   |  1 +
 arch/unicore32/include/uapi/asm/unistd.h |  4 ++-
 arch/x86/Kconfig                         |  1 +
 arch/x86/um/Kconfig                      |  1 +
 arch/xtensa/Kconfig                      |  1 +
 include/linux/fcntl.h                    |  2 +-
 include/uapi/asm-generic/unistd.h        | 46 ++++++++++++++++++++++--
 scripts/checksyscalls.sh                 | 15 ++++++--
 34 files changed, 112 insertions(+), 8 deletions(-)

-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
