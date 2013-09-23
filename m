From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 23 Sep 2013 07:26:32 +0000 (UTC)
Subject: Tegra baseline test results for v3.12-rc1
In-Reply-To: <CAOesGMjAQZMUdC9ZoGhX=zEA3HCky1zwE0-B6fNAJubqO9bVzw@mail.gmail.com>
References: <A4DCC42E2B5835498682FCB0A8F9F873378C267FFD@HQMAIL04.nvidia.com>
 <CAOesGMjAQZMUdC9ZoGhX=zEA3HCky1zwE0-B6fNAJubqO9bVzw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1309230703090.18475@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 18 Sep 2013, Olof Johansson wrote:

> On Wed, Sep 18, 2013 at 9:23 AM, Paul Walmsley <pwalmsley@nvidia.com> wrote:
> 
> > vmlinux object size
> > (delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
> >    text     data      bss    total  kernel
> >  -89208   +10000     -416   -79624  multi_v7_defconfig
> > +299303    +7244    +1484  +308031  tegra_defconfig
> >
> >
> > Boot-time memory difference
> > (delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267))
> >     avail    rsrvd     high    freed                board              kconfig                  dtb
> >         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
> >     -324k     324k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
> >     -324k     324k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
> >     -592k     592k        .       8k       tegra30-beaver      tegra_defconfig       tegra30-beaver
> 
> Hm. These deltas are huge. :(  It would be interesting to know where
> they come from.

In terms of the vmlinux object size deltas, if one compares with OMAP 
v3.11 -> v3.12-rc1:

  http://marc.info/?l=linux-omap&m=137990533109727&w=2

it appears that the 308KB tegra_defconfig delta is pretty close. 

As a historical observation, the past several -rc1s have seen considerable 
vmlinux size increases.  The Tegra data here doesn't go back very far yet, 
but here's the OMAP data:

+158KB: http://www.pwsan.com/omap/testlogs/test_v3.11-rc1/20130721020309/build/size.txt
+105KB: http://www.pwsan.com/omap/testlogs/test_v3.10-rc1/20130518212204/build/size.txt
+235KB: http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/build/size.txt
+195KB: http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/build/size.txt
 +63KB: http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/build/size.txt

...

Regarding the boot-time memory differences, the ~300KB deltas look about 
right, but the 0KB and the ~600KB deltas seem incorrect.  Something is 
probably wrong with some of the scripts here.  Will follow up on that 
this week.


- Paul
