From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 22 Feb 2012 16:23:00 +0400
Subject: [PATCH v2 1/7] ARM: davinci, intc: Add OF support for TI interrupt
 controller
In-Reply-To: <1329893410-24413-2-git-send-email-hs@denx.de>
References: <1329893410-24413-1-git-send-email-hs@denx.de>
 <1329893410-24413-2-git-send-email-hs@denx.de>
Message-ID: <4F44DE24.30606@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-02-2012 10:50, Heiko Schocher wrote:

> Add a function to initialize the davinci interrupt controller (INTC)
> using a device tree node.

    cp_intc is not DaVinci interrupt controller, it's only used in OMAP-L1x 
SoCs. cp_intc stands for Common Platform Interrupt Controller. I don't see 
where you are initializiing the DaVinci interrupt controller itself. You 
should understand that there are two disctinct types of interrupt controllers 
used in the SoCs supported by arch/arm/mach-davinci/.

> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>

[...]

> diff --git a/Documentation/devicetree/bindings/arm/davinci/intc.txt b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> new file mode 100644
> index 0000000..dac2f69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/intc.txt
> @@ -0,0 +1,26 @@
> +* TI Davinci Interrupt Controller
> +
> +davinci are using a TI interrupt controller that can support several
> +configurable number of interrupts.
> +
> +Main node required properties:
> +
> +- compatible : should be:
> +	"ti,davinci-intc"

    The right "compatible" prop would be "ti,cp_intc" in this case.

WBR, Sergei
