From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Oct 2015 13:50:26 +0100
Subject: next-20151013 build: 1 failures 50 warnings (next-20151013)
In-Reply-To: <E1ZlxDc-0000ea-U4@optimist>
References: <E1ZlxDc-0000ea-U4@optimist>
Message-ID: <20151013125026.GG14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 11:54:09AM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:30: error: macro "DIV_ROUND_UP" requires 2 arguments, but only 1 given
> ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:4: error: 'DIV_ROUND_UP' undeclared (first use in this function)

triggered by f6e734a8c16229 (MIPS: BCM47xx: Move NVRAM driver to the
drivers/firmware/).  Presumably this works due to an implicit inclusion
on MIPS.

I've CCed a lot of people listed in the changelog of the patch, though
the list there appears somewhat random - apologies if this is irrelevant
to you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/3c3ac2ef/attachment.sig>
