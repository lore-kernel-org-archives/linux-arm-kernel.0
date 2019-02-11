Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C56CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA4F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eo7oQXW6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcPlS8RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4F21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Ln+MfsZtyWfzj3npeJMbSpetO974TRYo+o1npi/kwk=; b=Eo7oQXW6lESn8T
	4P9M16eWeWHyCxerkCvZ9RCFnjEG0Z/CjkiV0zzRKNrLxzo4RKtUs6SXvpju5RokdboMIG7WSJg1L
	thgIGUuOd9tb702N6rpbaxZjNsIgP0cScrFb0YvvPVTilA7/p6f/4lZENfxE8LvElQIFNduV1G4w8
	jgd0mi0VUk+U2T2rhEOWkVPRooInYuoJNPvgU/Cd1yBkQPBimYsC56+1gS098ySfHfE4GRFoNyAZk
	KhEnb+DN+2PznswrSLdSsSIRlXCUmvp3wP8ibVYogJ9upt2KaCVL0y+4tVjepXqiNsY5Kqyri7JQ0
	BPcM9oQgJV47PjaXeUwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtBLy-0004FC-Si; Mon, 11 Feb 2019 13:10:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBLv-0004El-SO
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:10:29 +0000
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3D6A21855;
 Mon, 11 Feb 2019 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549890626;
 bh=Nz+i2f+o5dnIOkuHcsi+Pot0S53/Oyises7pRO4U6RU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gcPlS8RNhA2+aOWnsSveh2Ub/4F7lNA7dJ5vPK8Tpod6PcHLHJF+aq6guobl6kDSn
 tYdscE28fyWyFY09w+HpMoLYK9RBjSBu/mjU/39PVbDpobUuJqm9cjf9WeuI7uJ/ba
 Dm30XLX+3qrNdSTMczGIRUB18fMs8KYRf9dG2BFk=
Date: Mon, 11 Feb 2019 22:10:23 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190211221023.0bb43554647f99afce8dd060@kernel.org>
In-Reply-To: <20190208091519.GB6972@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
 <20190208091519.GB6972@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_051027_952188_540FFD8F 
X-CRM114-Status: GOOD (  21.88  )
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

On Fri, 8 Feb 2019 09:15:19 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Mon, Jan 21, 2019 at 10:25:58PM +0900, Masami Hiramatsu wrote:
> > On Mon, 21 Jan 2019 12:20:07 +0000
> > James Morse <james.morse@arm.com> wrote:
> > > On 15/01/2019 06:25, Masami Hiramatsu wrote:
> > > > Use arch_populate_kprobe_blacklist() instead of
> > > > arch_within_kprobe_blacklist() so that we can see the full
> > > > blacklisted symbols under the debugfs.
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > > index b9e9758b6534..6c066c34c8a4 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> > > >  	return DBG_HOOK_HANDLED;
> > > >  }
> > > >  
> > > > -bool arch_within_kprobe_blacklist(unsigned long addr)
> > > > +int __init arch_populate_kprobe_blacklist(void)
> > > >  {
> > > > -	if ((addr >= (unsigned long)__kprobes_text_start &&
> > > > -	    addr < (unsigned long)__kprobes_text_end) ||
> > > > -	    (addr >= (unsigned long)__entry_text_start &&
> > > > -	    addr < (unsigned long)__entry_text_end) ||
> > > > -	    (addr >= (unsigned long)__idmap_text_start &&
> > > > -	    addr < (unsigned long)__idmap_text_end) ||
> > > 
> > > > -	    in_exception_text(addr))
> > > 
> > > You added this one in the previous patch, but it disappears here.
> > 
> > Yes, it is easy to explain how we transcribe from 
> > arch_within_kprobe_blacklist() to arch_populate_kprobe_blacklist().
> > 
> > > 
> > > 
> > > > -		return true;
> > > > -
> > > > -	if (!is_kernel_in_hyp_mode()) {
> > > > -		if ((addr >= (unsigned long)__hyp_text_start &&
> > > > -		    addr < (unsigned long)__hyp_text_end) ||
> > > > -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> > > > -		    addr < (unsigned long)__hyp_idmap_text_end))
> > > > -			return true;
> > > > -	}
> > > > -
> > > > -	return false;
> > > > +	int ret;
> > > 
> > > 
> > > > +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> > > > +					(unsigned long)__kprobes_text_end);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
> > > blacklist the kprobes section itself?
> > 
> > Ah, good catch! No, we don't need it here. Sorry I worked on older patch.
> > I'll update it.
> 
> Did you send a new version of this series? I can't seem to spot it in my
> inbox.

Ah, OK. I just waited for James' patch series,

https://patchwork.kernel.org/cover/10779489/

Are those merged? I'd like to move this series on that.

Thank you for ping! :)


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
