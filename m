From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 May 2014 17:12:31 +0200
Subject: [PATCH] bus/omap_l3: avoid sync initcall for modules
In-Reply-To: <20140512222006.GI5668@atomide.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-6-git-send-email-arnd@arndb.de>
 <20140512222006.GI5668@atomide.com>
Message-ID: <177753046.dmVvfiu3Rn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 15:20:07 Tony Lindgren wrote:
> 
> How about instead let's add this into include/linux/module.h
> like we have for other initcalls:
> 
> #define postcore_initcall(fn)           module_init(fn)
> 
> There may be others missing too from there. BTW, this driver
> might be few of the drivers that actually might need to be
> initialized early for debugging to catch bad access from
> other drivers.

There is a comment above those defines saying:

/* Don't use these in loadable modules, but some people do... */

so I'm not sure if adding more would be appreciated.

	Arnd
