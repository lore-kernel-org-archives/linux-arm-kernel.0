From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 May 2018 09:49:24 +0200
Subject: [PATCH v2 0/4] Add STM32 USBPHYC to stm32mp157c
In-Reply-To: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
References: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <e6d141c3-7ee1-cb12-5708-18bf9d0986ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie,

On 04/24/2018 11:41 AM, Amelie Delaunay wrote:
> This series adds support for STM32 USB PHY Controller (USBPHYC) to
> stm32mp157c SoC and enables it on stm32mp157c-ev1 board.
> 
> ---
> Changes in v2:
> * Add reset dt-bindings include
> * Add fixed regulators
> * Enable CONFIG_PHY_STM32_USBPHYC in multi_v7_defconfig
> 
> Amelie Delaunay (4):
>    ARM: dts: stm32: add USBPHYC support to stm32mp157c
>    ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
>    ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
>    ARM: multi_v7_defconfig: enable STM32 USB PHY Controller (USBPHYC)
> 
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 36 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts |  5 +++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 21 ++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig   |  1 +
>   4 files changed, 63 insertions(+)
> 

Series applied on stm32-next. To avoid DTC warnings using W=12, I just 
renamed "vdd_usb" node by "vdd-usb".

Regards
Alex
