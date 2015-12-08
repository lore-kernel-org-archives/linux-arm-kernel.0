From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Dec 2015 16:37:39 +0000
Subject: [PATCH] regulator: add regulator_sync_voltage inline dummy
In-Reply-To: <1983152.2iYiBkp4xd@wuerfel>
References: <1983152.2iYiBkp4xd@wuerfel>
Message-ID: <20151208163739.GS5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 04:43:35PM +0100, Arnd Bergmann wrote:

> This modifies the API header so we provide a static inline function
> with the same prototype as the normal function of this name. This matches
> what we do for all other regulator API functions and avoids the build
> error.

We don't do this for *all* regulator API functions - there's some where
using them strongly suggests that there is actually a dependency on the
regulator API.  This does seem like it might be falling into the
specialist category...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/488de195/attachment.sig>
