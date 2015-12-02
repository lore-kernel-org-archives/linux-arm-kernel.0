From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 2 Dec 2015 17:33:44 +0100
Subject: [PATCH RFC 3/4] ARM: bcm2835: specify card detect pin for RPi B
In-Reply-To: <565E690B.8020801@wwwdotorg.org>
References: <1447949176-21926-1-git-send-email-stefan.wahren@i2se.com>
 <1447949176-21926-4-git-send-email-stefan.wahren@i2se.com>
 <565E690B.8020801@wwwdotorg.org>
Message-ID: <565F1D68.5030503@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.12.2015 um 04:44 schrieb Stephen Warren:
> On 11/19/2015 09:06 AM, Stefan Wahren wrote:
>> Only the Raspberry Pi B has a card detect pin. Specify it
>> on board level because it's not free to use.
> This seems fine, but it should have no effect in practice; when the SD
> controller driver gpio_get()s the GPIO, the same setting will be
> programmed into HW. There's a requirement to use the pinctrl bindings to
> configure pins to non-GPIO mux settings, but no actual requirement to do
> so for GPIOs.
>
> However, the new node sdhci_cd should be added to some pinctrl-0
> property or it won't be used.

This is done in Patch 4
