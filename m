From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Dec 2015 14:09:56 +0800
Subject: [PATCH 4/5] ARM: dts: sun5i: Add dts file for the Empire
 Electronix D709 tablet
In-Reply-To: <1450611782-9494-4-git-send-email-hdegoede@redhat.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <1450611782-9494-4-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65daCCOWf7EXDkNWnxv1idXHXesOp6Et_0h-o+9drdeMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 20, 2015 at 7:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The Empire Electronix D709 tablet is a fairly standard 7" A13 tablet,
> featuring usb-wifi, a micro-sd slot, micro-usb otg and headphone jack.
>
> Empire Electronix is written on the back of the tablet, the D709 model
> info can be found in the about tablet menu in android.
>
> The PCB has no markings to speak of.
>
> This dts file does not add support for the ft5x touchscreen found at
> i2c bus 1, addr 0x38, irq PG11, because it does not work out of the box.
> It seems it has been flashed with the wrong firmware and needs to have
> alternative firmware uploaded at boot to make the touchscreen work
> properly, when hot-booting from android into an upstream kernel the
> touchscreen does work.
>
> The Memsic MXC622X accelerometer at i2c bus 1, addr 0x15 also is not
> enabled as there is no driver for it.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/Makefile                         |   1 +
>  .../boot/dts/sun5i-a13-empire-electronix-d709.dts  | 241 +++++++++++++++++++++

The contents seem the same as sun5i-q8-common.dtsi and sun5i-a13-q8-tablet.dts.
Any chance you could use those instead?

On the side, any thoughts on how to handle the differences between various "Q8"
tablets, like different I2C-based sensors and WiFi chips?

I'm asking because with Maxime's couple-regulator we should be able to get the
RTL8723BS on the Q8 A23/33 v1.5 working.

Regards
ChenYu

>  2 files changed, 242 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
