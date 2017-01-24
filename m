From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 17:50:08 +0000
Subject: [PATCH] regulator: pfuze100: add supply name to regulators
In-Reply-To: <20170124165920.16309-1-l.stach@pengutronix.de>
References: <20170124165920.16309-1-l.stach@pengutronix.de>
Message-ID: <20170124175008.pryuc3saq4pcf3uj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 05:59:20PM +0100, Lucas Stach wrote:

> The devicetree binding states that the regulators are described by the
> generic regulator binding, so the input supply can just use the generic
> "vin" name.

No, there's no generic "vin" name.  The input name for the supply should
be the same as the input name that is specified in the datasheet for the
device so that these regulators are consistent with other devices and
it's easier for people to put together DTs for their systems without
having to guess what the driver author did with the supplies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/c9ff20a3/attachment.sig>
