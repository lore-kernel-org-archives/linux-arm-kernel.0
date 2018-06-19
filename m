From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 12:48:09 +0100
Subject: [PATCHv3 02/19] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
In-Reply-To: <20180618120310.39527-3-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-3-mark.rutland@arm.com>
Message-ID: <20180619114808.46jquqek6vpgdnnm@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:53PM +0100, Mark Rutland wrote:
> Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
> self-consistent with an assertion in config_sctlr_el1(). This is a bit
> unusual, since config_sctlr_el1() doesn't make use of these definitions,
> and is far away from the definitions themselves.
> 
> We can use the CPP #error directive to have equivalent assertions in
> <asm/sysreg.h>, next to the definitions of the set/clear bits, which is
> a bit clearer and simpler.
> 
> At the same time, lets fill in the upper 32 bits for both registers in
> their repsective RES0 definitions. This could be a little nicer with

Typo: s/repsective/respective/

I've fixed that up locally.

Mark.
