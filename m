From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 15:26:49 -0700
Subject: [PATCH 1/2] ARM: stm32: Don't select DMA unconditionally on
 STM32MP157C
In-Reply-To: <20180525160926.150713-1-arnd@arndb.de>
References: <20180525160926.150713-1-arnd@arndb.de>
Message-ID: <20180525222649.adxut6t7w53ugykx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 06:09:13PM +0200, Arnd Bergmann wrote:
> The patch that enabled these had no useful changelog that explains
> why it is done, and it causes a build warning:
> 
> WARNING: unmet direct dependencies detected for STM32_DMA
>   Depends on [n]: DMADEVICES [=n] && (ARCH_STM32 [=y] || COMPILE_TEST [=y])
>   Selected by [y]:
>   - MACH_STM32MP157 [=y] && ARCH_STM32 [=y] && ARCH_MULTI_V7 [=y]
> 
> Generally, platforms should not select arbitrary drivers, so let's
> just revert that change.
> 
> Fixes: de6037fa207f ("ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc now.


-Olof
