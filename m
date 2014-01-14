From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jan 2014 19:57:04 -0700
Subject: [PATCH 2/2] BCM2835: Add I2S driver to device tree
In-Reply-To: <52D3CB18.8040608@koalo.de>
References: <52D3CA6E.1010803@koalo.de> <52D3CB18.8040608@koalo.de>
Message-ID: <52D4A780.7050907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 04:16 AM, Florian Meier wrote:
> This adds the definitions for the BCM2835 I2S driver
> to the device tree. Some GPIO settings are needed for
> the correct pin functions.

Patch 1/1 and the .dtsi portion of patch 2/2 look fine; I can apply
those after 3.14's merge window closes.

However, I don't think I can apply the change to bcm2835-rpi-b.dts in
this patch; those pins are used for the board ID strapping on rev 1
boards, and even on rev 2 boards, they're simply routed to a generic
header, rather than being dedicated for I2S usage. That part of the
patch would be better kept locally in your own kernel tree. Perhaps if
DT overlays ever take off, we can publish it as part of an I2S-specific
overlay.
