From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 19 Apr 2017 11:28:18 -0700
Subject: [PATCH 0/8] i.MX7 PCIe related device tree changes
In-Reply-To: <20170413133242.5068-1-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
Message-ID: <CANMBJr6HVp+Pe4QLRU2-fePW8_kZ4tGRELkDCdq8ihUEy901Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2017 at 06:32, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Shawn, everyone:
>
> This series includes changes made to device-tree in order to support
> PCIe on i.MX7 platform. They include:
>
>      - Bringing 'anatop-enable-bit' property of ANATOP regulators back
>        and extending it to all of the HW it is applicable to
>
>      - Adding GPCv2 node for i.MX7 (which was missing, despite the
>        irqchip driver for it being in the tree for quite some time)
>
>      - Adding a PCIe node for i.MX7
>
>      - Adding GPIO expander used by PCIe and enabling PCIe node from
>        above on i.MX7 based Sabre board
>
> As usual, feedback is welcome.
>
> Thanks,
> Andrey Smrinov
>
> Andrey Smirnov (8):
>   Revert "ARM: dts: imx: Remove unexistant property"
>   ARM: dts: imx6: Specify 'anatop-enable-bit' where appropriate
>   ARM: dts: imx7s: Adjust anatop-enable-bit for 'reg_1p0d'
>   ARM: dts: imx7s: Add node for GPC
>   ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6 variant
>   ARM: dts: imx7d-sdb: Add GPIO expander node
>   ARM: dts: imx7d: Add node for PCIe controller
>   ARM: dts: imx7d-sdb: Enable PCIe peripheral

FWIW:

Tested-by: Tyler Baker <tyler.baker@linaro.org>

This whole series on top of v4.11-rc7, with the addition of the iMX7
GPCv2 and reset driver. Tested on a imx7d-cl-som with a CUK Killer
Doubleshot Wireless-AC 1535 wlan/bt radio using a mini pcie to m2
adapter. Confirmed that the radio was able to associate with an AP
using WPA2, and connected to multiple devices using 6lowpan over BLE.

Tyler
