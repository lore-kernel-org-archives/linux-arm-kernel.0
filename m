From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 20 Jun 2015 21:35:53 +0200
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <20150620173421.GJ2936@io.lakedaemon.net>
References: <1434765234.5177.25.camel@dolka.fr>
 <20150620173421.GJ2936@io.lakedaemon.net>
Message-ID: <20150620213553.1b6b7ae2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Sat, 20 Jun 2015 17:34:21 +0000, Jason Cooper wrote:

> >  config MACH_LINKSTATION_MINI
> > -	bool "Buffalo Linkstation Mini"
> > -	select I2C_BOARDINFO
> > +	bool "Buffalo Linkstation Mini (Flattened Device Tree)"
> > +	select ARCH_ORION5X_DT
> >  	help
> >  	  Say 'Y' here if you want your kernel to support the
> > -	  Buffalo Linkstation Mini platform.
> > +	  Buffalo Linkstation Mini (LS-WSGL) platform.
> 
> Hmmm, this question is for the other mvebu maintainers:  When we
> originally converted kirkwood and dove, we put a lot of effort into
> keeping the board files and the dts files around in parallel for a
> while.  Do we need to do that here?  All the drivers are converted, so
> we don't need to keep the legacy board files for that reason.
> 
> I'm not sure it's necessary myself, but I'm thinking it might be a good
> idea on general principal to deprecate the board file over time.
> Thoughts?

I don't think it's necessary to keep both the DT and legacy versions
around. If the DT conversion is as functional as the legacy one (even
if it requires doing some legacy probing of certain devices that don't
yet have a DT binding), then there is no point in keeping the legacy
board file.

There is only one board for which I've kept both the DT and legacy
versions: the rd88f5182. That's because it's a board I have, and
keeping both the DT and legacy versions allowed me to make sure that
legacy booting is not broken by the progressive conversion do DT for
other boards.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
