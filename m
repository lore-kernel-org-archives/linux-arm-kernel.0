From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 15:00:57 +0000
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <50A01B5F.6040404@wwwdotorg.org>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <CAA-5wcDo2OJSD9O4YfJkxYDukCSMJo46at2NR9e41fZbAhh7wA@mail.gmail.com>
 <50A01B5F.6040404@wwwdotorg.org>
Message-ID: <201211121500.57638.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 November 2012, Stephen Warren wrote:
> > I'm following the other mobile ARM SoCs which all have a single mach-
> > directory for various families of chips (mach-tegra, mach-omap2,
> > etc...). Plus the intent is to have a single set of mach files that
> > works across bcm SoCs, so it is preferable to keep it in a single mach-bcm.
> 
> It's quite possible to create one directory now, e.g. mach-bcm281xx, and
> then when consolidation with other mach-bcm* happens, merge all those
> directories into a single mach-bcm. I would tend to prefer (but only
> lightly) using mach-bcm281xx now and then renaming later, unless you
> plan on expanding the SoC support in the pretty near future.

I think the main question is how many files we expect to see in the
platform directories for each of bcm3528, bcm281xx and bcm476x. Right
now, my feeling is that each of them can be a single file, since most
of the stuff that has traditionally been in mach-* directories is
moving out to drivers now.

If that is the case, having one directory for each platform is a little
silly and we should just stick them all in one place, using the
"mach-bcm" name more as a help for people looking for the code than
an indication of being a single soc family or maintained by the same
person.  We already have some precedent in shmobile, which contains
some platforms that were completely distinct at the time they were
introduced.

You still have to work out how you want to maintain that directory though,
either just having per-file maintainers, or having multiple people
take responsible for the entire directory.

	Arnd
