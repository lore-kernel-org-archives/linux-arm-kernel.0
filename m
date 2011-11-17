From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 17 Nov 2011 13:50:13 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111116175757.GI2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>
 <1321461315.3137.371.camel@hornet.cambridge.arm.com>
 <20111116175757.GI2073@localhost.localdomain>
Message-ID: <1321537813.3137.475.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 17:57 +0000, Dave Martin wrote:
> > > We should specify a list of all the "standard" aliases used by the
> > > generic motherboard code here, since these are part of the contract
> > > between each board-specific device tree and the motherboard code.
> > > 
> > > Is "timer" the only one, or are there others?
> > 
> > One and only. There were more, but I got rid of them.
> 
> Are the other alises still used?  If not, we should perhaps get rid of
> them, or keep them on an as-needed basis only?

I've included the serialX and i2cX aliases purely because the other
boards do (including Grant's versatile dts).

> Since alises are by definition a point of standardisation (otherwise
> there's no need for an alias) I think they need to be documented alongside
> bindings wherever we have them.

You are right, but I think this is out of the vexpress scope. The
serialX aliases, for example, are already used by some drivers:

   4   1788  drivers/tty/serial/atmel_serial.c <<atmel_serial_probe>>
             ret = of_alias_get_id(np, "serial");
   5   1301  drivers/tty/serial/imx.c <<serial_imx_probe_dt>>
             ret = of_alias_get_id(np, "serial");

so it sounds like a generic policy-to-be-made.

> > > For "non-interactive" config items, can we still please have comments
> > > indicating what the item means and how it should be used?
> > > 
> > > Such comments can be very brief, but having at least something makes the
> > > configs easier to understand and maintain, in my view.
> > 
> > Em, what bits do you refer to? The lines you quoted are not changed...
> 
> Hmmm, editing snafu there.
> 
> I think I was referring to the ARCH_VEXPRESS_DT item, which is defined
> just after the lines I quoted.

Ok, will do.

Cheers!

Pawe?
