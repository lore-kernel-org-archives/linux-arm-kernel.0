From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Sep 2014 22:21:43 +0100
Subject: [PATCH] RFC: add function for localbus address
In-Reply-To: <540E1014.8090102@codeaurora.org>
References: <540E1014.8090102@codeaurora.org>
Message-ID: <20140908212143.GN2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:22:44PM -0700, Stephen Boyd wrote:

> Where is this described? From the commit text that introduces
> IORESOURCE_REG I see:

> "Currently a bunch of I2C/SPI MFD drivers are using IORESOURCE_IO for
> register address ranges. Since this causes some confusion due to the
> primary use of this resource type for PCI/ISA I/O ports create a new
> resource type IORESOURCE_REG."

> And the comment next to the #define says "Register offsets". I don't see
> anywhere where it mentions these are CPU addresses. Certainly the
> current IORESOURCE_REG users aren't CPU addresses because they're
> SPI/I2C device drivers.

Right, the intention was specifically to handle things where
IORESOURCE_MEM wasn't appropriate as it wasn't ever going to be memory
mapped I/O and should be in a separate address space.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/72d85d51/attachment.sig>
