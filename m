From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 Aug 2013 18:08:54 +0200
Subject: [PATCH] ARM: at91/dt: split sam9x5 peripheral definitions
In-Reply-To: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
References: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130807180854.41b4bedb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boris BREZILLON,

On Wed,  7 Aug 2013 12:14:26 +0200, Boris BREZILLON wrote:
> This patch splits the sam9x5 peripheral definitions into:
> - a common base for all sam9x5 SoCs (at91sam9x5.dtsi)
> - several optional peripheral definitions which will be included by specific
>   sam9x5 SoCs (at91sam9x5_'periph name'.dtsi)
> 
> This provides a better representation of the real hardware (drop unneeded
> dt nodes) and avoids future peripheral id conflict (lcdc and isi both use
> peripheral id 25).
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  arch/arm/boot/dts/at91sam9g25.dtsi       |    2 +
>  arch/arm/boot/dts/at91sam9g35.dtsi       |    1 +
>  arch/arm/boot/dts/at91sam9x25.dtsi       |   24 ++---------
>  arch/arm/boot/dts/at91sam9x35.dtsi       |    1 +
>  arch/arm/boot/dts/at91sam9x5.dtsi        |   67 ------------------------------
>  arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |   56 +++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |   44 ++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5_usart3.dtsi |   51 +++++++++++++++++++++++
>  8 files changed, 158 insertions(+), 88 deletions(-)
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_macb0.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_macb1.dtsi
>  create mode 100644 arch/arm/boot/dts/at91sam9x5_usart3.dtsi

Hum, do we really want to have .dtsi files per peripheral? I might have
overlooked this, but I think it's the first time we would have this in
arch/arm/boot/dts.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
