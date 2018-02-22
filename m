From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Feb 2018 17:43:38 +0100
Subject: [PATCH 3/3] ARM: davinci: mark spi_board_info arrays as const
In-Reply-To: <20180220162519.1498223-3-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
 <20180220162519.1498223-3-arnd@arndb.de>
Message-ID: <CAK8P3a2gWP-i0X=3dom4aCMfKgmf41a27Huj9919Epnwg26JoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 5:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Building with LTO revealed that three spi_board_info arrays are marked
> __initconst, but not const:
>
> arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
> arch/arm/mach-davinci/board-dm365-evm.c:729:30: error: 'dm365_evm_spi_info' causes a section type conflict with 'dm646x_edma_device'
>  static struct spi_board_info dm365_evm_spi_info[] __initconst = {
>                               ^
> arch/arm/mach-davinci/dm646x.c:603:42: note: 'dm646x_edma_device' was declared here
>  static const struct platform_device_info dm646x_edma_device __initconst = {
>
> This marks them const as well, as was originally intended.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I applied this to the fixes branch now.

      Arnd
