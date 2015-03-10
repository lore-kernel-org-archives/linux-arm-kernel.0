From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 14:42:24 +0100
Subject: [PATCH] ARM: at91: force CPU selection
In-Reply-To: <20150310094209.GD9188@piout.net>
References: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
 <2216832.iXiqHye8YX@wuerfel> <20150310094209.GD9188@piout.net>
Message-ID: <2279482.Ohk2PcyWHV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 10:42:09 Alexandre Belloni wrote:
> > 
> > I actually added a bunch of these in other places, but have stopped
> > doing so because Russell didn't like them, and I tend to follow
> > his argument now that it's actually pretty confusing.
> > 
> > In case of at91, we can do better now, once we have multiplatform
> > enabled, and we can simply remove the SOC_SAM_V7 and SOC_SAM_V4_V5
> > symbols entirely (if Alexandre's patch doesn't already do that).
> > 
> 
> I didn't remove it to keep the sub menus SOC_SAM_V7 -> SOC_SAMA5D4 and
> SOC_SAMA5D3, SOC_SAM_V4_V5 -> SOC_AT91SAM9 and SOC_AT91RM9200. But I can
> also expose SOC_AT91RM9200, SOC_AT91SAM9, SOC_SAMA5D3 and SOC_SAMA5D4
> instead of SOC_SAM_V7 and SOC_SAM_V4_V5 and remove them.

Exposing multiple levels won't help here since you can never enable
both v4/v5 and v7 at the same time in multiplatform.

Just use one level for a 'menuconfig ARCH_AT91' entry and put the
four options below that.

	Arnd
