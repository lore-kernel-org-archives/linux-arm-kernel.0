From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Apr 2015 13:00:05 -0700
Subject: Two new breakages since Thursday
In-Reply-To: <2870641.sYo0J47DWm@wuerfel>
References: <20150405080645.GE13898@n2100.arm.linux.org.uk>
 <20150414150459.GD18048@atomide.com>
 <20150414162154.GE18048@atomide.com> <2870641.sYo0J47DWm@wuerfel>
Message-ID: <20150415200004.GG18048@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [150415 12:52]:
> On Tuesday 14 April 2015 09:21:55 Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [150414 08:13]:
> > > * Arnd Bergmann <arnd@arndb.de> [150414 08:00]:
> > > > On Tuesday 14 April 2015 07:28:47 Tony Lindgren wrote:
> > > > > > I managed to catch up with my email last night and pulled in these two fixes
> > > > > > as well as a number of others that we had neglected over the last two weeks.
> > > > > > 
> > > > > > I found one new regression with the overnight build tests in a branch I pulled
> > > > > > in as 'next/late' from Tony, and backed that out now. I'll wait for you and
> > > > > > Stephen Rothwell (who also reported these issues) to confirm that it's ok
> > > > > > now and we'll hopefully be ready to send pull requests by the end of the
> > > > > > week.
> > > > > 
> > > > > Hmm what's this issue you're mentioning here for the next/late? Is it the
> > > > > merge conflict with camera related changes fixed up by Stephen Rothwell
> > > > > in next?
> > > > > 
> > > > > 
> > > > 
> > > > This is the error I get during 'make dtbs':
> > > > 
> > > >   DTC     arch/arm/boot/dts/am3517_mt_ventoux.dtb
> > > > ERROR (phandle_references): Reference to non-existent node or label "omap3_scm_general"
> > > > 
> > > > The problem is evidently commit b8845074cfbbd ("ARM: dts: omap3: add
> > > > minimal l4 bus layout with control module support"), which for some reason
> > > > removes the tisyscon at 48002270 node that is still referenced through
> > > > the &omap3_scm_general label from omap34xx.dtsi and omap36xx.dtsi.
> > > 
> > > I believe this issue got introduced on the 7th by the camera patches
> > > I acked earlier.
> > 
> > Actually, investigating it further, looks like my for-next branch is
> > missing my omap-for-v4.1/dt-v2 branch already merged into arm-soc
> > for-next.. Sorry about that, this merge conflict could have been
> > avoided if I had not missed that branch when rebuilding my for-next.
> > 
> > Anyways, Stephen's resolve below is correct. Arnd, I suggest you
> > remerge it with --no-commit and apply Stephen's resolution below
> > manually.
> > 
> 
> I've pulled in the omap/dt branch into next/late now, and fixed the
> merge up in that way. I'm putting it back into for-next now.

OK thanks!
 
> We're running a bit late with the normal pull request now, so
> no promises that next/late will still make it in time.

Yes sure totally understood.

Regards,

Tony
