From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 15 Dec 2015 16:33:26 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <3023844.AYbAYqvHUZ@wuerfel>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
Message-ID: <20151215083259.GA13809@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 10:35:19AM +0100, Arnd Bergmann wrote:
> On Monday 14 December 2015 15:26:11 Peter Chen wrote:
> > Hi all,
> > 
> > There is a known issue that the USB code can't handle USB HUB's
> > external pins well, in that case, it may cause some onboard
> > USB HUBs can't work since their PHY's clock or reset pin needs to
> > operate.
> > 
> > The user reported this issue at below:
> > http://www.spinics.net/lists/linux-usb/msg131502.html
> > 
> > In this patch set, I add a generic onboard USB HUB driver to
> > handle this problem, the external signals will be configured
> > before usb controller's initialization, it much likes we did
> > it at board code before.
> > 
> > The user needs to add this generic hub node at dts to support it.
> > 
> > @The udoo users, help to test please.
> 
> I still think need to do this properly by representing the hub
> device as a USB device, using power sequencing code like MMC does.
> 
> 	Arnd

I will try to have a patch set for general onboard USB device.

-- 

Best Regards,
Peter Chen
