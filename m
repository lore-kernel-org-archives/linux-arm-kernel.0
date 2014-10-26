From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 26 Oct 2014 17:54:18 +0100
Subject: [PATCHv0] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <20141025221611.GA14620@lunn.ch>
References: <3d0cc6de9ea5506d5fb201129ad277e57d0cdfc8.1414268057.git.arno@natisbad.org>
 <20141025221611.GA14620@lunn.ch>
Message-ID: <17414879.SyK2RFgsXQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 26 October 2014 00:16:11 Andrew Lunn wrote:
> Hi Arnaud
> 
> Nice to see another device supported.
> 
> > - When I bought the NAS, it had an old Marvell bootloader. After install
> >   of latest DSM version, the u-boot was a new one w/ I had to change the
> >   'ranges' in the .dts to the ones below to have the kernel boot. I guess
> >   new DS213j hardware will be shipped with new u-boot version at some
> >   point and this will be fine; Otherwise, users will either have to
> >   upgrade their DSM or manually s/1f/d0/ in .dts.
> 
> Marvell have made a real mess here. Since there seems to be two
> different base addresses in use, i suggest you put a fat comment on
> the top of the .dts file about this issue. Give users a clue what to
> try if the kernel does not do anything at all.
> 

Maybe it's better to have multiple dtb files in this case.
It should be trivial to have one .dts file that just overrides the
one address.

	Arnd
