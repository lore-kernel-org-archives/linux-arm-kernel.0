From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 16:48:13 +0100
Subject: [PATCH v4 3/6] ARM: at91/dt: define sama5d3 clocks
In-Reply-To: <52A582AB.6010504@overkiz.com>
References: <1385650171-8756-1-git-send-email-b.brezillon@overkiz.com>
 <201312090309.23723.arnd@arndb.de> <52A582AB.6010504@overkiz.com>
Message-ID: <201312091648.13802.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, boris brezillon wrote:
> > You are adding "clock-names" properties in a lot of cases. Are you sure you
> > are using the strings that are documented in the respective device bindings
> > for each name? In a lot of cases, drivers just want an anonymous clock
> > and we don't name them.
> 
> I rechecked it, and almost all drivers call [devm_]clk_get with a 
> specific clock
> name, and as a result we must specify the "clock-names" property.
> The only exceptions I found are the spi and PIT (Periodic Interval 
> Timer) drivers,
> and "clock-names" property is not defined in these nodes.

Yes, I understood that the *drivers* use the names, but are they actually
documented in the device bindings? If not, it might be better to change the
drivers.

	Arnd
