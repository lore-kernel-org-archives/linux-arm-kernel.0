From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jan 2014 21:00:57 +0100
Subject: [PATCH 6/6] at91: dt: sam9261: Added DM9000 in the device tree
In-Reply-To: <CACh+v5PptkrXERAqBUOv-DSaRDQ5NzJAc919Ne3iN9iVszRP+A@mail.gmail.com>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
 <4526077.qASk8HSHKP@wuerfel>
 <CACh+v5PptkrXERAqBUOv-DSaRDQ5NzJAc919Ne3iN9iVszRP+A@mail.gmail.com>
Message-ID: <1460399.vQDGWoVpz2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014 20:31:00 Jean-Jacques Hiblot wrote:
> > If each bus interface has a fixed range of registers, you can actually
> > collapse the upper two nodes again and just have one device per
> > chipselect.
> This is indeed the case, but I'd rather keep the top node to highlight
> the fact that all the devices are physically tied to the same bus.

How about using a top-level "simple-bus" node with the complex ranges
property but making the driver match the sub-devices with the smaller
register range then?

	Arnd
