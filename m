From: albert.u.boot@aribaud.net (Albert ARIBAUD)
Date: Fri, 13 Jul 2012 08:45:26 +0200
Subject: [U-Boot] Where to put a large bootloader-supplied device tree
 on ARM ?
In-Reply-To: <4FFF79B6.6040508@gmail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
 <4FF781D8.3040206@firmworks.com>
 <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
 <4FF7980E.7050705@firmworks.com>
 <alpine.LFD.2.02.1207090015270.31100@xanadu.home>
 <4FFE743B.6080504@firmworks.com> <4FFF34C9.8030000@gmail.com>
 <20120712233801.0411daa7@lilith>
 <20120712214743.2160B202A3F@gemini.denx.de>
 <4FFF79B6.6040508@gmail.com>
Message-ID: <20120713084526.5f680de3@lilith>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, 12 Jul 2012 20:28:22 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 07/12/2012 04:47 PM, Wolfgang Denk wrote:
> > Dear Albert ARIBAUD,
> > 
> > In message <20120712233801.0411daa7@lilith> you wrote:
> >>
> >> If I'm not mistaken, yes U-Boot loads itself as high as it can, and I don't
> >> know about the FDT, but no, U-Boot does not "like" to load initrd "just
> >> below that": it loads initrd where the boot commands tell it to, and the
> >> boot commands are written by board developers. Nothing in U-Boot forces
> >> initrd to be loaded as high as possible.
> 
> u-boot loads the initrd where you tell it, then bootm relocates it for
> some reason.
> >>
> >> That leaves the question of the FDT, though -- I'm not familiar enough
> >> with it (yet) to tell if it is always located just under U-Boot or if
> >> its placement is controllable by board commands.
> > 
> > You can always just set the "fdt_high" and "initrd_high" evironment
> > variables to restrict the positioning of initrd and FDT in RAM; see
> > the README for details.
> 
> Yes, I'm aware of all this, but this is not the default behavior and the
> default behavior will not work in this case. It also has another bug
> related to the relocation that I fixed:
> 
> http://www.mail-archive.com/u-boot at lists.denx.de/msg86475.html
> 
> Rob

As for the default behavior, this becomes a board config issue, not a
U-Boot issue.

Regarding the patch, as a bugfix it will go in u-boot-arm/master
for 2012.07.

With all this, do we have the overall issue covered?

Amicalement,
-- 
Albert.
