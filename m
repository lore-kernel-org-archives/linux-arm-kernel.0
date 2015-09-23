From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 09:51 +0200
Subject: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
In-Reply-To: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1675889.xYIhzenZEC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 September 2015 17:09:56 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The Cavium ThunderX SoC needs a PCI quirk for its on-chip bridges.
> Since it is arm64, create a new quirks.c file there to contain arm64
> related quirks.  Add the ThunderX bridge quirk, gated by a new config
> variable, so that it can be disabled for kernels that aren't expected
> to be used on ThunderX.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/Kconfig         | 11 +++++++++++
>  arch/arm64/kernel/Makefile |  2 +-
>  arch/arm64/kernel/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/quirks.c
> 

Looks reasonable to me. Just one question: Is the same bridge used
on MIPS machines? If so, maybe it should be moved to drivers/pci/quirks.c
instead for better reuse.

	Arnd
