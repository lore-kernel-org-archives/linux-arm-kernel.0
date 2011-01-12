From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 22:23:37 +0000
Subject: Bug: loops_per_jiffy based udelay() mostly shorter than requested
In-Reply-To: <AANLkTik5BmZAOFdYVGAjuoHftQ3qh1oTCEr5MpkCiDVz@mail.gmail.com>
References: <20110109170829.GA14252@flint.arm.linux.org.uk>
	<AANLkTik5BmZAOFdYVGAjuoHftQ3qh1oTCEr5MpkCiDVz@mail.gmail.com>
Message-ID: <20110112222337.GK11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 01:19:49PM -0800, Linus Torvalds wrote:
> On Sun, Jan 9, 2011 at 9:08 AM, Russell King <rmk@arm.linux.org.uk> wrote:
> >
> > Any suggestions or thoughts, or should we not care too much if udelay()
> > produces slightly shorter than desired delays? ?Or am I doing something
> > horribly wrong in the ARM code?
> 
> Judging by the numbers you quote, I would definitely put this in the
> "don't care too much".

Thanks - that's my thoughts too.  I think I'm still going to push out
the rounding patch for the sake of correctness even though it's down
in the noise.
