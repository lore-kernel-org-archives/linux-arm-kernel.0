From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 17:54:16 +0200
Subject: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
In-Reply-To: <20140930154201.GR841@e106497-lin.cambridge.arm.com>
References: <706416181.hbVGLDA3o6@wuerfel> <2033939.5UfzeSiRKs@wuerfel>
 <20140930154201.GR841@e106497-lin.cambridge.arm.com>
Message-ID: <2735967.fhQeZkXvnj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 16:42:02 Liviu Dudau wrote:
> On Tue, Sep 30, 2014 at 04:15:19PM +0100, Arnd Bergmann wrote:
> > On Tuesday 30 September 2014 15:45:06 Liviu Dudau wrote:
> > > 
> > > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > 
> > > Is that triggered by shmobile_defconfig?
> > > 
> > > 
> > 
> > No, I only found it using randconfig testing, shmobile enables CONFIG_OF by
> > default.
> 
> Hmm, I was looking at who defines CONFIG_PCI_RCAR_GEN2_PCIE and it's only
> present in shmobile_defconfig, but that one does not select any OF options (other
> than CONFIG_ARM_APPENDED_DTB). So there is no way of triggering this other
> than by randconfig?

It should be easy enough to build a kernel without CONFIG_OF that enables
this driver manually on another platform.

	Arnd
