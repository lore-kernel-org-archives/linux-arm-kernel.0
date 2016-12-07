From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Dec 2016 09:57:16 +0100
Subject: [PATCH 1/2] ARM: dts: at91: sama5d4: change DMA allocation for
 secure peripherals
In-Reply-To: <20161130173630.11944-1-nicolas.ferre@atmel.com>
References: <20161130173630.11944-1-nicolas.ferre@atmel.com>
Message-ID: <20161207085716.snqzkhuqyfl6uto6@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/2016 at 18:36:29 +0100, Nicolas Ferre wrote :
> Some peripherals are "Programmable Secure" but left as "Secure" by default.
> If tried to be connected to Non-Secure DMA controller, the possibility to
> leak secure data is prevented so using these peripherals with DMA1 is not
> possible with this default configuration (MATRIX_SPSELR registers setup by
> bootloader).
> Move them to DMA0 which is an "Always-Secure" DMA controller.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
All applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
