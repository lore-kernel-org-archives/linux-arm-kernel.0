From: alex@digriz.org.uk (Alexander Clouter)
Date: Mon, 1 Apr 2013 23:02:04 +0100
Subject: [PATCH 0/3] add devicetree bindings for rtc-m48t86
In-Reply-To: <5159FFAA.5030205@gmail.com>
References: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
 <5159FFAA.5030205@gmail.com>
Message-ID: <20130401220204.GJ1953@edkhil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 08:44:10AM +1100, Ryan Mallon wrote:
>On 01/04/13 08:56, Alexander Clouter wrote:
>> Currently there are two users of rtc-m48t86 (mach-ep93xx/ts72xx.c and
>> mach-orion5x/ts78xx-setup.c) and both just use {read,write}b against
>> a memory mapped region.  As I am devicetree'ing the TS-7800, this
>> driver needs converting and thats what this patchset does.
>>
>> The patch does the following:
>>  * remove platform specific ops hooks, moving ioremap'ing and
>> 	everything into the driver
>>  * utilises named resources to indicate index/data ranges
>>  * moves the RTC detection routine from ts78xx-setup.c into rtc-m48t86.c
>>  * and, of course, enable devicetree hooks and include documentation
>>
>> Awkward step, the first patch breaks both boards, the two following
>> patches fix them.  Happy to re-work this if folks give me a pointer
>> on how to do this in an acceptable way.
>
>Sorry, that's no good. It breaks things like git bisect.

Bah :)

>> My vote is to break fast, fix fast, spend the time writing other code :)
>
>The patch series will need to be reworked so that there is no
>build/runtime breakage between any of the patches. I'll have a read
>through and see if I can suggest something.

I am currently working through a new patchset now.  It maintains the original {write,read}byte 
ops but if not defined, and the required named resources are present, it moves to using driver 
side mem mapped regions and what not...

'watch this space'

Cheers

-- 
Alexander Clouter
.sigmonster says: Deflector shields just came on, Captain.
