From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 11:55:21 +0100
Subject: [PATCH v2 02/10] ARM: mvebu: add initial support for the Armada
 375 SOCs
In-Reply-To: <3797172.YJcGPMeT5Y@wuerfel>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392200619-3141-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <3797172.YJcGPMeT5Y@wuerfel>
Message-ID: <20140213115521.303c49fa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 12 Feb 2014 14:08:42 +0100, Arnd Bergmann wrote:
> On Wednesday 12 February 2014 11:23:31 Thomas Petazzoni wrote:
> > From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > 
> > This commit adds the basic support for the Armada 375 SOCs. These SoCs
> > share most of their IP with the Armada 370/XP SoCs. The main
> > difference is the use of a Cortex A9 CPU instead of the PJ4B CPU. The
> > interrupt controller and the L2 cache controller are also different
> > they are respectively the GIC and the PL310.
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  .../devicetree/bindings/arm/armada-375.txt         |  9 +++++
> >  arch/arm/mach-mvebu/Kconfig                        | 15 ++++++++
> >  arch/arm/mach-mvebu/Makefile                       |  1 +
> >  arch/arm/mach-mvebu/armada-375.c                   | 44 ++++++++++++++++++++++
> 
> I don't know what the outcome was for the first version, but just
> for the record, I would prefer merging the board file into armada-370-xp.c
> without renaming that file. Keeping the separate Kconfig entry makes sense
> because we want to select different options there. If you have differences
> between the implementations (so far the 370/xp code should just work
> on 375), you can use a combination of if(IS_ENABLED(CONFIG_*)) and
> if(machine_is_compatible()) to do the detection but keep a common
> dt_compat list.

Thanks for your review! I will shortly post a new version that uses a
single "board file" (even though "board file" is a somewhat odd name in
this DT era!).

However, I've kept separate dt_compat lists, because we will need
different SMP operations between Armada 370/XP (which are PJ4B based)
and Armada 375/38x (which are Cortex-A9 based).

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
