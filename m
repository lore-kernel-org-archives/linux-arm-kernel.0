From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 15:05:54 -0800
Subject: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
In-Reply-To: <52F246CC.6070600@ti.com>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
 <52F0E098.3050404@ti.com> <52F104B7.6040606@ti.com>
 <52F2465A.6060804@ti.com> <52F246CC.6070600@ti.com>
Message-ID: <20140213230554.GI28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140205 06:15]:
> On Wed 05 Feb 2014 08:10:34 AM CST, Balaji T K wrote:
> >>>
> >>> Rather than ti,errata.. specific property, something like
> >>> caps no/disable multiblock read is more readable in my opinion, Otherwise
> >>
> >> Is'nt the better definition to state i have quirk X and allow the
> >> driver to do the necessary thing/things needed to handle quirk X? in
> >> this case, there is just one thing to do: broken multi_block_read, in
> >> the case of other quirks, there might be more than 1 thing to do.. let
> >> driver figure that out, dts just states the h/w capabilty or in this
> >> case, the quirk capability.
> >>
> >
> > But in this case there is only one. disable multi block read is more readable
> > than the errata reference, No strong feelings though.
> 
> Considering this might set an precedence for other quirk description, 
> I'd like to leave it as it stands.

Hmm if this really depends on the hardware version, how about
just add new compatible flag ti,omap3430-rev-xyz-hsmmc that
allows the driver to deal with the errata?

Regards,

Tony
