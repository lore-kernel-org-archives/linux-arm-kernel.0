From: jason77.wang@gmail.com (jason)
Date: Tue, 08 Jun 2010 07:22:18 +0800
Subject: [V2 3/3] mx51/keypad: add keypad support for i.MX51 platforms
In-Reply-To: <1275847887.11528.13.camel@realization>
References: <1275566746-6510-1-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-2-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-3-git-send-email-jason77.wang@gmail.com>	
	<1275566746-6510-4-git-send-email-jason77.wang@gmail.com>	
	<1275730558.3446.23.camel@realization> <4C0A5B8E.4020906@gmail.com>
	<1275847887.11528.13.camel@realization>
Message-ID: <4C0D7F2A.5050706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alberto Panizzo wrote:
> Hi Jason,
>
> On sab, 2010-06-05 at 22:13 +0800, jason wrote:
>   
>> Alberto Panizzo wrote:
>>     
>>> On gio, 2010-06-03 at 20:05 +0800, Jason Wang wrote:
>>>   
>>>       
>>>> Add keypad controller device definition for all i.MX51 platforms,
>>>> add a dummy kpp clock for imx keypad driver and add keypad device
>>>> registration on i.MX51 3-stack board.
>>>>
>>>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>>>> ---
>>>>  arch/arm/mach-mx5/board-mx51_3ds.c |   59 ++++++++++++++++++++++++++++++++++++
>>>>  arch/arm/mach-mx5/clock-mx51.c     |    5 +++
>>>>  arch/arm/mach-mx5/devices.c        |   19 +++++++++++
>>>>  arch/arm/mach-mx5/devices.h        |    1 +
>>>>  4 files changed, 84 insertions(+), 0 deletions(-)
>>>>     
>>>>         
>>> May you wont divide platform vs machine code in two different patches.
>>>   
>>>       
>> Thanks for your comments, but here i don't really know what you mean,
>> should i divide this patch to 2 patches or ?
>>     
>
> Code that stays into devices.[c|h] is general code that shall not be 
> modified together with machine code (board-mx51_3ds.c).
>
>   
OK, accept.

Thanks,
Jason.
>>> and, Eric B?nard is working on imx_keypad suspend/resume features[1] and
>>> about it, he is going to modify the platform interface that make us able
>>> to register the device.. this patch could look old in a few.
>>>
>>> [1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/80968/focus=13131
>>>
>>> Best regards,
>>> Alberto!
>>>
>>>   
>>>       
>> Yes, reading this thread, my platform interface is old.
>> I just git pull the upstream, it seems that new interface change hasn't 
>> been merged,
>> i will modify this interface if it is merged into the upstream.
>>     
>
> Well Dmitry (linux input maintainer) asked Eric some clarifications 
> before merging his work.
> In all case, Eric work is going to be part of the next merge window
> through the linux input tree if all goes in the right way.
> So in the imx tree you would see it at least since .35
>
> Sascha, what is your policy about this? Shall Jason support the keypad
> with the current interface and update it's support in the next merge
> window? or it is better to wait?
>
> Alberto!
>
>
>
>   
