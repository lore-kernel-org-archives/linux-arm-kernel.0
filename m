From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Jun 2011 23:29:20 +0200
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform bus
	scan
In-Reply-To: <BANLkTimTdVKspjJ8GD4M90wiKCC0SzkgpA@mail.gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<4DE66E39.2070300@gmail.com>
	<BANLkTimTdVKspjJ8GD4M90wiKCC0SzkgpA@mail.gmail.com>
Message-ID: <201106012329.20651.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 June 2011, Grant Likely wrote:
> >
> > Shouldn't the hierarchy in linux reflect the h/w? It seems a bit pointless
> > to me to create a device just to create another device. amba_bus is already
> > a bit strange in that it is not really a bus type, but a certain class of
> > peripherals.
> >
> > I'd like to hear Grant's thoughts on this.
> 
> AMBA and platform_devices are "special" in that they don't have
> requirements on their parent device.  I see absolutely zero issue with
> having platform_device and amba_device as siblings.

Hmm, if we accept that platform and AMBA devices are just different from
all the others, maybe we can do a simpler solution and just hardcode that
difference in the of_platform_bus_create function. It probably doesn't
hurt if we grow a handful of these at most, as long as we wouldn't add
code for a lot of different bus types to the common probing function.

	Arnd
