From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 13:39:23 +0100
Subject: [PATCH 10/20] regmap: _regmap_raw_multi_reg_write: Add
 reg_write() support
In-Reply-To: <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-11-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812123923.GI10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:35PM +0200, Markus Pargmann wrote:
> Define a fallback for busses which do not define a write() function.
> Instead we write one register at a time using reg_write().
> 
> Without this patch, _regmap_raw_multi_reg_write would break as it tries
> to call bus->write() without checking if it exists before.

Why are we trying to use multi write APIs in the first place if we can't
do raw I/O?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/59a4ff51/attachment.sig>
