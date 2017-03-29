From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 29 Mar 2017 13:12:21 +0200
Subject: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
In-Reply-To: <20170107085203.4431-1-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
Message-ID: <308964a5-84f0-d144-6358-bd334f9dc603@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 07/01/17 09:51, Krzysztof Kozlowski wrote:
> Hi,
> 
> Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
> Chen, we got a power sequence generic library which solves my long
> standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
> 
> My previous attempts for this can be found here [0].
> 
> This patchset is based on Peter's v11 of power sequence [1].
> Patchset is available also on my Github [2].
> 
> More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
> LAN9730 on Odroid U3 after tftpboot").

It's rather late, but I finally had a chance to test this and it works.

So:

Tested-by: Hans Verkuil <hans.verkuil@cisco.com>

This was with u-boot version v2016.09.01 and kernel 4.11.0-rc1.

Regards,

	Hans

> 
> 
> Best regards,
> Krzysztof
> 
> 
> [0] http://www.spinics.net/lists/linux-mmc/msg37386.html
> [1] https://lwn.net/Articles/710736/
> [2] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-pwrseq
> 
> Krzysztof Kozlowski (4):
>   ARM: dts: exynos: Fix indentation of EHCI and OHCI ports
>   ARM: dts: exynos: Fix LAN9730 on Odroid U3 after tftpboot
>   ARM: exynos_defconfig: Enable power sequence for Odroid U3
>   ARM: multi_v7_defconfig: Enable power sequence for Odroid U3
> 
>  arch/arm/boot/dts/exynos4.dtsi            | 24 ++++++++++++------------
>  arch/arm/boot/dts/exynos4412-odroidu3.dts | 21 +++++++++++++++++++++
>  arch/arm/configs/exynos_defconfig         |  2 ++
>  arch/arm/configs/multi_v7_defconfig       |  1 +
>  4 files changed, 36 insertions(+), 12 deletions(-)
> 
