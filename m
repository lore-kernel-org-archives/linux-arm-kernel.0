From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 Jul 2012 20:18:32 +0000
Subject: [PATCH v2 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <20120731192458.GE28852@lunn.ch>
References: <1343749529-17571-1-git-send-email-ian.molton@codethink.co.uk>
 <201207311823.54857.arnd@arndb.de> <20120731192458.GE28852@lunn.ch>
Message-ID: <201207312018.33432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 31 July 2012, Andrew Lunn wrote:
> This pattern is used in other places, e.g. when creating the
> clocks. The macro MV643XX_ETH_NAME is also used when creating the
> platform data, and in the driver itself. 
> 
> Are you suggested we replace this with "mv643xx_eth.0"? Or is adding
> the macro
> 
> #define MV643XX_ETH_NAME0 "mv643xx_eth.0" 
> 
> in include/linux/mv643xx_eth.h O.K, since grep will find it, and
> induce the grep'er to perform a second grep on the macro?

I meant the former. Just remove the macro entirely, or at least
don't add new users.

	Arnd
