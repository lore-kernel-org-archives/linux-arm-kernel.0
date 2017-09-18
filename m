From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Mon, 18 Sep 2017 09:40:02 +0000
Subject: [PATCH v3 0/3] STM32 CRYP crypto driver
In-Reply-To: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
References: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <7be8c468-2e95-c781-3af3-d411acc80598@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a gentle ping ... or have I missed out on a reply?


On 18/08/17 11:19, Fabien Dessenne wrote:
> This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
> This drivers uses the crypto API and provides with HW-enabled AEAD and block
> cipher algorithms.
> It makes use of the crypto engine which is upgraded in order to support AEAD
> requests.
>
> This driver was successfully tested with tcrypt / testmgr.
>
> Changes since v3:
> - update dt-bindings with Rob Herring remarks
>
> Changes since v2:
> - update dt-bindings (interrupts description)
> - rebase on STM32 crypto patches (L. Debieve : update CRC32 + add HASH)
>
> Fabien Dessenne (3):
>    crypto: engine - permit to enqueue aead_request
>    dt-bindings: Document STM32 CRYP bindings
>    crypto: stm32 - Support for STM32 CRYP crypto module
>
>   .../devicetree/bindings/crypto/st,stm32-cryp.txt   |   19 +
>   crypto/crypto_engine.c                             |  101 +
>   drivers/crypto/stm32/Kconfig                       |    9 +
>   drivers/crypto/stm32/Makefile                      |    3 +-
>   drivers/crypto/stm32/stm32-cryp.c                  | 1962 ++++++++++++++++++++
>   include/crypto/engine.h                            |   16 +
>   6 files changed, 2109 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
>   create mode 100644 drivers/crypto/stm32/stm32-cryp.c
>
