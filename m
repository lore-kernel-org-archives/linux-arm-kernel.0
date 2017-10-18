From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Oct 2017 15:23:02 +0200
Subject: [PATCH v2 0/8] ARM: sun8i: a83t: Enable AXP813/AXP818 regulators
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018132302.h6yfhzj3ufciynqx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 04:31:30PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series was originally name "regulator: axp20x: Add support for
> AXP813/818 regulators". It adds support for the X-Powers AXP813/818 [1]
> PMICs' regulators. The series is quite straightforward.
> 
> Changes since v1:
> 
>   - Regulator driver patches were merged and now dropped from the series
> 
>   - Chose simpler names for the regulators
> 
>   - Added SDIO WiFi enablement patches
> 
> Patch 1 adds a axp20x-regulator cell for AXP813, thereby enabling the
> regulators.
> 
> Patch 2 adds a shared dtsi file for the PMIC. This currently contains
> a list of regulator nodes, but will be expanded with Quentin's power
> supply work.
> 
> Patches 3 through 5 add regulator nodes to board dts files for the A83T
> boards that I have. They are not squashed together as each file has
> substantial additions.
> 
> Patch 6 moves the mmc1 pinmux setting over to the dtsi, and sets it by
> default.
> 
> Patches 7 & 8 enable SDIO-based WiFi on the Cubietruck Plus and Banana
> Pi M3.
> 
> Originally my work also included enabling Ethernet. But the Ethernet
> bindings were reverted. Everything can be found here:
> 
>     https://github.com/wens/linux/tree/a83t-regulator-wifi-eth
> 
> Please have a look.
> 
> Lee, we need the mfd changes merged in before merging the dts changes.
> Otherwise, mmc would break as vmmc/vqmmc is tied to the PMIC regulators.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

For the whole serie.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/210b8471/attachment-0001.sig>
