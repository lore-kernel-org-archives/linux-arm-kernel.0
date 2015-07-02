From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jul 2015 14:40:23 +0200
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
 <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
Message-ID: <1861313.aMcV1xHCIq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 July 2015 12:08:39 Paul Osmialowski wrote:
> Nah, I've found this code hard to maintain. I'm attaching simplified 
> version.
> 

Looks better to me, but of course needs full review from the clock
maintainers.

I wonder if you could move out the fixed rate clocks into their own
nodes. Are they actually controlled by the same block? If they are
just fixed, you can use the normal binding for fixed rate clocks
and only describe the clocks that are related to the driver.

	Arnd
