From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 1 May 2016 10:58:43 -0600
Subject: [PATCH v4] ARM: bcm2835: dt: Add the ethernet to the device trees
In-Reply-To: <1462000432-18452-1-git-send-email-lkundrak@v3.sk>
References: <1462000432-18452-1-git-send-email-lkundrak@v3.sk>
Message-ID: <572635C3.7070102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2016 01:13 AM, Lubomir Rintel wrote:
> The hub and the ethernet in its port 1 are hardwired on the board.
>
> Compared to the adapters that can be plugged into the USB ports, this
> one has no serial EEPROM to store its MAC. Nevertheless, the Raspberry Pi
> has the MAC address for this adapter in its ROM, accessible from its
> firmware.
>
> U-Boot can read out the address and set the local-mac-address property of the
> node with "ethernet" alias. Let's add the node so that U-Boot can do its
> business.
>
> Model B rev2 and Model B+ entries were verified by me, the hierarchy and
> pid/vid pair for the Version 2 was provided by Peter Chen. Original
> Model B is a blind short, though very likely correct.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

One nit:

> diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
> new file mode 100644
> index 0000000..7200238
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
> @@ -0,0 +1,20 @@
> +
> +/ {

There's an extra blank line at the top of the file.
