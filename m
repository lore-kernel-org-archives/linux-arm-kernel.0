From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Feb 2014 12:50:15 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2036226.egxWL7qC66@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014 12:04:23 Thomas Petazzoni wrote:
> In preparation to the introduction of the support of Armada 375 and
> Armada 38x, this commit renames arch/arm/mach-mvebu/armada-370-xp.c to
> arch/arm/mach-mvebu/armada-mvebu.c. The armada-mvebu.c name was chosen
> because:
> 
>  * As we are going to merge the support for Kirkwood and Dove into
>    mach-mvebu, there will be other files with DT_MACHINE_START
>    structures, so a generic name such as board-dt.c or mvebu.c does
>    not work.
> 
>  * A simple armada.c does not work, because there are Marvell Armada
>    SOCs that are not part of the MVEBU family. For example, the
>    Marvell Armada 1500 are part of the mach-berlin family, which is a
>    completely separate line of SOCs.

Your reasoning for the new name makes a lot of sense, but my personal
opinion is that I'd rather leave the name as it is and deal with the
fact that it's not the best name. Renaming files often causes unexpected
problems, in particular if someone else wants to modify the same file.

	Arnd
