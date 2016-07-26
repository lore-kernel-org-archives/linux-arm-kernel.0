From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Jul 2016 11:20:18 +0100
Subject: [PATCH v2 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1467203656-14381-2-git-send-email-carlo@caione.org>
References: <1467203656-14381-1-git-send-email-carlo@caione.org>
 <1467203656-14381-2-git-send-email-carlo@caione.org>
Message-ID: <20160726102017.GA12241@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the delay.

I don't have any major comments, there are jsut a couple of minor
details.

> +config MESON_SM
> +	bool
> +	default ARCH_MESON
> +	depends on ARM64_4K_PAGES

It would be good to have a commentin the code as to why we depend on
ARM64_4K_PAGES.

That way it's possible for others to figure out without having to go
digging through mail archives and/or git logs.

[...]

> +struct meson_sm_chip gxbb_chip = {
> +	.shmem_size		= 0x1000,

If you include <linux/sizes.h>, you can use SZ_4K here.

Immediately above this is probably the best place for the comment
regarding the 4K page restriction imposed by the FW interface.

Other than that this looks fine, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
