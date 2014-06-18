From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Jun 2014 23:01:59 +0200
Subject: [PATCH] regmap: Add Kconfig option for debugfs register writes
In-Reply-To: <20140618001127.GC5099@sirena.org.uk>
References: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
 <20140618001127.GC5099@sirena.org.uk>
Message-ID: <20140618210159.GC32450@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 01:11:27AM +0100, Mark Brown wrote:
> On Tue, Jun 17, 2014 at 09:36:35PM +0200, Markus Pargmann wrote:
> 
> > To enable writing of registers through the regmap debugfs interface, it
> > was necessary to alter the regmap-debugfs.c source code. This is not
> > really practical.
> 
> > As this is a powerful tool for debugging, this patch creates an expert
> > kconfig option for this function. This makes it easier to enable
> > register writing in the kernel.
> 
> This is deliberately hard to enable in order to make it clear that it
> should never, ever be used in production as a bodge around writing
> drivers and generally in order to reduce the risk to the rest of the
> system.  Enabling this will typically give userspace full access to
> components like PMICs which have the potential to cause physical damage
> to the system if misused.

The userspace already has full access to all those registers if you
want. For example memory mapped registeres can be written through
/dev/mem. I2C registers can easily be changed using i2c-tools or the
/dev/i2c-* devices. So you are already able to write a userspace driver
if you really want to.

I think this kconfig option would make it easier to debug hardware or
driver issues, as it is much more comfortable to have a clean kconfig
option.

> 
> Anyone with a use for this is most likely building their own kernels
> anyway and if a user modifies the code to enable it is clear that it is
> their responsibility to deal with the fallout.
> 
> > This patch also fixes the file mode when the regmap debugfs write code is
> > compiled.
> 
> Seperate changes in separate patches, especially don't put bugfixes in
> the same patch as features.

Ok, I will split this to a seperate patch

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/bb6e745d/attachment.sig>
