From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 14:54:38 -0800
Subject: [PATCH] arm: dtsi: am335x-bone-common, usb0 is peripheral only
In-Reply-To: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
References: <1389448851-20010-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140213225438.GF28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Markus Pargmann <mpa@pengutronix.de> [140111 06:03]:
> The PMIC is using usb0 vbus line as power source. It is also connected
> to the am335x processor as vbus sense. But there is no possibility to
> pullup usb0 vbus to operate as host. This patch fixes the dr_mode of usb0.

That's the MUSB? AFAIK it's not possible to operate MUSB in peripheral
only mode because the hardware does what it wants based on the ID
pin state.

Regards,

Tony
