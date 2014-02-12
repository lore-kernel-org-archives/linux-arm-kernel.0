From: jasbirm66@gmail.com (Jasbir Matharu)
Date: Wed, 12 Feb 2014 17:49:17 +0000
Subject: Toggling gpio pins while powering down
In-Reply-To: <20140212075743.GD30814@lunn.ch>
References: <CAFXY0108eWG_zZKb9TYGKEF6dpXhY9QuPfQpP0VnF4O4n-YFog@mail.gmail.com>
 <20140212075743.GD30814@lunn.ch>
Message-ID: <CAFXY010KXTWqsKea2w=aQAis+D+3=uXF3Xs-vkgdtUsYpeXN7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks look useful l'll look at extending it.

Now only problem is that I need to include code from another drivers
pm_power_off function because its a singleton. Would be nice to have
the facility to register pm_power_off functions from each driver and
call them from the singleton.

On Wednesday, February 12, 2014, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Feb 11, 2014 at 07:33:11PM +0000, Jasbir Matharu wrote:
> > I'm trying to determine the correct way of toggling gpio pins when the
> > soc is powering down to enter low power mode. My current crude
> > implementation is perform these within a pm_power_off function however
> > this is currently done within the board file by checking for a
> > compatible board type (ugly). The alternative would be create a driver
> > and implement the pm_power_off function within. However given there
> > could many drivers implementing a pm_power_off functions there's no
> > guarantee mine will be called? Another requirement is that the gpio
> > need to be set in the correct order.
>
> Have you seen:
>
> drivers/power/reset/gpio-poweroff.c
>
> It currently only allows for a single gpio, but it would not be too
> hard to extend it for multiple gpios.
>
>      Andrew
>
