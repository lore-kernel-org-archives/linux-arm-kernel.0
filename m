From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 29 Apr 2014 19:19:23 +0300
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
In-Reply-To: <20140429150529.GA27571@atomide.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
 <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com>
 <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com>
 <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com>
 <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com>
Message-ID: <535FD10B.4020108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/14 18:05, Tony Lindgren wrote:

>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just gives
>> a raw regmap to its memory area, the driver needs to know about the OMAP
>> control registers to use it.
> 
> That would be probably best set up the same way we have already set up
> for example omap4_padconf_global: tisyscon at 4a1005a0. Then drivers can
> access it using regmap, see how drivers/regulator/pbias-regulator.c
> sets up the pbias regulator with regmap for MMC.

Right, but it means that the driver will contain platform specific code
for all the omap revisions it supports. Isn't that wrong?

I already have a patch for DSI that uses the syscon-method, and it works
fine. But it's quite ugly, imo, to fiddle with the OMAP control
registers in a driver.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/ec3a6b0c/attachment.sig>
