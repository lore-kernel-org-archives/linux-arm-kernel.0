Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C664C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35745208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0O97FFz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHY1ctvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35745208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dR+pyU+uSEu4a7jX6U/8/1BnFBeDKI6K1V2+SfIdR0c=; b=C0O97FFzZye5i3DMeqfLXa2PDb
	y3fFaKl1sfFA3B6yeNwelVdcoHPProgunZ0cR8fe9sasysGZRFtLGdMXNixIt/rzuA8htNxYVBQPH
	7/fom6BRH6cqADiqm13D7kTohmisnI4V9CV0d3Jjit4Tr79I/1IrjHHjb2KbiFMlQCGbvyDRjkUeY
	b5jVA1O1oeFlh2yZbU1VsYUtW5gXQ/jfP+V7TKBoJk8BmWIpA+YHBta75kiq5YNsA9LxRomvhu8BZ
	AHay0FRpUV7hr0hEk5ztUhA26s3SWoyjd5XhbS91LmTuwXaB0mD3578t6IHK/erUHUfsPoGREQgg+
	Nw3wRpdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf57R-00079P-Kx; Thu, 03 Jan 2019 15:41:13 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf57K-00071P-23
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:41:11 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so16846956pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0bH3X0J6XzJKEHd3IWPV5Bt2LeIi1ts8ZcW3nL9dsFI=;
 b=fHY1ctvuiaGSd8UW+EECMkQmbER0XrC799xUDx4r4OArQJImxYlGI9hDLmCzAqcAFc
 LCOgU5W5YQiIkwIBK8+0w/UJ9s7nPqmOODHa0pMp39VsATUXItaR43pRotTLlijWPnQF
 CiK+bNB4/zPIZspcj4QJo8YJZrHHwqj+Mg9zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0bH3X0J6XzJKEHd3IWPV5Bt2LeIi1ts8ZcW3nL9dsFI=;
 b=OoYhFSW5sGeVYR56LDji4xW1+VHiWiBtRO6rIXTiBFk9GmFrcVCFpEbEA2B17MhM4C
 sNFHIMdl6CM+PZPHylf/zskazkIQdLiPskAGH51iKfNZ9ftDUL6quo9SArXVkgCliuln
 qKJNKTPtzc3EBZRDBD1UKnpPacCgy/owxD/xGERkNyf/cfof5Ff+Z5BHXRIIijS7sCxm
 3bX9e67r5w5rG1AeLlEfDWD0RrRkJ6sL0eMLGITXpnbigTkSgLDXRJbb4fXawu9XtNYj
 2V3eyfiie6KbJdZglj+Sas8nOORFmK4g3RIUefyuYvTOt413+BQlXiOIn4QZ3ir9Ffbs
 /4oA==
X-Gm-Message-State: AJcUukdws+HS5AZq0JJMvmL0Xy0I4jOy78cuNbcPYadNj0qizEABLuS4
 V6ZFBTx7yirq0y56IRtbl4Fr9w==
X-Google-Smtp-Source: ALg8bN7TGjF5k7se8IrL0D1lm3m9KJ6ADM3765US/WhW31HsMMC0waCMwZrCAMkfmNeLeKfEnNhahw==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr17289837pgc.89.1546530065375; 
 Thu, 03 Jan 2019 07:41:05 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id w10sm66155494pgi.81.2019.01.03.07.41.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 03 Jan 2019 07:41:04 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 2/3] arm64: assign __NR_*_Linux_syscalls generated by the
 scripts
Date: Thu,  3 Jan 2019 21:10:24 +0530
Message-Id: <1546530025-26014-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_074106_634529_B4BE1833 
X-CRM114-Status: GOOD (  15.37  )
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Assign the generated values - __NR_C32_Linux_syscalls and
__NR_64_Linux_syscalls instead of __NR_compat_syscalls and
__NR_syscalls respectively. It is better than hard coding
it.

One of the patch in the patch series will generate the
headers and calculate the total number of syscalls that
can be assigned. Otherwise the hard coded values need to
be changed whenever we either add a new system call or
delete a existing system call.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/arm64/include/asm/unistd.h | 10 ++++++----
 arch/arm64/kernel/sys.c         |  4 ++--
 arch/arm64/kernel/sys32.c       |  4 ++--
 arch/arm64/kernel/syscall.c     |  4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index b13ca091..fca2186 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,6 +13,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#include <asm/unistd_nr_64.h>
+#include <asm/unistd_nr_c32.h>
+
 #ifdef CONFIG_COMPAT
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
@@ -42,14 +46,12 @@
 #define __ARM_NR_COMPAT_BASE		0x0f0000
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
-
-#define __NR_compat_syscalls		399
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
 
 #ifndef __COMPAT_SYSCALL_NR
 #include <uapi/asm/unistd.h>
 #endif
-
-#define NR_syscalls (__NR_syscalls)
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index b44065f..f4ee0f5 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -62,7 +62,7 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
 
-const syscall_fn_t sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
+const syscall_fn_t sys_call_table[__NR_64_Linux_syscalls] = {
+	[0 ... __NR_64_Linux_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 0f8bcb7..772eaf2 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -143,7 +143,7 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
 
-const syscall_fn_t compat_sys_call_table[__NR_compat_syscalls] = {
-	[0 ... __NR_compat_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
+const syscall_fn_t compat_sys_call_table[__NR_C32_Linux_syscalls] = {
+	[0 ... __NR_C32_Linux_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
 #include <asm/unistd32.h>
 };
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 032d223..4e50b1a 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -127,13 +127,13 @@ static inline void sve_user_discard(void)
 asmlinkage void el0_svc_handler(struct pt_regs *regs)
 {
 	sve_user_discard();
-	el0_svc_common(regs, regs->regs[8], __NR_syscalls, sys_call_table);
+	el0_svc_common(regs, regs->regs[8], __NR_64_Linux_syscalls, sys_call_table);
 }
 
 #ifdef CONFIG_COMPAT
 asmlinkage void el0_svc_compat_handler(struct pt_regs *regs)
 {
-	el0_svc_common(regs, regs->regs[7], __NR_compat_syscalls,
+	el0_svc_common(regs, regs->regs[7], __NR_C32_Linux_syscalls,
 		       compat_sys_call_table);
 }
 #endif
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
