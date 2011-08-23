From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 18:45:50 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20051.57581.894859.395981@mariner.uk.xensource.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20051.57581.894859.395981@mariner.uk.xensource.com>
Message-ID: <20110823174550.GJ3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 06:18:37PM +0100, Ian Jackson wrote:
> Yes.  But in the future it will do, surely ?  I mean, we're working on
> bootloader protocols and this part (to do with startup cpu states and
> ownership of the various privilege levels) is only part of it.

No - at least not yet, and I don't see any reason why we'd ever want to
use raw ELF.

The problem with ELF is that it carries lots of baggage around which
platforms just don't need.  Fine if it's on a hard disk and you're
booting a desktop, but not for embedded where space tends to be a
premium.

And most of that additional data just isn't required.

Plus, I'd point out that _no one_ is talking about boot protocols.  Not
outside linaro at any rate.  Which means that they're doing effective
closed-door discussion.
