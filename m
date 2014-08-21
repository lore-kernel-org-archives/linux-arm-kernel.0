From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Aug 2014 13:20:35 -0500
Subject: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
In-Reply-To: <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140821182035.GM24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 06:25:06PM +0300, Grygorii Strashko wrote:

> +- ti,davinci-spi-wdelay : delay between transmissions.

I don't understand why this is here - there is already standard support
in the SPI core for client drivers specifying inter-transfer delays.  If
there is a need to provide platform configuration for this in addition
to that then it should also be a standard property, there is nothing
device specific about these.

> +- ti,davinci-spi-odd-parity : odd partity enabled
> +   OR
> +  ti,davinci-spi-even-parity : even parity enabled

What do these mean?

> +- ti,davinci-spi-io-type: io type (check platform_data/spi-davinci.h)

The bindings should be independent of the kernel, the values need to be
included here (and the defines moved to include/dt-bindings so they can
be used when writing DTs).

> +- ti,davinci-spi-disable-timer: disable CS timer (SPIFMTn)
> +- ti,davinci-spi-c2t-delay: c2t delay
> +- ti,davinci-spi-t2c-delay: t2c delay
> +- ti,davinci-spi-t2e-delay: t2e delay
> +- ti,davinci-spi-c2e-delay: c2e delay

What are all these timers/delays - at least some reference to the
datasheet please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/09a45eb3/attachment.sig>
