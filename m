From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 12 Feb 2014 08:57:43 +0100
Subject: Toggling gpio pins while powering down
In-Reply-To: <CAFXY0108eWG_zZKb9TYGKEF6dpXhY9QuPfQpP0VnF4O4n-YFog@mail.gmail.com>
References: <CAFXY0108eWG_zZKb9TYGKEF6dpXhY9QuPfQpP0VnF4O4n-YFog@mail.gmail.com>
Message-ID: <20140212075743.GD30814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 07:33:11PM +0000, Jasbir Matharu wrote:
> I'm trying to determine the correct way of toggling gpio pins when the
> soc is powering down to enter low power mode. My current crude
> implementation is perform these within a pm_power_off function however
> this is currently done within the board file by checking for a
> compatible board type (ugly). The alternative would be create a driver
> and implement the pm_power_off function within. However given there
> could many drivers implementing a pm_power_off functions there's no
> guarantee mine will be called? Another requirement is that the gpio
> need to be set in the correct order.

Have you seen:

drivers/power/reset/gpio-poweroff.c

It currently only allows for a single gpio, but it would not be too
hard to extend it for multiple gpios.

     Andrew
