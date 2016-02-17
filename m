From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 17 Feb 2016 11:09:46 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
Message-ID: <56C438DA.5040109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/16 16:04, Linus Walleij wrote:
> This moves the versatile CLCD configuration to the device tree by:
> 
> - Deleting the board file set-up of CLCD displays and quirks,
>   instead relying on the driver to handle this. The driver will
>   attempt to auto-detect (like the board file did) and match to
>   a corresponding panel in the device tree.
> 
> - Defining all auto-detectable panels in the device tree for the
>   versatile-ab, defaulting the first one to VGA. The right
>   panel will be selected at panel initialization, and should
>   just work for the IB1 daughterboard panels, like EPSON.
> 
> - Creating a special superset DTS file for the IB2 daughterboard
>   (phone form-factor) equipped Versatile, overriding the default VGA
>   display with the Sanyo 2.5" portrait display definitions, so that
>   the IB2-equipped Versatile can be used with this. This follows
>   the pattern of how we define the Versatile PB as a superset of
>   Versatile AB.
> 
> Tested on Versatile AB with just VGA with the default device tree,
> and with the IB2 daughterboard with the custom IB2 device tree.
> Tested to shunt in XVGA by modifying the device tree and this works
> too. Also tested on QEMU for Versatile in both VGA and Sanyo 2.5"
> mode. I don't have the IB1 daughterboard and its add-on displays,
> but it should work as long as the detection mechanism and device
> tree parameters are sound.

Well... I don't like this very much. The .dts should contain
descriptions for hardware that is connected. Have you looked at DT
overlays? I think they would be a much better match for this.

What's the SYS_CLCD register? An EEPROM or such, programmed when the
board is manufactured? Is the panel meant to be switchable by the user,
possibly to a panel that's not "standard"?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/1978c9c1/attachment.sig>
