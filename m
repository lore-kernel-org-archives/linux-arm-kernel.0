From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Apr 2014 14:45:10 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140403133637.GB1784@dragon>
References: <20140402085914.GG7528@n2100.arm.linux.org.uk>
 <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
 <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402165113.GJ7528@n2100.arm.linux.org.uk>
 <a52a4e6119c143799220667a25781844@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140403085636.GL7528@n2100.arm.linux.org.uk>
 <f5dfa7eca60346e884768bf821594d06@BY2PR03MB377.namprd03.prod.outlook.com>
 <20140403103206.GN7528@n2100.arm.linux.org.uk> <20140403133637.GB1784@dragon>
Message-ID: <20140403134510.GO7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 09:36:41PM +0800, Shawn Guo wrote:
> On Thu, Apr 03, 2014 at 11:32:06AM +0100, Russell King - ARM Linux wrote:
> > > Hi, Russell,
> > > 
> > > I don't contradict your thinking/solution and measurements.  You are
> > > expert on arm/modules, we keep study attitude to dicuss with you.
> > > For imx6sx, we indeed get the result. For imx6q/dl linux upstream, you
> > > did great job on performance tuning, and the test result is similar
> > > To our internal test result. Your suggestion for the optimiztion is
> > > meaningful. Pls understand my thinking.  
> > 
> > The reason I said what I said is because I'm not talking about TSO.  I'm
> > talking about GSO.  They're similar features, but are done in totally
> > different ways.
> > 
> > TSO requires either hardware support, or driver cooperation to segment
> > the data.  GSO does not.
> > 
> > There's several points here which make me discount your figures:
> 
> Russell,
> 
> In case there is a confusion.  The 900Mbps figure that Fugang said is
> not on any of i.MX6 SoCs that are publicly available - i.MX6SoloLite
> (imx6sl), i.MX6Solo/DualLite (imx6dl), i.MX6Dual/Quad (imx6q), but on
> a new member of i.MX6 family - i.MX6SoloX (imx6sx).  This new SoC hasn't
> been announced by Freescale yet.  One major improvement of this new SoC
> over its ancestors is the FEC throughput.  It claims 1Gbps throughput
> support.  So it's really a hardware optimization instead of anything
> that software can do.

That means it's irrelevant to this discussion because it's different
hardware, with who knows what changes to the memory subsystem and
CPU/cache implementation.  Hence, it can't be compared in any way to
the performance I see on iMX6Q and iMX6S.

What matters for here is fixing the issues with the mainline driver on
hardware that people have today - not only the bugs and instability
that people are seeing, but also the low performance.

If some of that involves doing stuff "The Right Way" by using memory
barriers rather than violating the architecture specification and
introducing new kernel APIs in order to do so, we're going to do it
the right way, even if that means that those changes may not be in the
best interest of this unreleased part.  There is no room for compromise
on that.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
