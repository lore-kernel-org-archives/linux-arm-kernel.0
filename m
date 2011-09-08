From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 Sep 2011 15:30:40 -0400 (EDT)
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <CAMPhdO9USGfrpgR0fXUL6024qWGLqsS72vzaO6AH1oo-TW1RtA@mail.gmail.com>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-3-git-send-email-dave.martin@linaro.org>
	<201109081845.58260.arnd@arndb.de>
	<CAMPhdO82ho2WPrJ3irwLgfPOycQt=kyqK3hhtrLCjOw1vptTrg@mail.gmail.com>
	<20110908172002.GG2070@arm.com>
	<CAMPhdO9USGfrpgR0fXUL6024qWGLqsS72vzaO6AH1oo-TW1RtA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1109081528370.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2011, Eric Miao wrote:

> So the problem is really when compiling this file with existing toolchain,
> it's downgrading to v5 compatible mode, and the instruction below
> 
> sub pc, lr, r1, lsr #32
> 
> wouldn't be encoded when building a THUMB2 kernel. Considering the
> r1, lsr #32 is actually to create an explicit data dependency of the previous
> co-processor instruction, would it be one option to rewrite this as something
> like:
> 
> mov r1, r1
> mov pc, lr

That is certainly a pretty simple, obvious and straight forward way to 
deal with this issue.  I think I like this even more.


Nicolas
