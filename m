Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:50:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D873021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MHADm/om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D873021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nfID7mofQ+4FZTFQbRyCvBFQEjNGtoYQPZkGUWsmrhU=; b=MHADm/omFYPitt
	h86nV3dc+0YedTube6XkFuEAropCaMLcNJ2uBiz1Ek62oHvVk1le4vgAaSHFhyPWORgfaiiHqcjs4
	l+0dOXVHUhCdScKI6TzhUzQADRf6CWEuydfipMATGqgfEzBlscCvZDFULnxVYtIs3RC6gLL/W/8vx
	PGh6co7ZBZg+k5HpYxtviGLYnpMJZwwWCOo3PwC6EqNnn0VLzJQMi3EaSfFEkd/3yWpiUhBgoOZEH
	FHepcO+JFrDbGCgizv5mj4834NTFnNILvmooG/D1ZBtWs9gejc7e/YMTb4hXnTrnDl3ijkXOyCjXb
	IIiYBAUeXEcQf9ghjOPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf1W7-00083w-9d; Thu, 03 Jan 2019 11:50:27 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf1W4-00082Z-5s
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 11:50:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DAFA78;
 Thu,  3 Jan 2019 03:50:20 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC5E3F5D4;
 Thu,  3 Jan 2019 03:50:19 -0800 (PST)
Date: Thu, 3 Jan 2019 11:50:12 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH] arm64: Mirror arm for small unimplemented compat syscalls
Message-ID: <20190103114959.GA3529@e103592.cambridge.arm.com>
References: <20190103074550.217421-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103074550.217421-1-pihsun@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_035024_227852_FEF2426E 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 "moderated list:ARM64 PORT AARCH64 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 03:45:47PM +0800, Pi-Hsun Shih wrote:
> For syscall number smaller than 0xf0000, arm calls sys_ni_syscall
> instead of arm_syscall in arch/arm/kernel/entry-common.S, which returns
> -ENOSYS instead of raising SIGILL. Mirror this behavior for compat
> syscalls in arm64.
> 
> Fixes: 532826f3712b607 ("arm64: Mirror arm for unimplemented compat
> syscalls")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  arch/arm64/kernel/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 8f3371415642ad..95fd8c7ec8a171 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -21,7 +21,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
>  {
>  #ifdef CONFIG_COMPAT
>  	long ret;
> -	if (is_compat_task()) {
> +	if (is_compat_task() && regs->regs[7] >= __ARM_NR_COMPAT_BASE) {

compat_arm_syscall() ignores all bits r7 except for bits [15:0].

So, doesn't this mean that 0xf0000, 0x100000, 0x110000 will all do the
same thing now?  (Previously to your patch, 0xe0000, 0xd0000 etc. would
also match in this code I've misunderstood something.)

The gating check in arch/arm/kernel/trapc.s:arm_syscall() is

	if ((no >> 16) != (__ARM_NR_BASE>> 16))

I would expect that arm64 needs a similar check somewhere.  Is the check
already present?  I may have missed it.


Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
