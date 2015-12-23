From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Dec 2015 11:58:38 +0000
Subject: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
In-Reply-To: <1450871420.2648.6.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-4-git-send-email-contact@paulk.fr>
 <20151223114126.GR16023@sirena.org.uk>
 <1450871420.2648.6.camel@collins>
Message-ID: <20151223115838.GT16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 12:50:20PM +0100, Paul Kocialkowski wrote:
> Le mercredi 23 d?cembre 2015 ? 11:41 +0000, Mark Brown a ?crit :

> > I would expect the driver at least needs to know how the pins or
> > strapped, or otherwise have configuration for ignoring the input on the
> > pins.  This just deletes the warnings, it doesn't have any handling for
> > this case that I can see.

> When the DVS GPIO is invalid, lp872x_init_dvs jumps to the
> set_default_dvs_mode label, which instructs the chip not to use the DVS
> pin at all and do it all in software instead (by clearing the
> LP8720_EXT_DVS_M bit in the LP872X_GENERAL_CFG register).

> That is reflected later in the code, when setting the bucks (the DVS pin
> only applies to the bucks) by checking for the LP8720_EXT_DVS_M bit on
> the LP872X_GENERAL_CFG register (in lp872x_select_buck_vout_addr) to
> decide whether to use software or hardware DVS selection.

> As far as I understood, everything goes well when the GPIO is invalid.

So please put this analysis in the changelog so that the changelog
accurately reflects what the change is doing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/acf0cc3a/attachment.sig>
