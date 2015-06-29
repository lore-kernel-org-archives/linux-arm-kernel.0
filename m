From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jun 2015 18:15:41 +0100
Subject: next-20150629 build: 1 failures 74 warnings (next-20150629)
In-Reply-To: <E1Z9WQC-000356-Bd@optimist>
References: <E1Z9WQC-000356-Bd@optimist>
Message-ID: <20150629171541.GK11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 11:36:17AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> ../drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared (first use in this function)

which is introduced by "watchdog: omap_wdt: early_enable module
parameter" which adds the above reference to a nonexistant variable.
Presumably the patch was generated against something sufficiently old to
lack "watchdog: omap: put struct watchdog_device into driver data" which
appears to be where it was removed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/b636df07/attachment.sig>
