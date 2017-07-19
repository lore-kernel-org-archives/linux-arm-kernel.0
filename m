From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 19 Jul 2017 15:05:42 +0100
Subject: [PATCH 1/2] arm64: syscallno is secretly an int, make it official
In-Reply-To: <20170719151455.06d93ff4@karo-electronics.de>
References: <1500381724-19003-1-git-send-email-Dave.Martin@arm.com>
 <1500381724-19003-2-git-send-email-Dave.Martin@arm.com>
 <20170719151455.06d93ff4@karo-electronics.de>
Message-ID: <20170719140541.GB1538@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 03:14:55PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Tue, 18 Jul 2017 13:41:43 +0100 Dave Martin wrote:
> > The upper 32 bits of the syscallno field in struct pt_regs are handled
> > inconsistently, being sometimes zero extended and sometimes
> > sign-extended.  The reason for this appears to be that they are not
> > intentionally significant at all.
> > 
> My english parser fails on "not intentionally significant at all".

Hmmm, that was rather convoluted.

How about:

--8<--

In fact, only the lower 32 bits seem to have any real significance for
the behaviour of the code: it's been OK to handle the upper bits
inconsistently because they don't matter.

Cheers
---Dave
