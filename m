From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 21:59:51 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <5669CC76.4030606@vollmann.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <27901501.7xKhhTyrKu@wuerfel> <5669CC76.4030606@vollmann.ch>
Message-ID: <1802654.n0lYxNZ2px@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 20:03:18 Detlef Vollmann wrote:
> On 12/10/15 14:43, Arnd Bergmann wrote:
> > On Thursday 10 December 2015 14:18:11 Arnd Bergmann wrote:
> >> On Thursday 10 December 2015 13:56:05 Detlef Vollmann wrote:
> 
> >>> The bad news:
> >>> My own config (which is massivly stripped down) produces a kernel
> >>> image that's more than 26K bigger than on v4.4-rc3 without any
> >>> added functionality.
> >>> The DNS-323 is extremly constrained in space (the whole system
> >>> including boot loader, kernel and filesystem has to fit into 8M flash).
> >>> Any ideas how I can get rid of this additional overhead?
> >>
> >> Can you send me your config file? I can have a look.
> >>
> > 
> > I've done a quick check with an allnoconfig-like test and it seems that
> > CONFIG_OF is weighing in at around 86K here, with all the other options
> > it pulls in, comparing an allnoconfig kernel for DS-323 with one that
> > has CONFIG_OF enabled as well.
> > 
> > The multiplatform kernel also enables CONFIG_OF unconditionally, but is
> > otherwise a little smaller than the mach-orion5x based one:
> > 
> >    text    data     bss     dec     hex filename
> >  942144   64112   17648 1023904   f9fa0 build/tmp/vmlinux-orion-allno
> > 1027516   54052   20824 1102392  10d238 build/tmp/vmlinux-multi-plus-orion
> > 1025320   66020   18744 1110084  10f044 build/tmp/vmlinux-orion-plus-of
> > 
> > The diff below shows all the differences between orion-allno and
> > multi-plus-orion.
> How did you get the orion-allno config and how did you get it compiled?
> I tried to apply your changes to my config and compile it, but
> it started silentoldconfig which introduced back 'ARCH_MULTIPLATFORM'

The first and third row are without my patches, once they are applied,
ARCH_ORION becomes a sub-option of ARCH_MULTIPLATFORM.

	Arnd
