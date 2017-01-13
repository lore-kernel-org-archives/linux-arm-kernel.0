From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Jan 2017 16:55:53 +0100
Subject: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
In-Reply-To: <20170113155229.GS14217@n2100.armlinux.org.uk>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
 <20170113155229.GS14217@n2100.armlinux.org.uk>
Message-ID: <20170113155553.gjxfxpald3sqcywi@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/2017 at 15:52:29 +0000, Russell King - ARM Linux wrote :
> On Fri, Jan 13, 2017 at 04:32:53PM +0100, Arnd Bergmann wrote:
> > -#define PWR_CR_DBP			BIT(8)
> > +#define PWR_CR_DBP			(u32)BIT(8)
> 
> Shouldn't that have parens around it as it's no longer a simple expression.
> 

Yes, at least checkpatch complains about it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
