From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 22:16:15 +0000
Subject: [PATCH] ARM: TWD: Consolidate local timers support
In-Reply-To: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
References: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
Message-ID: <20101130221615.GA9424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 08:31:05PM +0300, Anton Vorontsov wrote:
> This greatly reduces amount of platform-specific code, and thus
> makes it easier to add local timers for new platforms.
> 
> Technically, it's not very nice to place machine-specific (i.e.
> local_timer_setup()) routine into the machine-agnostic code.
> But the true thing is: currently all machines want the same thing.

I've just been talking to someone this week about (presumably) non-TWD
local timers.

I suspect your patch is all part of the "lets try to get ARM building
for every platform in the world in one kernel" but it's really painful
to see carefully abstracted interfaces being trodden on by this argument
- which is just going to make things more difficult in the future.
