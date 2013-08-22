From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 14:50:22 -0600
Subject: [PATCH v4] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
In-Reply-To: <1377160283-26934-1-git-send-email-kishon@ti.com>
References: <1377160283-26934-1-git-send-email-kishon@ti.com>
Message-ID: <5216798E.8070900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 02:31 AM, Kishon Vijay Abraham I wrote:
> The Palmas device contains only a USB VBUS-ID detector, so added a
> compatible type *ti,palmas-usb-vid*. Didn't remove the existing compatible
> types for backward compatibility.

> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt

>  PALMAS USB COMPARATOR
>  Required Properties:
> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
> + - compatible : Should be "ti,palmas-usb-vid". "ti,twl6035-usb" and
> +   "ti,palmas-usb" is deprecated and is kept for backward compatibility.

So this defines one new value and deprecates the two old values.

Why isn't a new "ti,twl6035-usb-vid" entry useful? Don't you still need
SoC-specific compatible values so the driver can enable any SoC-specific
bug-fixes/workarounds later if needed?
