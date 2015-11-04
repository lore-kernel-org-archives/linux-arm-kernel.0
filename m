From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 09:56:25 +0100
Subject: [PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <BN3PR0301MB08675CC568518D2ACA752757FE2A0@BN3PR0301MB0867.namprd03.prod.outlook.com>
References: <1445956507-34026-1-git-send-email-b18965@freescale.com>
 <20151103143416.GA926@cbox>
 <BN3PR0301MB08675CC568518D2ACA752757FE2A0@BN3PR0301MB0867.namprd03.prod.outlook.com>
Message-ID: <8043581.ZAA0nqeSU3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 November 2015 03:17:06 Huan Wang wrote:
> > On Tue, Oct 27, 2015 at 10:35:07PM +0800, Alison Wang wrote:
> > > v7 LPAE multi-platform defconfig is based on v7 multi-platform
> > > defconfig and adds LPAE support.
> > >
> > > This defconfig is verified on LS1021A which enables GIANFAR, I2C,
> > > WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
> > >
> > > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> > 
> > I think this would be great if it also had:
> > 
> > CONFIG_ARCH_VIRT=y
> > CONFIG_VIRTUALIZATION=y
> > CONFIG_KVM=y
> > 
> > That would allow it to be used for KVM testing both as host and guest.
> > 
> > FWIW, I just tried booting this on my TC2, but I don't get any output
> > from there.  Is it supposed to work on this platform?  If not, why not?
> > 
> [Alison Wang] One question, does TC2 support LPAE? If so, we could try to
> find the reason and add it in this defconfig for armv7 LPAE support.

Yes, I think we should enable all platforms that we enable in the normal
multi_v7_defconfig, if we decide to add a new one. Just remove the platforms
that are based on Cortex-A5/A8/A9, Scorpion or PJ4 rather than A7/A12/A15/A17
or Krait.

	Arnd
