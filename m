From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Mar 2013 10:54:21 +0000
Subject: [PATCH] clk: vexpress: Add separate SP810 driver
In-Reply-To: <1363358409-5693-1-git-send-email-pawel.moll@arm.com>
References: <1363358409-5693-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130318105421.GB29353@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 02:40:09PM +0000, Pawel Moll wrote:
> Factor out the SP810 clocking code into a separate driver,
> selecting better (faster) parent at clk_prepare() time.
> This is to avoid problems with clocking infrastructure
> initialisation order, in particular to avoid dependency
> of fixed clock being initialized before SP810. It also
> makes vexpress platform OF-based clock initialisation code
> unnecessary.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mach-vexpress/v2m.c         |    8 +-
>  drivers/clk/versatile/Makefile       |    2 +-
>  drivers/clk/versatile/clk-sp810.c    |  172 ++++++++++++++++++++++++++++++++++
>  drivers/clk/versatile/clk-vexpress.c |   49 ----------
>  4 files changed, 180 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/clk/versatile/clk-sp810.c
> 
> Hi Mike,
> 
> I'd like to get this merged in 3.10. After this arm64
> will be able to avoid any platform clocking code. And
> in case of v7 this will happen once Rob's SP804 work
> is done.

FWIW, I'm using this patch on the ARMv8 model (arm64).

Tested-by: Catalin Marinas <catalin.marinas@arm.com>
