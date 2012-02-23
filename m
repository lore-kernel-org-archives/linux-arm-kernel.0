From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 12:46:26 +0000
Subject: [PATCH 5/6] gpio/omap: fix trigger type to unsigned
In-Reply-To: <4F463374.3080502@ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-6-git-send-email-tarun.kanti@ti.com>
 <4F463374.3080502@ti.com>
Message-ID: <20120223124625.GH22675@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 06:09:16PM +0530, Shubhrajyoti wrote:
> On Thursday 23 February 2012 05:40 PM, Tarun Kanti DebBarma wrote:
> > -static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
> > +static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
> > +							unsigned trigger)
> you meant unsigned int ? could it be made u32.

In C, unsigned is the same as unsigned int.
