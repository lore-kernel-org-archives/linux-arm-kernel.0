From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 18:37:25 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <20170519173503.GX22219@n2100.armlinux.org.uk>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <20170519172934.GI3559@e103592.cambridge.arm.com>
 <20170519173503.GX22219@n2100.armlinux.org.uk>
Message-ID: <20170519173725.GK3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:35:03PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 19, 2017 at 06:29:34PM +0100, Dave Martin wrote:

[...]

> > Err, yes.  Actually I means to write
> > 
> > 	b	1f
> > 	mov	r0, r0
> > 
> > (since executing that nop before branching is presumably pointless).
> 
> That "nop" is part of the 8 nops at the start of the image, since the
> entry point (due to historical reasons) is at 0x20 into the image.

Ah yes.

Cheers
---Dave
