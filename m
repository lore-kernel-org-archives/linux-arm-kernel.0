From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 12 Jun 2017 11:48:22 +0200
Subject: [PATCH v3 0/5] Add support for the STM32F4 CRC32
In-Reply-To: <cover.1495463262.git.cosardindar@gmail.com>
References: <cover.1495463262.git.cosardindar@gmail.com>
Message-ID: <96bd3288-b4f4-87c9-2904-aa52d10ea797@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cosar,

On 05/22/2017 04:33 PM, Cosar Dindar wrote:
> This patch series add hardware CRC32 ("Ethernet") calculation support
> for STMicroelectronics STM32F429.
> 
> Polynomial and key setting are not supported, key is fixed as 0x4C11DB7
> and poly is 0xFFFFFFFF.
> 
> Module is tested on STM32F429-disco board with crypto testmgr using
> cases within the key 0xFFFFFFFF.
> 
> Changes in v3:
>      Rearranged patch order to fix build test error.
> 
> Cosar Dindar (5):
>    dt-bindings : Document the STM32F4 CRC32 binding
>    crypto : stm32 - Add STM32F4 CRC32 support
>    ARM: dts: stm32: Add CRC support to stm32f429
>    ARM: dts: stm32: enable CRC32 on stm32429-disco board
>    ARM: dts: stm32: enable CRC32 on stm32429i-eval board
> 
>   .../devicetree/bindings/crypto/st,stm32-crc.txt    |  4 +-
>   arch/arm/boot/dts/stm32429i-eval.dts               |  4 ++
>   arch/arm/boot/dts/stm32f429-disco.dts              |  4 ++
>   arch/arm/boot/dts/stm32f429.dtsi                   |  7 +++
>   drivers/crypto/stm32/stm32_crc32.c                 | 68 ++++++++++++++++++----
>   5 files changed, 75 insertions(+), 12 deletions(-)
> 

Patches 3, 4, 5 applied on stm32-dt-for-v4.13

regards
Alex
