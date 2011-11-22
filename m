From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 20:42:38 +0000
Subject: [PATCH 1/2] ARM: debug: Add CLSP711X_UART1 config choice
In-Reply-To: <4E77C84E.9040202@codeaurora.org>
References: <20110916114140.GA31334@e102144-lin.cambridge.arm.com>
 <1316455300-5752-1-git-send-email-sboyd@codeaurora.org>
 <20110919212502.GB23613@e102144-lin.cambridge.arm.com>
 <4E77BE34.6070702@codeaurora.org>
 <20110919224151.GB28237@n2100.arm.linux.org.uk>
 <4E77C84E.9040202@codeaurora.org>
Message-ID: <20111122204238.GE9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 03:55:10PM -0700, Stephen Boyd wrote:
> Ah ok. How about this instead?

Better...

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9661c51..31896f4 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -93,14 +93,19 @@ choice
>                   It does include a timeout to ensure that the system does not
>                   totally freeze when there is nothing connected to read.
>  
> +       config DEBUG_FOOTBRIDGE_COM1
> +               bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"

I don't think PC-isms help here - especially when these aren't labelled
using this terminology on devices.  Netwinder called it just a simple
"Serial" on the rear panel.

		bool "Kernel low-level debugging messages via 8250 serial port at 0x3f8"

> +               depends on FOOTBRIDGE
> +               help
> +                 Say Y here if you want the debug print routines to direct
> +                 their output to the 8250 at PCI COM1.

Same kind of fixup here.  Other than that, it seems fine.
