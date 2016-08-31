From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 31 Aug 2016 16:44:38 -0700
Subject: [PATCH] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <20160829153242.18615-1-kbeldan@baylibre.com> (Karl Beldan's
 message of "Mon, 29 Aug 2016 15:32:42 +0000")
References: <20160829153242.18615-1-kbeldan@baylibre.com>
Message-ID: <7h37lk5wrd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Beldan <kbeldan@baylibre.com> writes:

> This adds DT support for the NAND connected to the SoC AEMIF.
> Passed torture hashing a 40MB file on top of UBIFS using subpages.
>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> ---
> v2:
>
> - Removed comments pertaining to the BSP the LCDK ships with (Sekhar)
> - s/"ok"/"okay"/
> - Removed partitions since it relates to the BSP the LCDK ships with

IMO, some default partitions are nice to have, at least for u-boot and
u-boot env so factory-shipped u-boot is not accidentally overridden.
The left over space can be labeled "free space".

Anyways, after adding some partitions back, I tested with ubifs on my
LCDK:

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
