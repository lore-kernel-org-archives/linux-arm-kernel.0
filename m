From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 11:43:55 +0100
Subject: [PATCH 04/20] regmap: Do not skip format initialization
In-Reply-To: <1439374365-20623-5-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812104355.GS10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:29PM +0200, Markus Pargmann wrote:

> It is not obvious why format initialization is skipped here. format
> functions are used for example in regmap_bulk_read even if bus is not
> set. So they are used even if skipped here which leads to null pointer
> errors.

> This patch adds format initialization for !bus and !bus->read/write.

Format initialisation is skipped because it is not clear what the wire
format actually is if we're not using the regmap internal marshalling.
Someone needs to do a survey of what the existing users are trying to do
before changing anything here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/6e232e0c/attachment.sig>
