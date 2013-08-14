From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 14 Aug 2013 09:04:24 -0700
Subject: [GIT PULL] Highbank fixes for 3.12
In-Reply-To: <520AF2ED.9030900@gmail.com> (Rob Herring's message of "Tue, 13
 Aug 2013 22:01:01 -0500")
References: <520AF2ED.9030900@gmail.com>
Message-ID: <87li4445tj.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Rob Herring <robherring2@gmail.com> writes:

> Kevin, Olof,
>
> Please pull highbank updates for 3.12.
>
> There's one trivial core ARM code change in the series to allow a
> DMA_ZONE size of 4GB. I believe this should not conflict with Russell's
> DMA mask series.
>
> Rob
>
> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>
>   Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>
> are available in the git repository at:
>
>   git://sources.calxeda.com/kernel/linux.git
> tags/highbank-lpae-fixes-for-3.12
>
> for you to fetch changes up to ce3ec1d61c5ed6af3ceaace6f57acd588c41b4d6:
>
>   ARM: highbank: fix debug uart virtual address for LPAE (2013-08-13
> 20:50:16 -0500)
>
> ----------------------------------------------------------------
> A set of fixes for highbank to enable LPAE and selecting of necesssary
> ARM errata.
>
> ----------------------------------------------------------------
> Rob Herring (6):
>       ARM: use phys_addr_t for DMA zone sizes
>       ARM: highbank: enable DMA zone for LPAE
>       ARM: highbank: select ARCH_HAS_HOLES_MEMORYMODEL
>       ARM: highbank: select required errata work-arounds
>       ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE

This one seems to have broken the AMBA PL08x DMA driver, and is still
objected to by Russell, so I'll drop this one for now.

>       ARM: highbank: fix debug uart virtual address for LPAE

The rest look OK and I can pull them if the rest are OK without the
objectionable one.  Let me know if that's OK, or you prefer to wait for
resolution.

Kevin


>  arch/arm/include/asm/mach/arch.h  | 2 +-
>  arch/arm/include/debug/highbank.S | 2 +-
>  arch/arm/mach-highbank/Kconfig    | 6 ++++++
>  arch/arm/mach-highbank/highbank.c | 3 +++
>  arch/arm/mm/init.c                | 2 +-
>  5 files changed, 12 insertions(+), 3 deletions(-)
