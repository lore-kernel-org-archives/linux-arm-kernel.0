Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C63520883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R/IBq0Ya";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yS8HAK/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C63520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9oldES7E2XSGRYVWgFKisS/651erJ5jtY8HHA4r8qUo=; b=R/IBq0Ya50UxNK
	ZuNQl8duoJYs8BsC3Cpj4u++9FHykUHXiG2nFxETBG4IJfikXunFuAyE7pgw1x4o3aG2udhafmop9
	g60liIIPTmvXmEC3YtelBrjdqkG9HBcZTHlQrkfcX/cXR2qtSDMemE/kghFW1AQqNrXZHESeJe0Yd
	DbB8I7h2wGbVs3uJNyHtVDJeivjbGRFTiUKqAy/JATOvIWMSN1vqKIFKOxVMl23Z7v7QXYgsGosdp
	5wNWREhr++8xvWmtIXYOmncTCAyxwe8MxS/afOH5Xpe6XIej3ltriHxCj+qX4u4AmFXf8N9ttJ49H
	IKPLIa9u+438Z/UBrIJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWyZ-0007yK-M7; Fri, 18 Jan 2019 16:26:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWtJ-00022L-9S
 for linux-arm-kernel@bombadil.infradead.org; Fri, 18 Jan 2019 16:21:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=USmc2pWczD++hhFr58wbCbZZIz2EUM2eyj2AGpYSRCM=; b=yS8HAK/oWFKI7En8DOHyNoMgal
 +bLbcRcI2ii98EMATFyYWKE8Q47rED00dlDocPsRdh4yNYGa5NdqBZIFzhua4NW875WdFgGc0OxkW
 IMkvrZqlFw65aVGHBYFE0Dt/RnejmWSsr5Xp2SfCjboIzc9CrRPazc739Dwvt1TtLdFHK7KaRNR0b
 aRS5SOXqlOSDP6mkRvCyWoRSKn2FbXhXPKoRvZzDRMHVvm018iT+flMTtIwQkeDU88JDay90vQESt
 I6IX26cxIPHHD9o2pTU/GK5JGYfxFuF9qJTDWyKzYHljLbFBu4YXM3hz8dJAhQfdIzGUvgbnOWuNk
 qVmS4J5Q==;
Received: from mout.kundenserver.de ([212.227.17.24])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWtF-0004BL-Uu
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:21:07 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgek6-1hRG4c1P9I-00h8xD; Fri, 18 Jan 2019 17:19:22 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 05/29] alpha: update syscall macro definitions
Date: Fri, 18 Jan 2019 17:18:11 +0100
Message-Id: <20190118161835.2259170-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:IpgN/6x+9YH/ZpCIWY3gRrzUVcyfh4VSAjoJYgiS81Mqfx29mGc
 tms7FOV7IARrkPsfsZf9kthkrdSPhcU5Fk+5diaWJlZCnlKoqrcwQ86I0j+wmrBl558MOJP
 W0E7G8LXcyYeqCWEzJ3PmhdsIUaSud+lGO6LI3qmNkMGAFOLvqYAhqIAfIjooAUgxtqYgGq
 Y0vbQZeedS4Hsd6uRlDsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J1Y3L6SJOuo=:VItzOi0LywpnZmdssIsomL
 T2mnwdZYNpu57GUfSTWNptIZxnNK/YWq19yEt/TrIv1Ufo/7Qhmg87+EMdNkzUG7sHHWU6si4
 e6Uoc+Se5BpQ0e4+vrNpKWZ8KXDTxR84D6WVcgAb3FljBZbE9GyTnTRHNHrRIb0qu3SrTyBWu
 EA7cwltkjUvGb/5OSgUGQEpnPwg2MKZgT1hw25LxxHQFO7W6GgpjUd/ZCE9OnxJgtpTZHEWRD
 8Ty1u/5QO7fkXZQKTIGyqVcXlcNHnonCrkxxNAEiC0EF109yuPFIk/hWsjOAZxkxPD6LZw2CD
 LacdpafGZODtV4hOyeceUKO/V10j+2KpzQg7SGxpqOqxV/6KBQ/1ebDjShdMD2/1zA9VA8gnR
 N3+D48GZa+rXF4UAVWrRs5Rt9+PpmCYGyInuAvwrROOEEdR2PJPYnSDLsUhsLZ13dmR5Il8ot
 9SCWdA4V9RdZ/ugKRltpE+xu+QgrrbocjKgnYA9bbmTUxf2oisicIwxN8MzU2HacKf6qdspxx
 lVIZckAolEYlxaff02IrxkyRNj6qpE+arrYmPN8zYfkV6iworlPh/mQg0GIz6YRr+rQPq44gl
 Wy9i94kb7ciQMeR72WziFVdG66VUSma7hmvqDIgG5Jp9RiYwyOwP6s38kgL4HKDj6vkN4TLU2
 Mh33nR8OVfsKyv776jVob6d/0HDDLFmnbjNvLp2xLJ9V4XJbzDO0uzQrJtj/yaeDsUhY6cz7/
 cJ+KbS1MKRzIIHBL9w1MraFpaGTOU56HmRiQrw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_112106_247290_10CA5211 
X-CRM114-Status: GOOD (  12.59  )
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

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

For shmat, alpha uses the osf_shmat name, we can do the same thing
here, which means we don't have to add an entry in the __IGNORE
list now that shmat is mandatory everywhere

alarm, creat, pause, time, and utime are optional everywhere
these days, no need to list them here any more.

I considered also adding the regular versions of the get*id system
calls that have different names and calling conventions on alpha,
which would further help unify the syscall ABI, but for now
I decided against that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 6 ------
 arch/alpha/include/uapi/asm/unistd.h   | 5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 21b706a5b772..564ba87bdc38 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -22,18 +22,12 @@
 /*
  * Ignore legacy syscalls that we don't use.
  */
-#define __IGNORE_alarm
-#define __IGNORE_creat
 #define __IGNORE_getegid
 #define __IGNORE_geteuid
 #define __IGNORE_getgid
 #define __IGNORE_getpid
 #define __IGNORE_getppid
 #define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
 
 /* Alpha doesn't have protection keys. */
 #define __IGNORE_pkey_mprotect
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 9ba724f116f1..4507071f995f 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -2,6 +2,11 @@
 #ifndef _UAPI_ALPHA_UNISTD_H
 #define _UAPI_ALPHA_UNISTD_H
 
+/* These are traditionally the names linux-alpha uses for
+ * the two otherwise generic system calls */
+#define __NR_umount	__NR_umount2
+#define __NR_osf_shmat	__NR_shmat
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index e09558edae73..f920b65e8c49 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 19	common	lseek				sys_lseek
 20	common	getxpid				sys_getxpid
 21	common	osf_mount			sys_osf_mount
-22	common	umount				sys_umount
+22	common	umount2				sys_umount
 23	common	setuid				sys_setuid
 24	common	getxuid				sys_getxuid
 25	common	exec_with_loader		sys_ni_syscall
@@ -183,7 +183,7 @@
 206	common	semop				sys_semop
 207	common	osf_utsname			sys_osf_utsname
 208	common	lchown				sys_lchown
-209	common	osf_shmat			sys_shmat
+209	common	shmat				sys_shmat
 210	common	shmctl				sys_shmctl
 211	common	shmdt				sys_shmdt
 212	common	shmget				sys_shmget
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
