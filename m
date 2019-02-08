Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF4E21917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRq31Rmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF4E21917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YS7y1xn/agJyrAuUWrAkWjefWLigcCLW7A+54RJXrAA=; b=gRq31Rmi7279qE
	0u+kdGKQcfA78dLYlA66+rq26ubjOrTBt+XreX5QYp4S/AJZeRrPr1mrHw8zRwZK+zONeh3S23NqM
	rc8/ITd2SdtATZYXYPApssW6kk/+AAH5hyN2HqypjTJjqklgWwZjORPZRfpqG6ncOttvDgbSdCvO2
	zDr4qTD9WKTBf58twJON8r7Y4zsZTFt6cgqZTGf4wHcYX0MXea+0fSHELntdPxcg469BtCsVfEL2Y
	fcfi/LqkhrJwuGgIW8X71KWVJ8HCnur/vkRkA7XSPdqIwcbYN8xlrK8DPpFO4fsAqkbdirwoFZ9SV
	6OXHu6usqrTABH5Ipd0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2Fs-0001gB-1p; Fri, 08 Feb 2019 09:15:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2Fp-0001fk-BZ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:15:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C8380D;
 Fri,  8 Feb 2019 01:15:22 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D01E3F557;
 Fri,  8 Feb 2019 01:15:21 -0800 (PST)
Date: Fri, 8 Feb 2019 09:15:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190208091519.GB6972@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_011525_401027_B105F766 
X-CRM114-Status: GOOD (  20.04  )
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

On Mon, Jan 21, 2019 at 10:25:58PM +0900, Masami Hiramatsu wrote:
> On Mon, 21 Jan 2019 12:20:07 +0000
> James Morse <james.morse@arm.com> wrote:
> > On 15/01/2019 06:25, Masami Hiramatsu wrote:
> > > Use arch_populate_kprobe_blacklist() instead of
> > > arch_within_kprobe_blacklist() so that we can see the full
> > > blacklisted symbols under the debugfs.
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index b9e9758b6534..6c066c34c8a4 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> > >  	return DBG_HOOK_HANDLED;
> > >  }
> > >  
> > > -bool arch_within_kprobe_blacklist(unsigned long addr)
> > > +int __init arch_populate_kprobe_blacklist(void)
> > >  {
> > > -	if ((addr >= (unsigned long)__kprobes_text_start &&
> > > -	    addr < (unsigned long)__kprobes_text_end) ||
> > > -	    (addr >= (unsigned long)__entry_text_start &&
> > > -	    addr < (unsigned long)__entry_text_end) ||
> > > -	    (addr >= (unsigned long)__idmap_text_start &&
> > > -	    addr < (unsigned long)__idmap_text_end) ||
> > 
> > > -	    in_exception_text(addr))
> > 
> > You added this one in the previous patch, but it disappears here.
> 
> Yes, it is easy to explain how we transcribe from 
> arch_within_kprobe_blacklist() to arch_populate_kprobe_blacklist().
> 
> > 
> > 
> > > -		return true;
> > > -
> > > -	if (!is_kernel_in_hyp_mode()) {
> > > -		if ((addr >= (unsigned long)__hyp_text_start &&
> > > -		    addr < (unsigned long)__hyp_text_end) ||
> > > -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> > > -		    addr < (unsigned long)__hyp_idmap_text_end))
> > > -			return true;
> > > -	}
> > > -
> > > -	return false;
> > > +	int ret;
> > 
> > 
> > > +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> > > +					(unsigned long)__kprobes_text_end);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
> > blacklist the kprobes section itself?
> 
> Ah, good catch! No, we don't need it here. Sorry I worked on older patch.
> I'll update it.

Did you send a new version of this series? I can't seem to spot it in my
inbox.

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
