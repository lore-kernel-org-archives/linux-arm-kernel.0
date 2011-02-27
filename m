From: will.deacon@arm.com (Will Deacon)
Date: Sun, 27 Feb 2011 11:10:33 +0000
Subject: [PATCH 1/4] msm: scm: Mark inline asm as volatile
In-Reply-To: <8yapqqe3bs3.fsf@huya.qualcomm.com>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-2-git-send-email-sboyd@codeaurora.org>
	<1298635017.958.0.camel@e102144-lin.cambridge.arm.com>
	<8yapqqe3bs3.fsf@huya.qualcomm.com>
Message-ID: <1298805034.4626.4.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-02-26 at 18:12 +0000, David Brown wrote:
> On Fri, Feb 25 2011, Will Deacon wrote:

> > These asm blocks all have sensible looking output constraints. Why
> > do they need to be marked volatile?
> 
> Without the volatile, the compiler is free to assume the only side
> effects of the asm are to modify the output registers.  The volatile is
> needed to indicate to the compiler that the asm has other side effects.

As far as I know, volatile asm does two things:

(1) It stops the compiler from reordering the asm block with respect to
other volatile statements.

(2) It prevents the compiler from optimising the block away when
dataflow analysis indicates it's not required.

If side-effects need to be indicated, won't a memory clobber do the
trick?

Will
