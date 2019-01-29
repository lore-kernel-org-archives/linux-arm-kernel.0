Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB5C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:17:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31A52147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VAwLJEJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DwLR3pf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31A52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jgnZUQ/aqeHooAci2Df1jDzdNXj/Gqx2kITHBOkOU9o=; b=VAwLJEJ7M9Dkgr
	ZbaZJwzmpcwkzy9xcTEoHCNLeImz9uquhwcbusp3z599xBJ7fY+eMRPuqsCHgJ0a04MlvoJjjeNCI
	2Bgs9W6uy4NgOoQy6g9xzHVRosimMzZhIR6xluuOf7hMrtH6NjgtyFZxBbbGd8r7UR7Lnh26YArg6
	hyPVEYLWJambi4FE8RyRzU+RYqEgGYdyWIRiUKQb/7sO14XhLMk3oqJ5OIUORTYWOPZOSCUdKu8A0
	Vtq7HZDWAaWqz4G6ebt6QLARkm94bgFIiWUB5/CEbXJfg2DgV4PayERICt7e5kguVNAwF7OGUuQC9
	dqHGbXuPVwaIziYe7+qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUCI-0000f4-Lg; Tue, 29 Jan 2019 14:17:06 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUCE-0007Hx-L6
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:To:From:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yLnBy40uij/Qf7F7qT3FbXzzfY4X8DV6pjFPvMoD9fY=; b=DwLR3pf+dew/XZU6yA7XgBxUqb
 nf/6wxZSgzrQ0RJjItGo1uhtxWf6NOrJS9RNYIpFnPuL7WX/V2G6mTDEZQcR/A9GocpRyDM8UNqrM
 eKgx2LY41YgciSeQ1dqiX5Q+F5ZiRzQ5115KxF/4FubrC7Y12ADNHmLPmYAE8aBJk6zo=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:35422 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1goUAA-0000Cv-GD; Tue, 29 Jan 2019 14:14:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1goUA9-0003OK-TE; Tue, 29 Jan 2019 14:14:53 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: add "8<--- cut here ---" to kernel dumps
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1goUA9-0003OK-TE@rmk-PC.armlinux.org.uk>
Date: Tue, 29 Jan 2019 14:14:53 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_061702_703616_F7691201 
X-CRM114-Status: UNSURE (   9.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a "8<--- cut here ---" marker to kernel dumps to help users cut
the dump at the right place when emailing list, rather than cutting
off the first line which gives the reason for the dump.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/traps.c | 1 +
 arch/arm/mm/fault.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 2f15d3f3ecdc..e3a0c7bdd150 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -729,6 +729,7 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_BADABORT) {
+		pr_err("8<--- cut here ---\n");
 		pr_err("[%d] %s: bad data abort: code %d instr 0x%08lx\n",
 		       task_pid_nr(current), current->comm, code, instr);
 		dump_instr(KERN_ERR, regs);
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 58f69fa07df9..743a9e0a1fda 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -142,6 +142,7 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
 	bust_spinlocks(1);
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
 		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
 		 "paging request", addr);
@@ -167,6 +168,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
+		pr_err("8<--- cut here ---\n");
 		printk(KERN_DEBUG "%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
 		       tsk->comm, sig, addr, fsr);
 		show_pte(tsk->mm, addr);
@@ -556,6 +558,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
+	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
 	show_pte(current->mm, addr);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
