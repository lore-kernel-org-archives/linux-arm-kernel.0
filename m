From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Mar 2011 23:14:19 +0000
Subject: Updated mach-types update
In-Reply-To: <AANLkTi=0o3y7sPFjcmW0OLyPuZ8+DQNggpH7VRDd9Q-R@mail.gmail.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<AANLkTi=0o3y7sPFjcmW0OLyPuZ8+DQNggpH7VRDd9Q-R@mail.gmail.com>
Message-ID: <20110326231419.GA29422@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 26, 2011 at 03:52:04PM -0700, Colin Cross wrote:
> This breaks master with CONFIG_PCI=y:
>   CC      arch/arm/kernel/bios32.o
> arch/arm/kernel/bios32.c: In function 'pci_fixup_prpmc1100':
> arch/arm/kernel/bios32.c:174: error: implicit declaration of function
> 'machine_is_prpmc1100'
> 
> I can't tell what the right fix is.  Deleting pci_fixup_prpmc1100
> fixes it.  There is no machine for prpmc1100, but there is
> CONFIG_ARCH_PRPMC1100 that enables machine IXCDP1100 in
> arch/arm/mach-ixp4xx/ixdp425-setup.c.  Should bios32.c be using
> machine_is_ixcdp1100?  The history is all pre-git.

http://linux.bkbits.net:8080/linux-2.6/?PAGE=cset&REV=40a29db2qiY8UR8FWw0U1i4DgOLsRA

Looks like Deepak submitted it as part of the IXP4xx stuff.  However,
prpmc1100-pci.c no longer exists... but can be found:

http://linux.bkbits.net:8080/linux-2.6/BitKeeper/deleted/.del-prpmc1100-pci.c~da88e9014dd6125b?PAGE=related

which lead to:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=2448%2F1

So, your patch below looks like the right thing.
