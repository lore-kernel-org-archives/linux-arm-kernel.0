From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Jun 2015 11:04:30 -0700
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
 <556C8ED5.5050000@myspectrum.nl>
 <20150601173126.GY30984@atomide.com>
 <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com>
Message-ID: <20150601180429.GA30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150601 10:45]:
> On Mon, 1 Jun 2015, Tony Lindgren wrote:
> 
> > * Jeroen Hofstee <linux-arm@myspectrum.nl> [150601 09:58]:
> > > On 01-06-15 17:30, Tero Kristo wrote:
> > > >New system control module layout for omap3 overlooked parts of the am35xx
> > > >configuration. Basically the am35xx clocks were not converted to use the
> > > >changed offsets, which caused weird boot warnings. The errors were not
> > > >fatal so far, so they were not caught earlier. Fixed by applying the
> > > >proper offsets for the AM35xx scm clocks.
> > > >
> > > >Fixes: b8845074cf ("ARM: dts: omap3: add minimal l4 bus layout with...")
> > > >
> > > >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > > >Reported-by: Jeroen Hofstee <linux-arm@myspectrum.nl>
> > > >Cc: Paul Walmsley <paul@pwsan.com>
> > > >Cc: Tony Lindgren <tony@atomide.com>
> > > >---
> > > >  arch/arm/boot/dts/am35xx-clocks.dtsi |   14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > With this patch the error interrupt / stack dumps are no longer present.
> > > 
> > > Thanks,
> > > 
> > > Tested-by: Jeroen Hofstee <jeroen@myspectrum.nl>
> > 
> > Thanks, I'm suprised this was not caught earlier with all the automated
> > boot testing going on?
> 
> At least speaking in terms the testbed results that I post, the warnings 
> get reported.  But not many people seem to act on them.  (Jeroen is a 
> pleasant exception.)
> 
> See for example the "Build warnings from toolchain", "Kernel warnings 
> during boot to userspace", "Kernel warnings during PM test", and "Obsolete 
> Kconfig symbols" sections here:
> 
> http://www.pwsan.com/omap/testlogs/test_v4.1-rc6/20150601012139/README.txt

OK somehow 3517evm is listed under "skip" there? 
 
> The best way to make this work IMHO would be for us not to accept any new 
> feature addition patches as long as there are warnings reported in the 
> test results.  The only real exception that I would foresee is if those 
> warnings are due to something outside of our control, e.g., a crappy 
> bootloader, as I suspect the USB_OTG initiator warnings are for the 
> CM-T3517.

Right. Also seems we should diff dmesg output too (after stripping out
the timestamps). Pretty much the only things that should change are
the sysfs paths for devices in the dmesg output unless some warnings
get fixed. That output probably still also needs to be manually looked
at though..

Regards,

Tony
