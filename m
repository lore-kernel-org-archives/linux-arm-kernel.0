From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Feb 2014 20:28:17 +0100
Subject: [PATCH v4 0/5] Add Allwinner A31 SPI controller support
In-Reply-To: <1391605507-30981-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391605507-30981-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140207192817.GN3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:05:02PM +0100, Maxime Ripard wrote:
> Hi everyone,
> 
> This patchset brings support for the SPI controller found in the
> Allwinner A31 SoC.
> 
> Even though the controller supports DMA, the driver only supports PIO
> mode for now. This driver will be used to bring up and test DMA on the
> SoC, so support for the DMA will come eventually.
> 
> It doesn't support transfer larger than the FIFO size (128 bytes) for
> now, I expect it to be fixed in the future.
> 
> Thanks!
> Maxime
> 
> Changes from v3:
>   - Rebased on top of 3.14-rc1
>   - Removed the dependency on devm_spi_alloc_master
>   - Modified the pm_runtime code according to reviews
> 
> Changes from v2:
>   - Removed the select on runtime_pm
>   - Fixed the clock error messages
>   - Trigger the CS manually, and honour the enable bit in set_cs
>   - Convert to devm_* functions
>   - Remove useless clk_disable_unprepare in probe
> 
> Changes from v1:
>   - Switched to using the transfer_one and set_cs callbacks
>   - Switched to using runtime_pm
>   - Report an error when we try to do a transfer larger than the FIFO
>     size, instead of silently timeouting.
>   - Added a Kconfig symbol
>   - Move the clock ratio change at transfer time
>   - Fixed the PLL6 cell size in the DTSI
>   - A few fixes here and there: typos, etc.
> 
> Maxime Ripard (5):
>   clk: sunxi: Add support for PLL6 on the A31
>   ARM: sun6i: dt: Add PLL6 and SPI module clocks
>   spi: sunxi: Add Allwinner A31 SPI controller driver
>   ARM: sun6i: dt: Add SPI controllers to the A31 DTSI
>   ARM: sunxi: Enable A31 SPI and SID in the defconfig

Applied patch 2 and 4 to sunxi/dt-for-3.15, and patch 5 to sunxi/defconfig-for-3.15

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/b2250536/attachment.sig>
