From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 Aug 2015 20:41:29 +0200
Subject: [PATCH v2 05/21] ARM: pxa: magician: Add support for ADS7846
 touchscreen
In-Reply-To: <55D2591F.10509@tul.cz> (Petr Cvek's message of "Mon, 17 Aug 2015
 23:58:55 +0200")
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D2591F.10509@tul.cz>
Message-ID: <87twrv6rza.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Add support for ADS7846 touchscreen.
> +
> +static struct pxa2xx_spi_master magician_spi_info = {
> +	.num_chipselect = 1,
> +/*	.enable_dma = 1, */ /* FIXME probably unnecessary */
That's up to you. If almost nothing transits on SPI then a DMA is not necessary.

I'll leave that one for a week for others to further comment.

Cheers.

--
Robert
