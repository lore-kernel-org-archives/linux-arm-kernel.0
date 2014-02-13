From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 12:55:26 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <2036226.egxWL7qC66@wuerfel>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <2036226.egxWL7qC66@wuerfel>
Message-ID: <20140213125526.3af08c54@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 13 Feb 2014 12:50:15 +0100, Arnd Bergmann wrote:
> On Thursday 13 February 2014 12:04:23 Thomas Petazzoni wrote:
> > In preparation to the introduction of the support of Armada 375 and
> > Armada 38x, this commit renames arch/arm/mach-mvebu/armada-370-xp.c to
> > arch/arm/mach-mvebu/armada-mvebu.c. The armada-mvebu.c name was chosen
> > because:
> > 
> >  * As we are going to merge the support for Kirkwood and Dove into
> >    mach-mvebu, there will be other files with DT_MACHINE_START
> >    structures, so a generic name such as board-dt.c or mvebu.c does
> >    not work.
> > 
> >  * A simple armada.c does not work, because there are Marvell Armada
> >    SOCs that are not part of the MVEBU family. For example, the
> >    Marvell Armada 1500 are part of the mach-berlin family, which is a
> >    completely separate line of SOCs.
> 
> Your reasoning for the new name makes a lot of sense, but my personal
> opinion is that I'd rather leave the name as it is and deal with the
> fact that it's not the best name. Renaming files often causes unexpected
> problems, in particular if someone else wants to modify the same file.

I believe it's a matter of taste here. Having a file named
armada-370-xp.c that handles Armada 375 and Armada 38x looks highly
confusing to me, and I believe both Gr?gory and Ezequiel were of the
same opinion.

The number of changes to this file is very limited, so the probability
of having a large number of complicated patches touching the same file
being in flight is fairly low.

Maybe we can leave this taste decision to the mach-mvebu maintainers?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
