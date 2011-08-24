From: nbowler@elliptictech.com (Nick Bowler)
Date: Wed, 24 Aug 2011 13:51:55 -0400
Subject: [PATCH v2] ARM: vexpress: Use wfi macro in platform_do_lowpower.
In-Reply-To: <20110822135952.GE2796@pulham.picochip.com>
References: <CAHkRjk6Fq+1b_uM+DFACS1QVd7B6_1XhqRw-27i88U1VyvLk+Q@mail.gmail.com>
	<1314021259-31710-1-git-send-email-nbowler@elliptictech.com>
	<20110822135952.GE2796@pulham.picochip.com>
Message-ID: <20110824175155.GA13380@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-08-22 14:59 +0100, Jamie Iles wrote:
> On Mon, Aug 22, 2011 at 09:54:19AM -0400, Nick Bowler wrote:
> > Current Versatile Express CPU hotplug code includes a hardcoded WFI
> > instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> > mode, this is invalid and causes the machine to hang hard when a CPU
> > is offlined.
> > 
> > Using the wfi macro (which uses the appropriate assembler mnemonic)
> > causes the correct instruction to be emitted in either case.  As a
> > consequence of this change, an apparently vestigial "cc" clobber is
> > dropped from the asm (the macro uses "memory" only).
> > 
> > Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> > ---
> 
> Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> 
> if it helps!

Thanks!

Since there seem to be no objections, I'll send this off to Russell's
tracker.

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
