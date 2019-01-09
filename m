Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19349C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:05:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF6E206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nq0M0Oua";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2AigcZnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF6E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FSBH7KnqGv9+P51xLFNGO4TQMUrQhJOR9SIwP96T3Zo=; b=nq0M0Oua0yB9x4
	cnr1AJxJ1SrIIULTEqPwY09FeeV0+j8mflvfbf4TOrj6MDf75iK7fbhcNqi9RgLzt+5bObzHtdE5c
	sZkK8aTrx/B1Muvz5465DNY4RiFIxtftrIc3GTimu8KuZxyO6chCqonlGCN0GAr0P3l3cDh5yYi2/
	hsNncoPOt07lNB/1sflYqQ4QTQ7QmlPNwh0YCr3UbBAZkb6LC5QSYw0/HMkfb/h8wEI2CdH6aoTVq
	9miZzY1PmqATsCDEuIAxOljd3KW233jV3WeRrg+vZ7+LOQAUccbaKTm8Et7uM+Zn1eX33aDL5sy8c
	7DlF0TZKRzKBnIGwQDVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh3F1-0006Uz-3q; Wed, 09 Jan 2019 02:05:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh3Ex-00069z-HB
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 02:05:09 +0000
Received: from devnote (p103030-mobac01.tokyo.ocn.ne.jp [153.233.94.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21085206BB;
 Wed,  9 Jan 2019 02:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546999506;
 bh=Ickqk2IZkIG8p04SgQek3hIsU1ZxkvWNSEhuLaJp8Mw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=2AigcZnMw1WQlONJhKEoRIJcREnBHjp7eqluXdmyCKIr5U8I9VVFR0H+7GAI1ciyO
 ciZqVwHQOi0ZHkjJ5/tblVIwzgGKd4/ZIRQ3rFcBsXeJgO9KBL2XUdsEDRFA4lfVZM
 keNRAWE9I4zF9m49i5lO0uXSP3vB0vU1wVbZZVWA=
Date: Wed, 9 Jan 2019 11:05:00 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Message-Id: <20190109110500.b4b5049f4c67dfc85b9ced4e@kernel.org>
In-Reply-To: <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
 <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
 <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
 <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_180507_608466_74C15339 
X-CRM114-Status: GOOD (  21.99  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

On Tue, 8 Jan 2019 17:13:36 +0000
James Morse <james.morse@arm.com> wrote:

> Hi!
> 
> On 08/01/2019 02:39, Masami Hiramatsu wrote:
> > On Thu, 3 Jan 2019 17:05:18 +0000
> > James Morse <james.morse@arm.com> wrote:
> >> On 17/12/2018 06:40, Masami Hiramatsu wrote:
> >>> Move extable address check into arch_prepare_kprobe() from
> >>> arch_within_kprobe_blacklist().
> >>
> >> I'm trying to work out the pattern for what should go in the blacklist, and what
> >> should be rejected by the arch code.
> >>
> >> It seems address-ranges should be blacklisted as the contents don't matter.
> >> easy-example: the idmap text.
> > 
> > Yes, more precisely, the code smaller than a function (symbol), it must be
> > rejected by arch_prepare_kprobe(), since blacklist is poplated based on
> > kallsyms.
> 
> Ah, okay, so the pattern is the blacklist should only be for whole symbols,
> (which explains why its usually based on sections).

Correct. Actually, the blacklist is generated based on the symbol info
from symbol address.

> I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
> platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
> start_addr and platform_drv_probe+0x50+0xb0 as the end.

Yes, it expects given address is the entry of a symbol.

> 
> But how does anything from the arch code's blacklist get into the
> kprobe_blacklist list?

It should be done via arch_populate_kprobe_blacklist().

> 
> We don't have an arch_populate_kprobe_blacklist(), so rely on
> within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
> address, as well as walking kprobe_blacklist.
> 
> Is this cleanup ahead of a series that does away with
> arch_within_kprobe_blacklist() so that debugfs list is always complete?

Right, after this cleanup, I will send arch_populate_kprobe_blacklist()
patch for arm64 and others. My plan is to move all arch_within_kprobe_blacklist()
to arch_populate_kprobe_blacklist() so that user can get more precise blacklist
via debugfs.


> > As I pointed, the exception_table contains some range of code which inside
> > functions, must be smaller than function.
> > Since those instructions are expected to cause exception (that is main reason
> > why it can not be probed on arm64), I thought such situation was similar to
> > the limitation of instruction.
> > 
> > So I think below will be better.
> > ----
> > Please do not blacklisting instructions on exception_table,
> > since those are smaller than one function.
> > ----
> 
> I keep tripping over this because the exception_table lists addresses that are
> allowed to fault. Nothing looks at the instruction, and we happily kprobe the
> same instruction elsewhere.

Thanks!

> 
> (based on my assumptions about where you are going next!,), How about:
> | The blacklist is exposed via debugfs as a list of symbols. extable entries are
> | smaller, so must be filtered out by arch_prepare_kprobe().

This looks much better for me too :)
Should I resend with the description?

Thank you!

> 
> (only we currently have more than one blacklist...)
> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
