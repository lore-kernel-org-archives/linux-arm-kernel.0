From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 17:50:00 +0000
Subject: [PATCH] arm: ensure dump_instr() checks addr_limit
In-Reply-To: <20171102174628.GC27444@kroah.com>
References: <20171102163452.7652-1-mark.rutland@arm.com>
 <20171102164706.GC5061@kroah.com>
 <20171102173003.t5wugpup26eu2hpx@lakrids.cambridge.arm.com>
 <20171102174628.GC27444@kroah.com>
Message-ID: <20171102175000.GJ9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 06:46:28PM +0100, Greg KH wrote:
> On Thu, Nov 02, 2017 at 05:30:04PM +0000, Mark Rutland wrote:
> > On Thu, Nov 02, 2017 at 05:47:06PM +0100, Greg KH wrote:
> > > On Thu, Nov 02, 2017 at 04:34:52PM +0000, Mark Rutland wrote:
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > Huh?  What's that doing up here?
> > 
> > [...]
> > 
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > > Cc: stable at vger.kernel.org
> > > 
> > > It's right here...
> > 
> > Sorry; I'd generated this commit message from another. I must've
> > accidentally passed -s to git commit before copying the text I wanted.
> > 
> > I will be more careful in future, and I'll remove the first instance
> > if/when submitting this to Russell's patch system.
> 
> Russell's patch system?  That's still in use and required?  Ugh, that's
> crazy...

Better than me missing patches because they've been buried under tonnes
of email.  It also does a fair number of checks, and there's been some
discussion today about adding to the checks it does to catch stupidity
in what the binutils assembler now accepts (to stop patches that appear
to be tested but are broken from getting in, as what happened last night.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
