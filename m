From: wd@denx.de (Wolfgang Denk)
Date: Thu, 12 Jul 2012 23:47:43 +0200
Subject: [U-Boot] Where to put a large bootloader-supplied device tree on
 ARM ?
In-Reply-To: <20120712233801.0411daa7@lilith>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <201207051454.24475.arnd@arndb.de> <20120705161600.GA28860@lunn.ch>
 <201207062008.23952.arnd@arndb.de> <20120706210009.GC11470@lunn.ch>
 <4FF781D8.3040206@firmworks.com>
 <2966DB01BC317A4DA23684BA0F653415013701@xmb-aln-x08.cisco.com>
 <4FF7980E.7050705@firmworks.com>
 <alpine.LFD.2.02.1207090015270.31100@xanadu.home>
 <4FFE743B.6080504@firmworks.com> <4FFF34C9.8030000@gmail.com>
 <20120712233801.0411daa7@lilith>
Message-ID: <20120712214743.2160B202A3F@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Albert ARIBAUD,

In message <20120712233801.0411daa7@lilith> you wrote:
> 
> If I'm not mistaken, yes U-Boot loads itself as high as it can, and I don't
> know about the FDT, but no, U-Boot does not "like" to load initrd "just
> below that": it loads initrd where the boot commands tell it to, and the
> boot commands are written by board developers. Nothing in U-Boot forces
> initrd to be loaded as high as possible.
> 
> That leaves the question of the FDT, though -- I'm not familiar enough
> with it (yet) to tell if it is always located just under U-Boot or if
> its placement is controllable by board commands.

You can always just set the "fdt_high" and "initrd_high" evironment
variables to restrict the positioning of initrd and FDT in RAM; see
the README for details.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
"He was so narrow minded he could see through  a  keyhole  with  both
eyes ..."
