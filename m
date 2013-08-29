From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 15:20:27 -0700
Subject: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <521FBD6B.3020208@ti.com> (Dave Gerlach's message of "Thu, 29 Aug
 2013 16:30:19 -0500")
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <5211E3F6.6090108@ti.com> <52125A39.3010008@ti.com>
 <87vc2qyjao.fsf@linaro.org> <521FBD6B.3020208@ti.com>
Message-ID: <87mwo0rvf8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Gerlach <d-gerlach@ti.com> writes:

[...]

>>>
>>> The working repo for this version of the patch series can be found here:
>>>
>>> git://github.com/dgerlach/linux-pm.git am335x-3.11rc4-suspend-resume
>>
>> I tried this branch on my beaglebone black, and it's not fully resuming.
>> Suspend seems to be working (power draw goes from ~1W to ~130mW) and
>> pressing a key on the UART seems to be waking up the SoC (power draw
>> goes to ~600mW) but I don't ever get the console back.
>>
>> Is there a specific version of the firmware I should be using?
>>
>> Kevin
>>
>
> Kevin, I agree there does seem to be some issues with Beaglebone
> black. I can confirm it works on BeagleBone White and the large am335
> EVM, I am working on pinpointing the issue on beaglebone black, seems
> that support isn't quite there yet.

OK, I tried the above branch on my BB white, using prebuilt firmware
from the next3 branch of the am33x-cm3 repo and it's suspending/resuming
fine.  Thanks for the pointer.

FYI, measuring at the 5V supply, it goes from ~1.6W at idle down to
~700mW in suspend.  The black goes from ~1W down to an impressive 130mW
but of course, it doesn't wake up so maybe it's not that impressive. ;)

Kevin
