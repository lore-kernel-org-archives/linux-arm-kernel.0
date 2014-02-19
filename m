From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:24:47 +0100
Subject: [Patch v3 20/23] ARM: config: Add a multi_v5_defconfig
In-Reply-To: <1392819548.815735822@f395.i.mail.ru>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
 <1392819174-11634-21-git-send-email-andrew@lunn.ch>
 <1392819548.815735822@f395.i.mail.ru>
Message-ID: <20140219142447.GA11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 06:19:08PM +0400, Alexander Shiyan wrote:
> ?????, 19 ??????? 2014, 15:12 +01:00 ?? Andrew Lunn <andrew@lunn.ch>:
> > To allow regression build testing of multi v5 systems, add a
> > multi_v5_defconfig, similar to the multi_v7_defconfig. This is based
> > on kirkwood_defconfig, but with a few other boards added which claim
> > to be MULTI_v5.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/configs/multi_v5_defconfig | 183 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> >  create mode 100644 arch/arm/configs/multi_v5_defconfig
> > 
> > diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
> ...
> > +CONFIG_DEBUG_LL=y
> > +CONFIG_DEBUG_MVEBU_UART_ALTERNATE=y
> > +CONFIG_DEBUG_UART_VIRT=0xfed12000
> 
> Should we disable lowlevel debug for multi-* config?

Yes. Otherwise we get silent crashes on anything but this specific
hardware. I will fix this in the next version.

Thanks
	  Andrew
