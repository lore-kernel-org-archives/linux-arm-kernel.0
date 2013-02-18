From: arnd@linaro.org (Arnd Bergmann)
Date: Mon, 18 Feb 2013 10:12:44 +0000
Subject: [V2 2/8] USB: EHCI: make ehci-atmel a separate driver
In-Reply-To: <5121F80E.1010501@atmel.com>
References: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
 <1360923853-7875-3-git-send-email-manjunath.goudar@linaro.org>
 <5121F80E.1010501@atmel.com>
Message-ID: <201302181012.44721.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 February 2013, Bo Shen wrote:
> > -             .name   = "atmel-ehci",
> > +             .name   = hcd_name,
> 
> This change will cause atmel ehci won't work with the none device tree 
> kernel.
> 
> it can be fixed with replace other places using "atmel-ehci" with 
> <hcd_name>, that means replace "atmel-ehci" with "ehci-atmel" at other 
> places.

Ah, that is right. Thanks for pointing it out!

Manjunath, please revert this change and ensure you are not changing
the contents of the 'platform_driver->name' field in any of the drivers.

	Arnd
