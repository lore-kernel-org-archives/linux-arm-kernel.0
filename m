From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 10:35:19 +0100
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
Message-ID: <3023844.AYbAYqvHUZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 December 2015 15:26:11 Peter Chen wrote:
> Hi all,
> 
> There is a known issue that the USB code can't handle USB HUB's
> external pins well, in that case, it may cause some onboard
> USB HUBs can't work since their PHY's clock or reset pin needs to
> operate.
> 
> The user reported this issue at below:
> http://www.spinics.net/lists/linux-usb/msg131502.html
> 
> In this patch set, I add a generic onboard USB HUB driver to
> handle this problem, the external signals will be configured
> before usb controller's initialization, it much likes we did
> it at board code before.
> 
> The user needs to add this generic hub node at dts to support it.
> 
> @The udoo users, help to test please.

I still think need to do this properly by representing the hub
device as a USB device, using power sequencing code like MMC does.

	Arnd
