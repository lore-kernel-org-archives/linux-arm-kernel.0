From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Apr 2011 17:02:17 +0200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <4D9EBC2C.2050809@linaro.org>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201104080535.02769.arnd@arndb.de> <4D9EBC2C.2050809@linaro.org>
Message-ID: <201104081702.17409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2011, Lee Jones wrote:
> On 08/04/11 04:35, Arnd Bergmann wrote:
> > On Friday 08 April 2011, Greg KH wrote:
> >> Symlinks are a requirement as multiple cpus can be attached to a single
> >> SoC.
> >>
> >> What about multiple cpus that are attached to multiple SoCs?  Why even
> >> try to describe this relationship, what would userspace get out of this
> >> information?
> > 
> > The only one I can think of is node affinity. I've worked with a system
> > (IBM QS2x Cell blade) that had two SoCs with multiple CPUs each. There was
> > a significant performance penalty when talking to devices on the remote
> > SoC. In that case, we used the NUMA node information in sys to deal
> > with it, but we might not want to use the NUMA infrastructure on systems
> > that only have RAM on one node.
> 
> I'm struggling to see a scenario where we'd have multiple SoCs on a
> single device and only one filesystem. ux500 sub-arch code is yet to
> facilitate SoC counting functionality. If were are to implement per-SoC
> directories would this need to be added?

How can you say we won't need it when I've just given you a specific
example of a widely shipping machine?

It's not important that the kernel internal code supports multiple SoCs as
long as there is no in-tree user for this. It can always be added at a later
point.

What is important is that the user interface accomodates for it. If you
name the device simply /sys/devices/soc/, any user program looking at
that will have to be modified when we have more than one. We cannot
allow that to happen.

	Arnd
