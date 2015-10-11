From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 18:47:55 +0200
Subject: [PATCH v2 1/3] ARM: dts: sun4i: Allow to use the PH6 pin for
 GPIO on pcDuino1/2
In-Reply-To: <1444388979-12072-2-git-send-email-siarhei.siamashka@gmail.com>
References: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
 <1444388979-12072-2-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20151011164755.GP2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 02:09:37PM +0300, Siarhei Siamashka wrote:
> The pcDuino1 board does not use any power switches at all for its
> two USB host ports and the VBUS pins are always connected to 5V.
> 
> The pcDuino2 board uses the RT9701GB power switch for its single
> USB host port, but the USB_EN pin (PD2) is pulled up with a 10K
> resistor. So that the USB power is still enabled by default,
> resulting in the same behaviour as pcDuino1 if nobody touches
> the PD2 pin. This minor difference is going to be handled in a
> follow-up patch, introducing a separate dts file for pcDuino2.
> 
> The primary reason for this fix is that the current dts file
> unnecessarily meddles with the PH3 and PH6 pins. But the PH6 pin
> is available on the Arduino-compatible expansion header and may
> have a better use for other purposes. This patch fixes the
> problem and now the PH6 pin can be used with the GPIO sysfs
> interface. Tested on a pcDuino2 board with a multimeter:
> 
>     echo 230 > /sys/class/gpio/export
>     echo "out" > /sys/class/gpio/gpio230/direction
>     echo 0 > /sys/class/gpio/gpio230/value
>     echo 1 > /sys/class/gpio/gpio230/value
> 
> USB still works as expected too.
> 
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/2e4c9dc6/attachment.sig>
