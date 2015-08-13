From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 12:15:09 +0200
Subject: [GIT PULL 2/2] Rockchip devicetree changes for 4.3, part2
In-Reply-To: <1647709.GpuDCKf86R@diego>
References: <3109032.sS4ICWceDv@diego>
 <1647709.GpuDCKf86R@diego>
Message-ID: <20150813101509.GS30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 11:28:54PM +0200, Heiko St?bner wrote:
> The following changes since commit 4863dcd394019b542ac968870cba734d27e992e0:
> 
>   ARM: dts: rockchip: add rk3288 arm-pmu irq affinity (2015-07-16 22:22:47 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-dts2
> 
> for you to fetch changes up to 378abcdf3297613f6712343ce3a79b7d6abdf955:
> 
>   ARM: dts: rockchip: add veyron-minnie board (2015-08-08 12:31:27 +0200)
> 
> ----------------------------------------------------------------
> Some more devicetree changes, including usbphy support for the
> Cortex-A9 SoCs and actually enabling usb on the rk3066-marsboard,
> Two more veyron-devices - namely Speedy and Minnie and a fix for
> the tsadc.
> One slightly more interesting fix is the blocking of the last
> 16MB of memory on 4GB rk3288 devices. The rk3288 cannot use this
> area for dma operations, so things like the mmc or usb controllers
> regularly fail when trying to read data. This solution mimicks the
> solution from the ChromeOS kernel, who also do not seem to have
> found a better solution yet. Here it only moves to the devicetree.
> As this issue is also present on the arm64 rk3368, any future
> better solution to this problem would need to describe this in
> the devicetree as well and could then remove this block.

Merged, thanks!


-Olof
