From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 11 Aug 2011 13:57:13 +0200
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <20110810150232.GC7938@suse.de>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-4-git-send-email-lee.jones@linaro.org>
	<20110810150232.GC7938@suse.de>
Message-ID: <4E43C399.1040505@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2011 05:02 PM, Greg KH wrote:
> On Wed, Aug 10, 2011 at 02:03:42PM +0100, Lee Jones wrote:
>    
>> At the request of Arnd Bergmann this patch moves all SoC
>> platform devices found in sysfs from /sys/devices/platform to
>> /sys/devices/soc/<SoCNum>/. It is believed as the devices are
>> SoC specific and a /sys/devices/soc node has recently become
>> available, that this would be a more appropriate place to
>> display the data.
>>      
> And what userspace tools did you just break by doing this?
>    

I think most of our userspace for this platform poking
around in sysfs use /sys/class/* so should be pretty OK.

And none of which were properly documented in
Documentation/ABI/* anyway, so do we care?
grep -r 'devices/platform' Documentation/ABI/
doesn't show anything relating to the ux500.

The major breakage would be out-of-tree stuff, if
any.

Which is out-of-tree due to the absence of a SoC ID
framework.

Which was nixed by Arnd et al precisely because
the above change was not part of it.

It's a bit hard for Lee to please everyone with this
one I suspect :-D

Thanks,
Linus Walleij
