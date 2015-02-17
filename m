From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Feb 2015 20:41:41 +0100
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <1424200821-16368-2-git-send-email-arun.ramamurthy@broadcom.com>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1424200821-16368-2-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <8242260.cl4QTECoeX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 February 2015 11:20:20 Arun Ramamurthy wrote:
> +       /* This nodes declares  port 0
> +       and port 1 as host*/
> +
> +       ehci0: usb at 0x18048000 {
> +               compatible = "generic-ehci";
> +               reg = <0x18048000 0x100>;
> +               interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +               phys = <&usbphy0 0 1 &usbphy0 1>;

The second reference in the example is missing the last cell,
as you have #phy-cells = <2>.

> +               phy-names = "usbp0","usbp1";
> +               status = "okay";
> +       };

Further, the binding for "generic-ehci" requires the name to be "usb",
not "usbp0". You should probably update that binding if you can have
multiple references to mention that.

Can you make both names "usb"? If not, we should document a common
naming scheme that the driver can use.

	Arnd
