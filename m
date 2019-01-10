Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54325C43614
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09996214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJ9bYtlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09996214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ev+5Yri8SoSr0QkELrrX1eTfgdpo+0/5Ja+C++AZwYk=; b=LJ9bYtlPzoforN
	UfGY1M6QXb5am/+Pn+p2qD/PYkxzpFsqwKNtTTtvQAPW2PvJQfXvcMtZd40XWku/yFkyNmS6s5vlW
	zA1XbYTPRLmApLiruoaN42Y+2Eho3ELAQVpuhENOk9mPvEMXo3l4k+e+fZKkuPxgh3CDDvQssKNQy
	h/Q+Gv/z68bL5sgS+R5hYcEPpD3NuwPQ3E52nJMaazdm8aL0S5cc9SJtGKGgIVXBXcTu5yYKz/r3C
	LyzfqF70mP11b1IRdNAZt0rqIIIzC7EnuDVD7APDYx9CufuxkdevH0o09pDPZEo0gHIvUXWfxha6D
	AXGm1D7rxqrKdm4NF4gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdBb-00064M-Lm; Thu, 10 Jan 2019 16:28:03 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9r-0004IM-88
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:18 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlf8e-1h7aDx3tBq-00ik97; Thu, 10 Jan 2019 17:25:16 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] m68k: assign syscall number for seccomp
Date: Thu, 10 Jan 2019 17:24:28 +0100
Message-Id: <20190110162435.309262-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:cAxqL4Pr32LfUICErQXLweOdeKXEeQmVpfR3EH9HEknl3Rx7o7E
 3gUWhnJXo/Ubf1H9GjN7gL/hmeHLUh13G8skhoZVYIlxTGcXEAJWfHMK5fqwDp3C4mE6U0X
 qU5L8eRnhl276oNgVKUTHhKQsmD41xIQYhIiHkfU/+doRmo4DFVRig7b6U0yHHq8by33NdZ
 hcAmBJVorlGuA9B3ZJvMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDCus6IHYZs=:59ePj81cYO3U2E3eiWHh1M
 sBYu+VjNywqUwFg/ihKW68e09BYM+B9wyJRztaakMTQXqRhqdEmvZ1ojdiFn0PboHSl1sg6Jz
 lktVPIRNjSHV++3RcDapX5ekI8ig/J0IvxH1f4+g6djzOk81uQeI5fVOD5R8OO0yszdfBId8u
 bb2KyOJqmuC0e+cXrMswmdkk/j+BBIteI5Mmb3mP+1uYhOF+TfOtsnOry98sXfwt5ZUPA9G11
 6Bq2Pyf8idFvfkqnomphG6qXjz59WU2R1Q9Rx7kZwVitLUrtIW2RRr7yq1n7ODZWZGQ2z8AoO
 z24C7F3FN6OHu0pcfqceGVVVuzVusmsWJwQG+I6qPtgtEzJ98nxKoDWen8bapo4VdUefswZ8o
 6W9+k1MDORiZpzr2jtSy9Ndat8iO6D+3zwTqbLUBoNqQtCgrmkHlAGhalt1LHHGyNhOW148bV
 PpMR+nZk7cIlmB54DRwSnuFmOUO6LDwN1o+g/il93UIM6NlbxyI/DWUKjWVYBGVdQ3s6Ic1Zf
 0vSKAXuuihlQy5+pZqwaU8DXbOPv4HafkS3SIDPs2yD4d38mWQptPnqKD/bHDpvp4VJ5b/kNU
 aQ+nkmqzQ/IA01YkCZdy/qpBVvRyBS9YoP7Bz5rdcT7rE/Pq4hpkFgqLOPRpxbuJBNTSr2VaF
 icl78Ty7oQCbEHsFAET4OGF8IzhdbEX4J989KHwG97wdV3IRjqDo/uOxwU7z25q/vFvVzTku/
 IOt8wsJUD0b10sFcR6in2Nc/TFY9E3NMoaCyBQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082615_831057_7A919B55 
X-CRM114-Status: UNSURE (   9.77  )
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

Most architectures have assigned a numbers for the seccomp syscall
even when they do not implement it.

m68k is an exception here, so for consistency lets add the number.
Unless CONFIG_SECCOMP is implemented, the system call just
returns -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 1a95c4a1bc0d..85779d6ef935 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -387,3 +387,4 @@
 377	common	preadv2				sys_preadv2
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
+380	common	seccomp				sys_seccomp
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
