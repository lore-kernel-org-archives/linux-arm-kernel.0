From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Feb 2015 18:44:58 +0900
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <7767301.zaEX63gvjp@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel>
 <20150219094155.GA3198@finisterre.sirena.org.uk>
 <7767301.zaEX63gvjp@wuerfel>
Message-ID: <20150221094458.GM6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 04:01:29PM +0100, Arnd Bergmann wrote:

> So the stubs are provided for all functions except device_reset() and
> reset_control_get(), and drivers using the API need to either call the
> stubbed-out _optional() versions of these functions or have the explicit
> dependency.

In that case a dependency seems wrong, I'd expect to see a select - it's
a bit obscure to have to grovel around to figure out what magic options
are needed to make things turn on and resets feel more like a utility
thing than a control bus (which tend to be the things we depend on).
Dunno, perhaps I'm wrong?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150221/865e5f2f/attachment-0001.sig>
