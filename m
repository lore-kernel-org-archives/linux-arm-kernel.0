From: jason77.wang@gmail.com (jason)
Date: Sat, 05 Jun 2010 22:13:34 +0800
Subject: [V2 3/3] mx51/keypad: add keypad support for i.MX51 platforms
In-Reply-To: <1275730558.3446.23.camel@realization>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-3-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-4-git-send-email-jason77.wang@gmail.com>
	<1275730558.3446.23.camel@realization>
Message-ID: <4C0A5B8E.4020906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alberto Panizzo wrote:
> On gio, 2010-06-03 at 20:05 +0800, Jason Wang wrote:
>   
>> Add keypad controller device definition for all i.MX51 platforms,
>> add a dummy kpp clock for imx keypad driver and add keypad device
>> registration on i.MX51 3-stack board.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/board-mx51_3ds.c |   59 ++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-mx5/clock-mx51.c     |    5 +++
>>  arch/arm/mach-mx5/devices.c        |   19 +++++++++++
>>  arch/arm/mach-mx5/devices.h        |    1 +
>>  4 files changed, 84 insertions(+), 0 deletions(-)
>>     
>
> May you wont divide platform vs machine code in two different patches.
>   
Thanks for your comments, but here i don't really know what you mean,
should i divide this patch to 2 patches or ?
> and, Eric B?nard is working on imx_keypad suspend/resume features[1] and
> about it, he is going to modify the platform interface that make us able
> to register the device.. this patch could look old in a few.
>
> [1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/80968/focus=13131
>
> Best regards,
> Alberto!
>
>   
Yes, reading this thread, my platform interface is old.
I just git pull the upstream, it seems that new interface change hasn't 
been merged,
i will modify this interface if it is merged into the upstream.

Thanks,
Jason.
>> diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
>> index 5da90e9..abc9f87 100644
>> --- a/arch/arm/mach-mx5/board-mx51_3ds.c
>> +++ b/arch/arm/mach-mx5/board-mx51_3ds.c
>> @@ -16,6 +16,7 @@
>>     
<snip>
