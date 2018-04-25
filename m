From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 25 Apr 2018 15:05:12 +0200
Subject: [PATCH v6 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
In-Reply-To: <20180419135426.155794-1-yixun.lan@amlogic.com>
References: <20180419135426.155794-1-yixun.lan@amlogic.com>
Message-ID: <1524661512.4026.67.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-04-19 at 21:54 +0800, Yixun Lan wrote:
>   This patch try to add AO clock and Reset driver for Amlogic's
> Meson-AXG SoC.
>   Please note that patch 7 need to wait for the DTS changes[3] merged
> into mainline first, otherwise it will break the serial console.
> 
>  patch 2: factor the common code into a dedicated file
>  patch 3-5: add the aoclk driver for AXG SoC
>  patch 6-7: drop unnecessary clock flags
> 
> changes since v5 at [6]: 
>  - drop unnecessary header files
>  - add 'axg_aoclk' prefix to clk driver, make them more consistent
>  - add missing end new line..
> 
> changes since v4 at [5]: 
>  - fix return err
>  - introduce CONFIG_COMMON_CLK_MESON_AO
>  - format/style minor fix
> 
> changes since v3 at [4]: 
>  - add 'const' contraint to the read-only data
>  - switch to devm_of_clk_add_hw_provider API
>  - check return value of devm_reset_controller_register
> 
> changes since v2 at [2]: 
>  - rework meson_aoclkc_probe() which leverage the of_match_data
>  - merge patch 5-6 into this series
>  - seperate DTS patch, will send to Kevin Hilman independently
>  
> changes since v1 at [0]: 
>  - rebase to clk-meson's branch 'next/drivers' [1]
>  - fix license, update to BSD-3-Clause
>  - drop un-used include header file
> 
> [0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan at amlogic.com
> [1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
> [2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
> [3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan at amlogic.com
> [4] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan at amlogic.com
> [5] https://lkml.kernel.org/r/20180408031938.153474-1-yixun.lan at amlogic.com
> [6] https://lkml.kernel.org/r/20180409143749.71197-1-yixun.lan at amlogic.com

Yixun

Please :
 - Fix checkpatch error in patch 5 
 - Collect Philip's Ack on patch 4
 - Remove the extra new lines at EOF in patch 2 (maybe others, I did not check
them all) - 1 new line at the end of each file, not 2.

Regards
Jerome
