From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 08:24:07 +0100
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <alpine.LFD.2.00.1007121855470.10598@xanadu.home>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
	<alpine.LFD.2.00.1007121855470.10598@xanadu.home>
Message-ID: <20100713072407.GB19839@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 08:38:26PM -0400, Nicolas Pitre wrote:
> Versatile and RealView are development boards where things like MMU-less 
> builds of Linux are tested.

That's not the reason they invented IO_ADDRESS - that exists because
I never pressed the issue early on when the Integrator port was merged,
and their use has spread and become more or less acceptable.

It's just the same as your io_p2v() macro that you used in your SA1100
port.

> I think what you did is OK.  It is best to include the whole file as 
> generated from the machine registry database when you need it.  This way 
> the merge conflict can easily be resolved by simply keeping the latest 
> version from either merged branches.

Not quite - I'm now undoing some of the changes a mach-types update would
bring because people aren't talking to me to fix stuff in the machine
registry.  So I'm no longer just committing the updated file off the
website.

The problem is that git will automatically merge those "updates", which
makes it much more difficult to sort out.
