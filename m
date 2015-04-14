From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 16:59:48 +0200
Subject: Two new breakages since Thursday
In-Reply-To: <20150414142847.GC18048@atomide.com>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
 <3997405.uu5IlQn29B@wuerfel> <20150414142847.GC18048@atomide.com>
Message-ID: <4781251.nAZ9xiIQGV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 07:28:47 Tony Lindgren wrote:
> > I managed to catch up with my email last night and pulled in these two fixes
> > as well as a number of others that we had neglected over the last two weeks.
> > 
> > I found one new regression with the overnight build tests in a branch I pulled
> > in as 'next/late' from Tony, and backed that out now. I'll wait for you and
> > Stephen Rothwell (who also reported these issues) to confirm that it's ok
> > now and we'll hopefully be ready to send pull requests by the end of the
> > week.
> 
> Hmm what's this issue you're mentioning here for the next/late? Is it the
> merge conflict with camera related changes fixed up by Stephen Rothwell
> in next?
> 
> 

This is the error I get during 'make dtbs':

  DTC     arch/arm/boot/dts/am3517_mt_ventoux.dtb
ERROR (phandle_references): Reference to non-existent node or label "omap3_scm_general"

The problem is evidently commit b8845074cfbbd ("ARM: dts: omap3: add
minimal l4 bus layout with control module support"), which for some reason
removes the tisyscon at 48002270 node that is still referenced through
the &omap3_scm_general label from omap34xx.dtsi and omap36xx.dtsi.

	Arnd
