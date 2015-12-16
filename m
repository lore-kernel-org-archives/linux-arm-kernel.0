From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 00:13:07 +0100
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
 <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
Message-ID: <1827708.e1pfN6rEID@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 16:59:39 Rob Herring wrote:
> On Mon, Dec 14, 2015 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 14 December 2015 15:26:11 Peter Chen wrote:
>
> I agree on doing it properly, but am not sure that pwrseq binding for
> MMC is proper. The pwrseq binding is fairly limited and working around
> the driver model IMO. Hubs may also need I2C setup which I don't think
> could be done generically other than some defined sequence of i2c
> transactions. The current project I'm working on needs to use I2C to
> configure the hub to use HSIC mode for example. I really think we need
> a pre-probe driver hook to handle this. That would allow device
> specific setup to live in the driver.
> 
> Perhaps a more simple approach would be just forcing driver probe if a
> DT node is present. I'm not all that familiar with USB drivers, but
> presumably there is some setup before probe like setting the USB
> device address. We'd have to allow doing that later during probe.

Yes, good idea. I was also advocating that approach for MMC at some
point, but the power sequencing made it in the end.

	Arnd
