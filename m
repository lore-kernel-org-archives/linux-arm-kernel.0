From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 19:06:35 +0200
Subject: [PATCH v2 3/3] ARM: dts: sun4i: Enable USB DRC on pcDuino1/2
In-Reply-To: <1444388979-12072-4-git-send-email-siarhei.siamashka@gmail.com>
References: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
 <1444388979-12072-4-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20151011170635.GR2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 02:09:39PM +0300, Siarhei Siamashka wrote:
> Enable the otg/drc usb controller on the pcDuino1/2 board. Note
> that the pcDuino1 FEX file from the vendor contains the following
> information in the [usbc0] section:
>     usb_id_gpio = port:PH04<0><1><default><default>
>     usb_det_vbus_gpio = port:PH05<0><0><default><default>
>     usb_drv_vbus_gpio = port:PB09<1><0><default><0>
> While the pcDuino2 FEX has:
>     usb_id_gpio = port:PH04<0><1><default><default>
>     usb_det_vbus_gpio = port:PH05<0><0><default><default>
>     usb_drv_vbus_gpio = port:PD02<1><0><default><0>
> 
> The ID pin is indeed PH4. The PD2 pin can be used to switch power
> on/off for the USB Type A receptacle on pcDuino2, but it has nothing
> to do with the MicroUSB OTG receptacle. The VBUS pin of the MicroUSB
> receptacle is always connected to 5V according to the schematics
> (both pcDuino1 and pcDuino2) and confirmed by doing some tests on
> pcDuino2. The PH5 pin is just one of the pins on the J8 expansion
> header and has nothing to do with USB OTG. The PB9 pin is pulled
> up and connected to the N_VBUSEN pin of AXP209 PMIC, while the
> VBUS pin of AXP209 only has a capacitor between it and the
> ground (this pin is not used for anything else).
> 
> To sum it up. Only the ID pin (PH4) has a real use. And 5V voltage
> is always served to the MicroUSB OTG receptacle no matter what is
> the state of the PB9/PD2 pins.
> 
> This patch has been tested on pcDuino2 to work fine in a host role
> with a USB keyboard connected via an OTG cable. It also works fine
> in a device role (cdc_ether) with a regular Micro-B cable connected
> to a desktop PC.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/ea3a3063/attachment.sig>
