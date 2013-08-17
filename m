From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 17 Aug 2013 15:01:24 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <20130816204831.GX13964@titan.lakedaemon.net>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130816204831.GX13964@titan.lakedaemon.net>
Message-ID: <520F7424.8030301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 10:48 PM, Jason Cooper wrote:
> On Fri, Aug 16, 2013 at 09:41:38PM +0200, Sebastian Hesselbarth wrote:
>> This adds initial setup for the Marvell Armada 1500 SoCs. The code
>> is fairly straight-forward, but especially _timer_and_clk_init()
>> can be simplified by using default arch hooks. I will have some time
>> until mach-mvebu is prepared for other SoCs moving over, so I can
>> catch up with latest machine simplifications.
>>
>> I am not so sure about the .map_io but I didn't yet fully understand
>> the mapping requirement. Anyway, it is required for iomap and friends
>> to work and basically remaps physical register addressed onto the same
>> virtual addresses.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
[...]
>> +obj-$(CONFIG_MACH_ARMADA_1500)		+= armada-1500.o
>
> guess what?  :)
>
> I swear I had a more substantive comment when I started this.  But after
> a suitable application of gray matter, these nits were all that were
> left. :(

Jason,

thanks for teaching me the alphabet again :) Of course, all your 
comments will be fixed for a real patch set.

I hope Thomas and Gregory will have some time to comment on the
mach-mvebu integration soon which also affects Orion SoCs.

But its weekend, next merge window is far, above just fails to boot
into anything useful due to the lack of drivers - relax :)

Sebastian
