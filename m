From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Jan 2014 12:00:25 +0100
Subject: [lm-sensors] [PATCH v3 2/5] input: sun4i-ts: Add support for
 temperature sensor
In-Reply-To: <52C84665.5070203@roeck-us.net>
References: <1388506852-3548-1-git-send-email-hdegoede@redhat.com>
 <1388506852-3548-3-git-send-email-hdegoede@redhat.com>
 <52C84665.5070203@roeck-us.net>
Message-ID: <20140106110025.GQ3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Sat, Jan 04, 2014 at 09:35:33AM -0800, Guenter Roeck wrote:
> On 12/31/2013 08:20 AM, Hans de Goede wrote:
> >The sun4i resisitive touchscreen controller also comes with a built-in
> >temperature sensor. This commit adds support for it.
> >
> >This commit also introduces a new "ts-attached" device-tree property,
> >when this is not set, the input part of the driver won't register. This way
> >the internal temperature sensor can be used to measure the SoC temperature
> >independent of there actually being a touchscreen attached to the controller.
> >
> >Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Couple of minor comments below, though no need to resubmit unless someone else has comments.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> >---
> >  .../bindings/input/touchscreen/sun4i.txt           |   5 +
> >  drivers/input/touchscreen/sun4i-ts.c               | 140 ++++++++++++++++-----
> >  2 files changed, 114 insertions(+), 31 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >index e45927e..6bac67b 100644
> >--- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >+++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> >@@ -6,10 +6,15 @@ Required properties:
> >   - reg: mmio address range of the chip
> >   - interrupts: interrupt to which the chip is connected
> >
> >+Optional properties:
> >+ - allwinner,ts-attached: boolean indicating that an actual touchscreen is
> >+			  attached to the controller
> >+
> Brr. While I understand that you were asked to do this, I don't
> really see the benefit of another "allwinner" here. As if this
> wasn't implied by the "compatible" property.

It's actually the ePAPR that recommends this.

Section 6.1.1, General Principles

"
Some recommended practices includes:
[..]
  5. If new properties are needed by the binding, the recommended
     format for property names is: ?<company>,<property-name>?, where
     <company> is an OUI or short unique string like a stock ticker
     that identifies the creator of the binding.
"

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/24b37344/attachment.sig>
