From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri, 3 Jun 2016 11:07:58 +0200
Subject: [PATCH 1/3] char: hw_random: Add Amlogic Meson Hardware Random
 Generator
In-Reply-To: <1464943621-18278-2-git-send-email-narmstrong@baylibre.com>
References: <1464943621-18278-1-git-send-email-narmstrong@baylibre.com>
 <1464943621-18278-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160603090758.GA7299@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have some minor comments below

> +config HW_RANDOM_MESON
> +	tristate "Amlogic Meson Random Number Generator support"
> +	depends on HW_RANDOM && ARCH_MESON

Perhaps you could change to:
depends on HW_RANDOM
depends on ARCH_MESON || COMPILE_TEST

> +
> +static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
> +{
> +	struct meson_rng_data *data =
> +			container_of(rng, struct meson_rng_data, rng);
> +
> +	*(u32 *)buf = readl_relaxed(data->base + RNG_DATA);
> +
> +	return sizeof(u32);
> +}

I think you need a test for max < sizeof(u32)

Regards

LABBE Corentin
