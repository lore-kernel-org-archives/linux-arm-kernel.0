From: pekon@ti.com (Gupta, Pekon)
Date: Fri, 5 Jul 2013 08:04:31 +0000
Subject: SPI: DUAL/QUAD support
In-Reply-To: <20130705073550.GA24258@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
 <20130704154927.GE27646@sirena.org.uk>
 <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E4C2E@DBDE04.ent.ti.com>
 <20130705073550.GA24258@sig21.net>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E4C7D@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > [Pekon]: Does below generic framework for spianand, suit your driver?
> > http://lists.infradead.org/pipermail/linux-mtd/2013-July/047434.html
> >
> > you should be able to extend the generic spinand API for all
> > serial modes (SPI, Dual-SPI, Quad-SPI).
> > As QSPI and Dual-SPI devices should implicitly support SPI (MISO/MOSI)
> > So, you can do device probing using default SPI mode. And then based on
> > DT inputs and device support upgrade to QSPI / Dual-SPI mode.
> > And going forward extend it for direct memory-mapped device for XIP.
> 
> Not sure what you have in mind since NAND and NOR flash work very
> differently, and SPI vs. memory-mapped is also very different.
> 
[Pekon]:  Opps.. Sorry for NAND v/s NOR confusion,
But I found generic framework for SPINAND (not in mainline) helpful
for us, so I pointed that..
I'm not sure about your end use-case, but I our QSPI controller supports
direct memory-addressable cpu-side bus-interface which can be enabled
for XIP support. So pointed out that here as-well..


> But to add to the spinand review comments two things caught
> my eye on quick glance over the code:
> 
> > +#define mu_spi_nand_driver_version "Beagle-
> MTD_01.00_Linux2.6.33_20100507"
> 
> seems like an unused leftover?  if the version number is
> important then maybe better put it in commit message?
> 
> > +/bin/bash: 4: command not found
> 
> how did this get in there?
> 
[Pekon]: Thanks.. Sourav needs to clean this up lot more.

with regards, pekon
