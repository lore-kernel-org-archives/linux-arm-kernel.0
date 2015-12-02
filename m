From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 1 Dec 2015 20:44:11 -0700
Subject: [PATCH RFC 3/4] ARM: bcm2835: specify card detect pin for RPi B
In-Reply-To: <1447949176-21926-4-git-send-email-stefan.wahren@i2se.com>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <565E690B.8020801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2015 09:06 AM, Stefan Wahren wrote:
> Only the Raspberry Pi B has a card detect pin. Specify it
> on board level because it's not free to use.

This seems fine, but it should have no effect in practice; when the SD
controller driver gpio_get()s the GPIO, the same setting will be
programmed into HW. There's a requirement to use the pinctrl bindings to
configure pins to non-GPIO mux settings, but no actual requirement to do
so for GPIOs.

However, the new node sdhci_cd should be added to some pinctrl-0
property or it won't be used.
