From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Dec 2014 21:06:17 +0100
Subject: [PATCH] ARM: SAMSUNG: remove dead #elif CONFIG_S3C24XX_DMAC
In-Reply-To: <CABv5NL_GisHMZVK03M3j_cGMVcoZ7L+Czt5TP2Sp4abBeUxuCQ@mail.gmail.com>
References: <1418830837-7422-1-git-send-email-stefan.hengelein@fau.de>
 <1645416.VNQj8YWB7M@phil>
 <CABv5NL_GisHMZVK03M3j_cGMVcoZ7L+Czt5TP2Sp4abBeUxuCQ@mail.gmail.com>
Message-ID: <23285910.CzU2Gzn1KL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 December 2014 15:15:09 Stefan Hengelein wrote:
> From what i can see, the block was already dead when it was introduced.
> d2193ce2 changed the "if ARCH_S3C64XX" into the Kconfig file itself,
> before it was around the source statement in arch/arm/Kconfig
> 
> if there are really just downstream users that explicitly have to add
> a statement to select S3C64XX_DEV_SPI0 and therefore add the
> possibility to enable the block i want to remove, i'd argue that these
> downstream users could also add the block itself. I'm not sure how
> intuitive it might be for downstream users to add a select in Kconfig
> to enable their machine to communicate with a device, but i'm also not
> familiar with the hardware we're talking about.
> 
> However, i'd prefer to have a consistent upstream state and leave
> these problems to downstream users, but that's for the Maintainer to
> decide 

In general, I totally agree: dead code should be eliminated and out of
tree users of dead code can add it back as a patch.

However, in this case, I'd lean more towards leaving the code in there,
basically because the current code correctly documents what the hardware
requirements are, and that is helpful even for reading the code when you
work on DT based support for the same hardware. Eventually we will be
able to remove the entire function.

	Arnd
