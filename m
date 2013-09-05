From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Sep 2013 18:32:26 +0200
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827235533.2cc85d33@skate>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827214121.GI19598@titan.lakedaemon.net> <20130827235533.2cc85d33@skate>
Message-ID: <5228B21A.2030509@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2013 23:55, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 27 Aug 2013 17:41:21 -0400, Jason Cooper wrote:
>> On Tue, Aug 27, 2013 at 03:02:48PM -0600, Jason Gunthorpe wrote:
>>> Since this is so complex, maybe it is OK to abandon support for non-DT
>>> boards in the WDT driver? Watchdog is not critical functionality, so
>>> nobody should be critically impacted. Boards would have to migrate
>>> to DT to get WDT back?
>>
>> I'm not 100% opposed to this.  We need to give it careful thought, but
>> it may be a viable solution since we are at the "convert old boards to
>> DT" stage anyhow.  If we had ten more drivers and 6 release cycles in
>> front of us, I'd say no.
> 
> While we're close to full DT for mach-kirkwood and mach-dove, we're
> pretty far from that for mach-orion5x and mach-mv78xx0, and I believe
> both are using the orion_wdt driver.

Actually mach-mv78xx0 don't use orion_wdt driver. In KConfig it depends
on ARCH_ORION5X, ARCH_KIRKWOOD or ARCH_DOVE but not ARCH_MV78XX0.

Moreover the register mapping is not exactly the same than the one used for
orion5x, kirkwood and dove.

But mach-orion5x still uses the orion_wdt driver and is not yet fully
converted to DT.

> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
