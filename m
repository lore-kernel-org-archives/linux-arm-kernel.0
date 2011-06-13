From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 15:22:10 +0100
Subject: [Patch v2 03/11] ARM: hwcaps: use shifts instead of hardcoded
	constants
In-Reply-To: <20110613141013.GA419@e102144-lin.cambridge.arm.com>
References: <1307536233-30089-1-git-send-email-will.deacon@arm.com>
	<1307536233-30089-4-git-send-email-will.deacon@arm.com>
	<4DF616C4.4040709@ru.mvista.com>
	<20110613141013.GA419@e102144-lin.cambridge.arm.com>
Message-ID: <20110613142209.GD13643@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 03:10:13PM +0100, Will Deacon wrote:
> Sergei,
> 
> On Mon, Jun 13, 2011 at 02:55:16PM +0100, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 08-06-2011 16:30, Will Deacon wrote:
> > 
> > > The HWCAP numbers are defined as constants, each one being a power of 2.
> > > This has become slightly unwieldy now that we have reached 32k.
> > 
> > > This patch changes the HWCAP defines to use (1<<  n) instead of coding
> > > the constant directly. The values remain unchanged.
> > 
> >     Perhaps it's better to use BIT(n) macro instead?
> 
> That has the downside of breaking userspace, unless we export linux/bitops.h
> and remove the __KERNEL__ guards around the BIT macro.

And potentially break userspace programs which also have a BIT() macro.
No, we need to keep using plain C for exported definitions.
