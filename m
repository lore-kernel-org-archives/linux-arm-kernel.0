From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 20:52:08 +0100
Subject: [PATCH v4 0/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
References: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
Message-ID: <201401052052.09174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 January 2014, Hauke Mehrtens wrote:
> I am working on mainlining this SoC again which I started in Summer 
> 2013.
> 
> This adds initial support for Broadcom network SoC from the BCM5301X 
> and BCM470X line.
> 
> The vendor BSP also uses BCM5301X for this SoC, so I just toke that.
> 
> I haven't found a better solution than the abort handler for the memory fault.
> 
> I do not have any documentation, only the vendor source code published 
> by Asus and Netgear to conform with the GPL, it would be nice to get 
> some documentation for this Soc like this
> https://www.broadcom.com/collateral/pg/440X-PG02-R.pdf
> for the Broadcom BCM440X Ethernet controller.
> 
> With some additional patches I got Ethernet working with ~250 MBit/s.
> 
> A bootlog can be found here:
> http://hauke-m.de/files/openwrt/devices/R6250/openwrt-boot-2014-01-05.txt

First three patches Acked-by: Arnd Bergmann <arnd@arndb.de>, with my
one comment addressed by removing the timer_init function.

About the fourth patch, I'd still hope we can find a less invasive
workaround than to trap all external imprecise data aborts.

	Arnd
