From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 13:52:42 +0100
Subject: [PATCH v3 2/5] Documentation: DT: Add bindings for Spreadtrum SoC
 Platform
In-Reply-To: <1416917818-10506-3-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1416917818-10506-3-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <2672926.PUHDU64fHa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 20:16:55 Chunyan Zhang wrote:
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> new file mode 100644
> index 0000000..54e532f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> @@ -0,0 +1,6 @@
> +* Spreadtrum serial UART
> +
> +Required properties:
> +- compatible: must be "sprd,sc9836-uart"
> +- reg: offset and length of the register set for the device
> +- interrupts: exactly one interrupt specifier
> 

The driver uses a clock, and the dts file lists a clock
property, so it should be documented here, either as optional
or mandatory, and with a description what this clock refers to.

	Arnd
