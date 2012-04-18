From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 08:10:02 +0000
Subject: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
In-Reply-To: <20120418054615.GB17506@avionic-0098.adnet.avionic-design.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-8-git-send-email-stigge@antcom.de>
 <20120418054615.GB17506@avionic-0098.adnet.avionic-design.de>
Message-ID: <201204180810.02561.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Thierry Reding wrote:
> [...]
> > +                     /*
> > +                      * MIC Interrupt controller includes:
> > +                      *   MIC @40008000
> > +                      *   SIC1 @4000C000
> > +                      *   SIC2 @40010000
> > +                      */
> > +                     mic: interrupt-controller at 40008000 {
> > +                             compatible = "nxp,lpc32xx-mic";
> > +                             interrupt-controller;
> > +                             interrupt-parent;
> 
> I think in this case you can leave this out. At least there doesn't seem to
> be any other such usage in the tree.
> 

It's actually a bug and we're removing all empty "interrupt-parent"
properties from the dts files now because they cause problems. Please don't
introduce new ones.

	Arnd
