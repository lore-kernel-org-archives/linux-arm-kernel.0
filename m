From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 3 Jan 2018 22:27:57 +0530
Subject: =?UTF-8?Q?Re:_[PATCH_v4_0/7]_ARM:_davinci:_convert_to_common_clock_?=
 =?UTF-8?B?ZnJhbWV3b3Jr4oCL?=
In-Reply-To: <CAHCN7x+50anim4-F++Fd78tuPo9+OdKgvOZ-+jWc=0QFcng5CA@mail.gmail.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <CAHCN7x+50anim4-F++Fd78tuPo9+OdKgvOZ-+jWc=0QFcng5CA@mail.gmail.com>
Message-ID: <ec7ca15a-3e8d-b43e-161d-1e4fe603dbf5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 January 2018 08:40 PM, Adam Ford wrote:
> On Sun, Dec 31, 2017 at 5:39 PM, David Lechner <david@lechnology.com> wrote:
>> This series converts macreqh-davinci to use the common clock framework.
>>
>> Basically, this series does some cleanup and rearranging to get things
>> ready for the conversion. Then there is a patch to add new driver in
>> drivers/clk and finally a patch to make the conversion from the mach
>> clock drivers to the new drivers.
>>
>> I have tested this on LEGO MINDSTORMS EV3 (TI AM1808), so I am confident
>> that I haven't broken anything (too badly) in da850. But, I don't have
>> other hardware to test.
> 
> I tested this on a DA850-EVM, but I was not able to successfully get it to boot.
> 
> It hangs during boot with no errors, oops's, or panics, but the
> standard 4.15.0-rc5 from linux-stable booted just fine.
> 
> Maybe one of the TI guys will have some suggestions, but as-is, it
> appears to break at least the DA850-evm.

I haven't gotten to looking into this series yet. Should happen by
Friday this week.
>> The one thing that I know I have broken is CPU frequency scaling on da850.
>> I don't think it was working with device tree anyway, so I can't really test
>> it with the hardware I have. I'm hoping that it will be OK to defer fixing
>> it and add device tree support at the same time.
>>
> 
> I agree with you that it's broken in the device tree, but I don't
> think it ever worked.

It was working with legacy board file method. Its not supported with DT,
yes. Most probably, the generic cpufreq-dt support needs to be used for
the DT case.

Thanks,
Sekhar
