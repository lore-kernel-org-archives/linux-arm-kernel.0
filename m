From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jun 2012 19:48:42 +0200
Subject: [PATCH 9/9] Kirkwood: Add basic device tree support for QNAP
 TS219.
In-Reply-To: <20120610172313.GA14756@titan.lakedaemon.net>
References: <1339324322-29388-10-git-send-email-andrew@lunn.ch>
 <20120610172313.GA14756@titan.lakedaemon.net>
Message-ID: <20120610174842.GA22507@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> > index 199764f..8c6a5cd 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -47,6 +47,7 @@ config MACH_GURUPLUG
> >  config ARCH_KIRKWOOD_DT
> >  	bool "Marvell Kirkwood Flattened Device Tree"
> >  	select USE_OF
> > +	select SERIAL_OF_PLATFORM
> 
> Please remove as previously discussed.  I'm in the process of updating
> kirkwood_defconfig (it will include this).  Thanks.

No problems. I just got bitten by this too many times...

It would be good if all the DT boards where compiled all the time.  We
can then see build failures in kisskb.

    Andrew
