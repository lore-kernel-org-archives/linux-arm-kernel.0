From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 11 Jun 2015 16:58:12 +0200
Subject: [PATCH v3 1/2] mtd: nand: sunxi: Replace failsafe timing cfg
 with calculated value
In-Reply-To: <5579A03B.2010406@ultimaker.com>
References: <1433924948-19288-1-git-send-email-r.spliet@ultimaker.com>
 <20150610105913.1851241d@bbrezillon>
 <5579A03B.2010406@ultimaker.com>
Message-ID: <20150611165812.5c0e4c7f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

On Thu, 11 Jun 2015 16:50:35 +0200
Roy Spliet <r.spliet@ultimaker.com> wrote:

> Hello Boris,
> 
> Op 10-06-15 om 10:59 schreef Boris Brezillon:
> > Hi Roy,
> >
> > On Wed, 10 Jun 2015 10:29:07 +0200
> > Roy Spliet <r.spliet@ultimaker.com> wrote:
> >
> >> Calculates the timing cfg value once when initialising a chip, then sets
> >> it on chip select. Register definition documented the A83 user manual.
> > How about rewording the sentence this way:
> >
> > "
> > The TIMING_CFG register was previously statically set to a magic value
> > (extracted from Allwinner's BSP) when initializing the NAND controller.
> > Now that we have more details about the TIMING_CFG register layout
> > (extracted from the A83 user manual) we can dynamically calculate the
> > appropriate value for each NAND chip and set it when selecting the
> > chip.
> > "
> >
> >> Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
> >>
> >> V2:
> >> - Fix crippled comments
> >>
> >> V3:
> >> - Warn for invalid timings
> >> - Style
> > Almost right: the changelog should be placed after the '---' line ;-).
> Git (format-patch, send-email) doesn't let me do that to the best of my 
> knowledge. Other comments I will process, thanks.

Use git format-patch to generate the patches and then add your
changelog before sending the mails with git send-email.

Or you could generate a cover-letter (pass --cover-letter to
format-patch) and put your change log in there.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
