From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 6 Nov 2013 11:45:30 -0500
Subject: [PATCH v5 4/7] arm64: introduce
 aarch64_insn_gen_{nop|branch_imm}() helper functions
In-Reply-To: <20131030004840.GC25346@mudshark.cambridge.arm.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-5-git-send-email-liuj97@gmail.com>
 <20131030004840.GC25346@mudshark.cambridge.arm.com>
Message-ID: <20131106114530.76b63b05@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Oct 2013 00:48:40 +0000
Will Deacon <will.deacon@arm.com> wrote:


> > +}
> > +
> > +static __always_inline u32 aarch64_insn_gen_nop(void)
> > +{
> > +	return aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
> > +}
> 
> Either use plain old `inline' or write these as preprocessor macros.
> 

I'm curious to why you say that? Preprocessor macros are rather ugly,
and in x86 we use "__always_inline" quite liberally.

-- Steve
