From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2011 15:43:13 +0100
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support
	code to v7/Thumb-2
In-Reply-To: <20110912143708.GB2020@arm.com>
References: <1315497854-13311-3-git-send-email-dave.martin@linaro.org>
	<201109081845.58260.arnd@arndb.de>
	<CAMPhdO82ho2WPrJ3irwLgfPOycQt=kyqK3hhtrLCjOw1vptTrg@mail.gmail.com>
	<20110908172002.GG2070@arm.com>
	<CAMPhdO9USGfrpgR0fXUL6024qWGLqsS72vzaO6AH1oo-TW1RtA@mail.gmail.com>
	<1315562102.7961.5.camel@linaro1>
	<alpine.LFD.2.00.1109090919170.20358@xanadu.home>
	<20110909164123.GB3069@arm.com>
	<alpine.LFD.2.00.1109091339540.20358@xanadu.home>
	<20110912143708.GB2020@arm.com>
Message-ID: <20110912144313.GD7007@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 03:37:08PM +0100, Dave Martin wrote:
> Agreed, but the trouble is that what constitutes a suitable data
> dependency is completely microarchitecture dependent -- we're relying
> on side-effects outside the architecture here.
> 
> We can't code _exactly_ the same thing in Thumb-2 because of restrictions
> in the instruction set, so we have to settle for something that "looks
> similar" -- but there's no guarantee it will work.
> 
> Do you feel your judgement on this is authoritative?  If so, then
> we can go ahead with your suggestion; otherwise we might need input
> from someone else.

How about we ask Haojian Zhuang what the recommended sequence is for
ensuring that writes hit CP15 when executing in Thumb-2 mode on PJ4,
instead of blindly beating around the issue without really knowing
what we're doing?
