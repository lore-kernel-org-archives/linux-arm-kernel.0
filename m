From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 10 Apr 2017 12:12:03 +0200
Subject: [PATCH v4 2/2] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170408133245.30147-3-krzk@kernel.org>
References: <20170408133245.30147-1-krzk@kernel.org>
 <CGME20170408133346epcas2p1d015a5a590955524e98cfd1119414e21@epcas2p1.samsung.com>
 <20170408133245.30147-3-krzk@kernel.org>
Message-ID: <1713505.1UrJUbMZVN@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, April 08, 2017 03:32:45 PM Krzysztof Kozlowski wrote:
> Replace existing hw_ranndom/exynos-rng driver with a new, reworked one.
> This is a driver for pseudo random number generator block which on
> Exynos4 chipsets must be seeded with some value.  On newer Exynos5420
> chipsets it might seed itself from true random number generator block
> but this is not implemented yet.
> 
> New driver is a complete rework to use the crypto ALGAPI instead of
> hw_random API.  Rationale for the change:
> 1. hw_random interface is for true RNG devices.
> 2. The old driver was seeding itself with jiffies which is not a
>    reliable source for randomness.
> 3. Device generates five random 32-bit numbers in each pass but old
>    driver was returning only one 32-bit number thus its performance was
>    reduced.
> 
> Compatibility with DeviceTree bindings is preserved.
> 
> New driver does not use runtime power management but manually enables
> and disables the clock when needed.  This is preferred approach because
> using runtime PM just to toggle clock is huge overhead.
> 
> Another difference is reseeding itself with generated random data
> periodically and during resuming from system suspend (previously driver
> was re-seeding itself again with jiffies).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Stephan M?ller <smueller@chronox.de>
> Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
