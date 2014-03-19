From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Mar 2014 22:22:30 +0100
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqL02dw7B+GEL4921f_7m=RRUokW0n64TxSJnMWN3MMfrQ@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314175701.GR21483@n2100.arm.linux.org.uk>
 <CAL_JsqL02dw7B+GEL4921f_7m=RRUokW0n64TxSJnMWN3MMfrQ@mail.gmail.com>
Message-ID: <201403192222.30622.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 14, 2014 at 08:14:06 PM, Rob Herring wrote:
> On Fri, Mar 14, 2014 at 12:57 PM, Russell King - ARM Linux
> 
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 14, 2014 at 11:02:17AM -0500, Rob Herring wrote:
> >> The obvious fix is to convert l2x0_flush_line to a function ptr which
> >> just further complicates the code.
> > 
> > I currently regard this code as unmaintainable, so right now I'm in the
> > process of completely rewriting it, going back to the specs and checking
> > what is required.  Sharing code between the L210, L220 and L310 looks
> > good from the point of view of keeping the line count down, but actually
> > they're quite different and have various different requirements.
> > 
> > Out of those, L220 is the odd one out: all operations are background
> > operations there, which means they have to be waited for.  Currently,
> > if you have one of these, and you build a multiplatform kernel which
> > includes PL310 support, you don't wait for any of these and you probably
> > see a lot of data corruption as a result.
> 
> Oops. I guess there are not many users as the L220 was primarily used
> with the 1176 (and 11MP?) IIRC. I guess one of the primary 1176 based
> platforms currently used is RPi, but it appears the BCM2835 doesn't
> have an L2 (other than some custom L2 for the GPU).

Won't Freescale i.MX35 help here ? It's 1136JF-S core and has some L2 cache.

Best regards,
Marek Vasut
