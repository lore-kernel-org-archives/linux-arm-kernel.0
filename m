From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Jun 2014 01:11:27 +0100
Subject: [PATCH] regmap: Add Kconfig option for debugfs register writes
In-Reply-To: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
References: <1403033795-9122-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140618001127.GC5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 09:36:35PM +0200, Markus Pargmann wrote:

> To enable writing of registers through the regmap debugfs interface, it
> was necessary to alter the regmap-debugfs.c source code. This is not
> really practical.

> As this is a powerful tool for debugging, this patch creates an expert
> kconfig option for this function. This makes it easier to enable
> register writing in the kernel.

This is deliberately hard to enable in order to make it clear that it
should never, ever be used in production as a bodge around writing
drivers and generally in order to reduce the risk to the rest of the
system.  Enabling this will typically give userspace full access to
components like PMICs which have the potential to cause physical damage
to the system if misused.

Anyone with a use for this is most likely building their own kernels
anyway and if a user modifies the code to enable it is clear that it is
their responsibility to deal with the fallout.

> This patch also fixes the file mode when the regmap debugfs write code is
> compiled.

Seperate changes in separate patches, especially don't put bugfixes in
the same patch as features.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/85db496e/attachment.sig>
