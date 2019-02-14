Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1739C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:57:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560E8222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YriQm5S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560E8222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hm2wVVwB11Be8IfYE1+E8UEbj/vKE2b5Zuy3erQxqyk=; b=YriQm5S0MjFmfB
	b9fQoSPqLacPUo0RTxMjfo+BZpXwpsfoLtGskchsVURHSPuWXyZMtcz2+3CHyqkkQY4yo/5n2Pl5R
	p+Y12gXJIwz5ap4GDQ1YuEBOTCRphqHzkJOs+8Zvr3XlUkG7Rj51nXD5J2cjusVuHIBnA5JNvNhaX
	xbx7HgCQZOvT9fqXVFuzeKV+PpYSO8xVeaWGMY/IkIjeQ9PlcY7OpzjkvOim4XQng9lnN1TLPkcfe
	oJXvOUMgyuCGX5wN4lSDqOIXyR9EWLKWhtJjMIqnJ5UUMktmfA0PpwyI3RB8Rxcwmgqd11/U/NS9P
	cOfTh1iP3BnOt8IyrzlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJNs-00010Y-5T; Thu, 14 Feb 2019 15:57:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJMH-0007ZM-6z
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:55:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E00EBD;
 Thu, 14 Feb 2019 07:55:28 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3DE33F575;
 Thu, 14 Feb 2019 07:55:26 -0800 (PST)
Date: Thu, 14 Feb 2019 15:55:22 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190214155522.GA1825@fuggles.cambridge.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
 <154998628802.21869.4041705065539411318.stgit@devbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154998628802.21869.4041705065539411318.stgit@devbox>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075529_525510_8B763B5E 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Masami,

On Wed, Feb 13, 2019 at 12:44:48AM +0900, Masami Hiramatsu wrote:
> Use arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that we can see the full
> blacklisted symbols under the debugfs.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   Changes in v3
>    - Do not populate blacklist in __kprobe_text in
>      arch_populate_kprobe_blacklist(), since it is already
>      populated in populate_kprobe_blacklist().
>    - Add exception entry text blacklist since those are rejected
>      by in_exception_text().
> ---
>  arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 194262fca5cd..37d913f33a89 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>  	return DBG_HOOK_HANDLED;
>  }
>  
> -bool arch_within_kprobe_blacklist(unsigned long addr)

I think it would be useful to add a comment here so that we remember
why this code is the way it is:

/*
 * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
 * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
 */

With that, you can have my ack for the series:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin -- can you pick these up with that comment added, please?

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
