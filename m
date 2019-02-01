Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02642C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:04:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C896A21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YvJsPqjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C896A21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TNtOMXCwfabhNxUeyCaSyBQmJx91fgMPrsU69d7ckzk=; b=YvJsPqjgB2XJrW
	SXyVeXdsCsBjP0NfDeJxF1Z272TwaLPN9/d0n/8iJhafrXaJ5QWNjbwkbUGegAm1ANR4M9vV9v+cF
	pe7DsA/iPS6UAkesYedrOJWkXQKxxtgTBSVpgis87z7xEat8NsLS3zYA/xz9VuwBhhD1meV/8Fhfj
	Y4mUdGTGs4WH27pGtJBmj2SoiqIqJOifNq4BwDdiXELvo5qEDQnNKW0M+MXD5MbG5NAExli+hZXi4
	r8kmsIgHXx+nQ4CrxwMiWnoWitFp3S4z4IeDVoRnyENCEbFpDTFW6+SxO7M3FlinOB23low4ghyHp
	yfJGTUaPAtyesbL+i9lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTo4-0000Qn-TV; Fri, 01 Feb 2019 08:04:12 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTo1-0000QS-OC
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:04:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78C6A78;
 Fri,  1 Feb 2019 00:04:08 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381053F71E;
 Fri,  1 Feb 2019 00:04:08 -0800 (PST)
Date: Fri, 1 Feb 2019 09:04:06 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Forbid kprobing of the VHE
 world-switch code
Message-ID: <20190201080406.GR13482@e113682-lin.lund.arm.com>
References: <20190124163257.233929-1-james.morse@arm.com>
 <20190124163257.233929-2-james.morse@arm.com>
 <20190131080841.GK13482@e113682-lin.lund.arm.com>
 <2711e333-bbe2-a207-604c-43c2c84cef38@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2711e333-bbe2-a207-604c-43c2c84cef38@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_000409_799864_ABEC9813 
X-CRM114-Status: GOOD (  28.74  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 06:53:06PM +0000, James Morse wrote:
> Hey Christoffer,
> 
> On 31/01/2019 08:08, Christoffer Dall wrote:
> > On Thu, Jan 24, 2019 at 04:32:54PM +0000, James Morse wrote:
> >> On systems with VHE the kernel and KVM's world-switch code run at the
> >> same exception level. Code that is only used on a VHE system does not
> >> need to be annotated as __hyp_text as it can reside anywhere in the
> >> kernel text.
> >>
> >> __hyp_text was also used to prevent kprobes from patching breakpoint
> >> instructions into this region, as this code runs at a different
> >> exception level. While this is no longer true with VHE, KVM still
> >> switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
> >> world-switch code will cause a hyp-panic.
> > 
> > Forgive potentially very stupid questions here, but:
> > 
> >  (1) Would it make sense to move the save/restore VBAR_EL1 to the last
> >      possible moment, and would that actually allow kprobes to work for
> >      the world-switch code, or does that just result in other weird
> >      problems?
> 
> This would work for taking the debug exception. But next kprobes wants to
> single-step the probed instruction in an out-of-line slot. I don't think we can
> do this if we've already configured the debug hardware for the guest.
> (If could at least turn single-step off when we return to guest-EL0, which
> guest-EL1 was single-stepping)
> 
> 

I suspected something like that, let's not go there.

> >  (2) Are we sure that this catches every call path of every non-inlined
> >      function called after switchign VBAR_EL1?  Can kprobes only be
> >      called on exported symbols, or can you (if you know the address
> >      somehow) put a kprobe on a static function as well.  If there are
> >      any concerns in this area, we might want to consider (1) more
> >      closely.
> 
> Hmmm, good question. The blacklisting applies to whole symbols as seen by
> kallsyms, the compiler has no idea what is going on.
> 
> If it chose not to inline something, it would be kprobe'able yes.
> 
> __kprobes uses a section function-attribute instead. The gcc manual[0] doesn't
> say what happens when inline and the section attributes are used together. (or
> at least I couldn't find it)
> 
> A quick experiment with gcc 8.2.0 shows adding __kprobes on the inlines gets
> discarded when they are inlined. I'm not sure how to trick the compiler into
> not-inlining it to see what happens, but adding 'noinline' to the header file
> causes it to duplicate the function everywhere, but puts it in the __kprobes
> section.
> 
> (For KVM we could use the 'flatten' attribute, but that does say 'if possible'.
> Alternatively we can decorate all the inline helpers we know we use with
> __kprobes as a safety net.)
> 
> I think this is a wider problem with kprobes.
> 

Sounds like it.  Probably in the "you did something crazy, and your
kernel is going to suffer from it" category.

Let's stick to your approach.

Thanks for the explanation.

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
