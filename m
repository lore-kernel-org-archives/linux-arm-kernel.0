From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 19 Nov 2013 11:03:00 +0800
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>	<52843855.5060509@linaro.org>	<52847FBE.9070501@linaro.org>	<CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>	<52848547.9080604@linaro.org>
 <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
Message-ID: <528AD4E4.9010103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 05:54 PM, Shaojie Sun wrote:
> No, I think it is a bug.
> 
> Because I tested the option with NO_HZ_FULL and without
> NO_HZ_FULL_ALL. It had only little interruptes on CPU0 twd.
> With same code, I added NO_HZ_FULL_ALL option. It had too many
> interruptes on CPU0 twd.
> 
> So the sumbitter just didn't test twd interrupts, when he expanded
> NO_HZ_FULL option to all cpu.
> 
> On Thu, Nov 14, 2013 at 4:09 PM, viresh kumar <viresh.kumar@linaro.org> wrote:
>> On Thursday 14 November 2013 01:35 PM, Vincent Guittot wrote:
>>> AFAICT, It's a none issue. In full nohz, a timer fires periodically
>>> (around 4sec period on ARM IIRC) on one cpu (cpu0).
>>
>> Timer should always be running on CPU0, its out of nohz-full domain. Its
>> cpu 1, where it will fire after long delays..
>>
>>
>> https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/AdaptiveTickless


Shaojie,
which kernel version has this bug?
I just find only the v3.13 kernel has opened the NO_HZ_FULL for 32 bit
kernel. and my testing base it.

but for lsk, it is 3.10 kernel, so unless you are using 64bit kernel to
do testing, is it right?

-- 
Thanks
    Alex
