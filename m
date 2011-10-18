From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 18 Oct 2011 12:28:57 -0700
Subject: [PATCH] [3.3] ARM: tegra: use APB DMA for accessing APB devices
In-Reply-To: <CAOesGMh8mFTkOgHwT-1HTA+XMdo36husYzwWOymL1CBz-mGiiA@mail.gmail.com>
References: <1318961898-21254-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CC0C@HQMAIL01.nvidia.com>
	<CAOesGMh8mFTkOgHwT-1HTA+XMdo36husYzwWOymL1CBz-mGiiA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173CA2CC41@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, October 18, 2011 1:12 PM:
>...
> Also, I can't imagine a case where CONFIG_TEGRA_SYSTEM_DMA makes sense
> to keep off. Can you? If so, I'm tempted to just kill it (in a
> separate patch).

I wondered about that too when I first saw that config option.

Still, I don't think it's impossible to have a system where the DMA driver
isn't useful; looking across a few kernels, I see it being used for:

* Audio; I2S and SPDIF, not HD-audio
* SPI (master and slave)
* The tegra_hsuart driver (not sure what benefit that has over 8250.c...)
* This APB/fuse/DMA workaround

All of which seem optional given the fourth one isn't required if DMA
isn't used.

-- 
nvpublic
