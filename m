From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Dec 2010 15:24:16 +0000
Subject: [PATCH] ARM: TWD: Consolidate local timers support
In-Reply-To: <20101130221615.GA9424@n2100.arm.linux.org.uk>
References: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
	<20101130221615.GA9424@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinse2AS4gj0-5H3tZsXbhzW1AT8xY8gT9qo8j35@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2010 22:16, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 08:31:05PM +0300, Anton Vorontsov wrote:
>> This greatly reduces amount of platform-specific code, and thus
>> makes it easier to add local timers for new platforms.
>>
>> Technically, it's not very nice to place machine-specific (i.e.
>> local_timer_setup()) routine into the machine-agnostic code.
>> But the true thing is: currently all machines want the same thing.
>
> I've just been talking to someone this week about (presumably) non-TWD
> local timers.

FYI, Cortex-A15 comes with some architected timers different from the
current ones (specs publicly available in the same place as LPAE).
We'll push some patches at some point.

-- 
Catalin
