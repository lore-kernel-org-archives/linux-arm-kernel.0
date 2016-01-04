From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 16:50:25 +0000
Subject: next-20160104 build: 3 failures 15 warnings (next-20160104)
In-Reply-To: <E1aG3zo-0000gt-2t@optimist>
References: <E1aG3zo-0000gt-2t@optimist>
Message-ID: <20160104165025.GN16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 12:12:20PM +0000, Build bot for Mark Brown wrote:

Today's linux-next fails to build an arm allmodconfig (and probably also
at least arm64 though other errors prevent that getting to linking
currently) due to:

| drivers/built-in.o: In function `dtsec_restart_autoneg':
| :(.text+0x30f86c): undefined reference to `mdiobus_read'
| :(.text+0x30f89c): undefined reference to `mdiobus_write'
| drivers/built-in.o: In function `dtsec_init':
| :(.text+0x31008c): undefined reference to `mdiobus_write'
| :(.text+0x3100b4): undefined reference to `mdiobus_write'
| :(.text+0x3100dc): undefined reference to `mdiobus_write'
| :(.text+0x310128): undefined reference to `mdiobus_write'
| drivers/built-in.o::(.text+0x310150): more undefined references to `mdiobus_write' follow
| drivers/built-in.o: In function `dtsec_config':
| :(.text+0x310804): undefined reference to `of_phy_find_device'

and various other linker errors caused by the fact that the new fman
driver uses PHYLIB but does not depend on or select it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/187e4c0e/attachment.sig>
