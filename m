From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 10:54:53 +0200
Subject: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <20140424114403.GN12304@sirena.org.uk>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <20140424114403.GN12304@sirena.org.uk>
Message-ID: <20140428085453.GC15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 24, 2014 at 12:44:03PM +0100, Mark Brown wrote:
> On Mon, Apr 14, 2014 at 03:35:30PM +0200, Markus Pargmann wrote:
> 
> > This series is a cleanup of the fsl-ssi driver.
> 
> There's been some review comments on this series but only negative ones
> and I've not seen any testing reports either.  Are the other patches OK
> for people?
> 
> > There is no DT binding for regmap yet, as this should be solved in the regmap
> > framework first. The current configuration should at least work on the same
> > SoCs it was previously used. As soon as we have a common DT binding to set the
> > endianess we replace it in this driver.
> 
> I'm really not convinced that this is a good idea to be frank - I would
> expect devices to still need to be involved to set defaults.

What do you think of some framework function like
of_regmap_parse_endianess()? This would offer a common devicetree
binding and the driver would still be involved.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/552d42ae/attachment.sig>
