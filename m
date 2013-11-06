From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Nov 2013 18:02:41 +0000
Subject: [PATCH v5 4/7] arm64: introduce
 aarch64_insn_gen_{nop|branch_imm}() helper functions
In-Reply-To: <20131106114530.76b63b05@gandalf.local.home>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-5-git-send-email-liuj97@gmail.com>
 <20131030004840.GC25346@mudshark.cambridge.arm.com>
 <20131106114530.76b63b05@gandalf.local.home>
Message-ID: <20131106180241.GB4524@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 04:45:30PM +0000, Steven Rostedt wrote:
> On Wed, 30 Oct 2013 00:48:40 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> 
> > > +}
> > > +
> > > +static __always_inline u32 aarch64_insn_gen_nop(void)
> > > +{
> > > +	return aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
> > > +}
> > 
> > Either use plain old `inline' or write these as preprocessor macros.
> > 
> 
> I'm curious to why you say that? Preprocessor macros are rather ugly,
> and in x86 we use "__always_inline" quite liberally.

I can understand why you might use __always_inline over the preprocessor
when you *really* need something inlined, but in this case I don't see why
`inline' isn't sufficient. It's just a cosmetic issue, really.

Will
