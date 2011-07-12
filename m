From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Jul 2011 08:14:01 +0100
Subject: [PATCH 19/51] ARM: kprobes: Infrastructure for table driven
	decoding of CPU instructions
In-Reply-To: <alpine.LFD.2.00.1107111552140.14596@xanadu.home>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
	<1310209058-20980-20-git-send-email-tixy@yxit.co.uk>
	<alpine.LFD.2.00.1107111552140.14596@xanadu.home>
Message-ID: <1310454841.2258.3.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-11 at 16:05 -0400, Nicolas Pitre wrote:
> On Sat, 9 Jul 2011, Tixy wrote:
> 
> > +static kprobe_opcode_t __kprobes
> > +prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
> > +								bool thumb)
> > +{
> > +#ifdef CONFIG_THUMB2_KERNEL
> > +	if (thumb) {
> > +		u16* thumb_insn = (u16 *)asi->insn;
> 
> Ninor style nit: we usually put the * against the variable rather than 
> the type.

checkpatch doesn't catch that one. I'll try and come up with a
simplified test case for a bug report.

-- 
Tixy
