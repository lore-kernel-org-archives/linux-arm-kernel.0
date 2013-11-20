From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 20 Nov 2013 22:17:48 +0200
Subject: [PATCH 0/3] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <528D18EC.6000501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 06:24 PM, Ivan Khoronzhuk wrote:
> This series contains updates of Davinci nand driver, in order to be
> reused for Keystone platform.
>
> Depends on:
> - Davinci nand driver fixes and updates:
>    https://lkml.org/lkml/2013/11/20/271

^^^^ I suggest to merge this series with above one as it
should not break anything.

>
> - Introduce AEMIF driver for Davinci/Keystone archs:
>    http://lkml.org/lkml/2013/11/11/352
>
> V1:
> https://lkml.org/lkml/2013/11/11/352
>
> Ivan Khoronzhuk (3):
>    mtd: nand: davinci: reuse driver for Keystone arch
>    mtd: nand: davinci: don't set timings if AEMIF is used
>    mtd: nand: davinci: don't request AEMIF address range

For patches:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>
>   .../devicetree/bindings/mtd/davinci-nand.txt       |    8 +--
>   drivers/mtd/nand/Kconfig                           |    6 +--
>   drivers/mtd/nand/davinci_nand.c                    |   57 +++++++++++++-------
>   3 files changed, 45 insertions(+), 26 deletions(-)
>
