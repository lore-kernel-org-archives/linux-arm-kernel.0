From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 13:47:19 +0100
Subject: [FOR DISCUSSION 0/9] Dove PMU support
In-Reply-To: <20150313123211.GG8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <3456973.vXF9zkXSFZ@wuerfel> <20150313123211.GG8656@n2100.arm.linux.org.uk>
Message-ID: <2953786.DBeOKcOQ8q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 12:32:11 Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 01:26:17PM +0100, Arnd Bergmann wrote:
> > On Friday 13 March 2015 12:11:27 Russell King - ARM Linux wrote:
> > > Of course, I also have a patch which adds legacy support to
> > > arch/arm/mach-dove, but I've assumed you're not interested in that...
> > 
> > You mean legacy support in mach-mvebu?
> 
> No.
> 
> As you'll see, this uses a platform device notifier to hook the devices
> onto the appropriate PM domain, which is why the driver needs to be
> registered early.  This also gets used in DT mode with one legacy
> platform device which is dynamically registered (something which can't
> happen with DT.)

Ok, got it. I think that's fine too. If this helps you spend less
time on forward-porting your patches and in turn completing the
full dove support with DT faster, I'm all for merging this one too.

	Arnd
