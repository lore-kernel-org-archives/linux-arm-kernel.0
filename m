From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 May 2015 11:18:57 +0100
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150521020709.GA14258@deathray>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
Message-ID: <20150521101857.GR21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 09:07:09PM -0500, Michael Welling wrote:

> My guess is that the set_cs needs to be called even when toggling as GPIO.

> How should I handle this?

It shouldn't be part of a set_cs() operation but rather part of the main
transfer operation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/ff2b1f09/attachment-0001.sig>
