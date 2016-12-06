From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 6 Dec 2016 17:38:54 +0000
Subject: [PATCH v2 2/2] arm64: Work around broken .inst when defective
 gas is detected
In-Reply-To: <20161206162826.GW1574@e103592.cambridge.arm.com>
References: <1481038065-32153-1-git-send-email-marc.zyngier@arm.com>
 <1481038065-32153-4-git-send-email-marc.zyngier@arm.com>
 <20161206162826.GW1574@e103592.cambridge.arm.com>
Message-ID: <20161206173853.GZ1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 04:28:26PM +0000, Dave Martin wrote:
> On Tue, Dec 06, 2016 at 03:27:45PM +0000, Marc Zyngier wrote:
> > .inst being largely broken with older binutils, it'd be better not
> > to emit it altogether when detecting such configuration (as it
> > leads to all kind of horrors when using alternatives).
> 
> GAS seems to provide few guarantees about the constantness of anything
> other than an expression composed purely of literal constants.  So,
> this may rather be lack of a useful feature rather than a bug per se.
> 
> > Generalize the __emit_inst macro and use it extensively in
> > asm/sysreg.h, and make it generate a .long when a broken gas is
> > detected. The disassembly will be crap, but at least we can write
> > semi-sane code.
> 
> Don't know how much this helps, but if we want decent disassembly then
> one option is to use macros instead of symbols, so that the argument to
> .inst involves only literals after macro expansion.

[...]

It seems that this doesn't solve your problem though ... oh well.

Cheers
---Dave
