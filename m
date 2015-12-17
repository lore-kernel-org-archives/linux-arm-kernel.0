From: john.stultz@linaro.org (John Stultz)
Date: Wed, 16 Dec 2015 17:16:01 -0800
Subject: [PATCH v3 0/5] Add reboot notifier driver for rockchip platform
In-Reply-To: <566E9A47.8010004@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <45323116.BWNAaZT5p4@diego> <566E9A47.8010004@rock-chips.com>
Message-ID: <CALAqxLW2HD35kfy2RypvVEYPCuRit8YU=-tqgCev41jksRc7gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 2:30 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> On 2015?12?12? 05:29, Heiko St?bner wrote:
>> Am Mittwoch, 18. November 2015, 17:47:24 schrieb Andy Yan:
>>>
>>> rockchip platform have a protocol to pass the kernel reboot
>>> mode to bootloader by some special registers when system reboot.
>>> By this way the bootloader can take different action according
>>> to the different kernel reboot mode, for example, command
>>> "reboot loader" will reboot the board to rockusb mode, this is
>>> a very convenient way to get the board enter download mode.
>>> And Android system also use this protocol to pass "recovery"?
>>> ?fastboot? reboot mode to bootloader. In upstream land, We found
>>> tegra platform also use this mechanism.
>>>
>>> Before this version, I have sent two Series, which can be found
>>> at [0] [1]
>>> [0] https://patchwork.kernel.org/patch/7140751/
>>> [1] https://patchwork.kernel.org/patch/7153531/
>>
>> just so it doesn't get lost, this ties into a slightly more generic
>> approach,
>> John Stultz is doing for the android reboot reasons:
>>
>> http://thread.gmane.org/gmane.linux.kernel/2103447
>>
>> The only difference is that we'd need to use the pmu syscon for it.
>>
>>
>     Very glad to see your work on this. And your work is more generic than
> my.
>      So hope we can share the code. As you can see, the rockchip platform
> use
>      a GRF or PMU register to store the reboot reason. So maybe we need a
> phandle
>      in the DT node to describe it.

Yea. I need to figure out the best way to represent these various methods in DT.

Apologies for not being super responsive here. Been a bit heads down
trying to finish up some items before holiday break.

>From some of Arnd's comments, it sounds like we may need a larger
generic subsystem for kernel to firmware communications here.  So more
then likely I'll not have a chance to take another swing at this after
the new year.

So if in the meantime you want to try to take my code and rework it,
or extend your code in a similar way, I'll not take any offence. :)

thanks
-john
