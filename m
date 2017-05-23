From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:29:48 -0500
Subject: [PATCH] crypto: stm32 - Add CRC32 support for STM32F4XX
In-Reply-To: <1494969530-91589-1-git-send-email-cosardindar@gmail.com>
References: <1494969530-91589-1-git-send-email-cosardindar@gmail.com>
Message-ID: <20170523002948.k4fh24rzccix2bsn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 12:18:50AM +0300, Cosar Dindar wrote:
> This patch series add hardware CRC32 ("Ethernet") calculation support
> for STMicroelectronics STM32F4XX series devices.
> 
> As an hardware limitation polynomial and key setting are not supported
> as they are fixed as 0x4C11DB7 (poly) and 0xFFFFFFFF (key).
> 
> CRC32C Castagnoli algorithm is not supported also.
> Module is tested on STM32F429-disco board with crypto testmgr using
> cases within the key 0xFFFFFFFF.
> 
> Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
> ---
>  .../devicetree/bindings/crypto/st,stm32-crc.txt    |  4 +-
>  arch/arm/boot/dts/stm32429i-eval.dts               |  4 ++
>  arch/arm/boot/dts/stm32f429-disco.dts              |  4 ++
>  arch/arm/boot/dts/stm32f429.dtsi                   |  7 +++
>  arch/arm/boot/dts/stm32f469-disco.dts              |  4 ++
>  drivers/crypto/stm32/stm32_crc32.c                 | 68 ++++++++++++++++++----
>  6 files changed, 79 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
