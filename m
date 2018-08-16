From: john.stultz@linaro.org (John Stultz)
Date: Thu, 16 Aug 2018 11:47:47 -0700
Subject: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
In-Reply-To: <95c5c8b6-35f9-b1b4-0153-591b000c0a79@iki.fi>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
 <CALAqxLWJzpV2Mqkz_ed_5zYX3SFyMZTBgTzyRAden7ab3VNm-Q@mail.gmail.com>
 <95c5c8b6-35f9-b1b4-0153-591b000c0a79@iki.fi>
Message-ID: <CALAqxLUZiSyi0f365B-QRTT1gkWq9RP-4n2950NcF0w9oSXYEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 11:37 AM, Tuomas Tynkkynen
<tuomas.tynkkynen@iki.fi> wrote:
> Hi,
>
> On 08/16/2018 08:57 PM, John Stultz wrote:
>>
>> On Thu, Aug 16, 2018 at 3:22 AM, Will Deacon <will.deacon@arm.com> wrote:
>>>
>>> Hi Tuomas, [+John]
>
> ...
>>>
>>>
>>> Out of interest -- do you know if Hikey960 is used by any boot-testing
>>> farms? The patch above has been in linux-next for ages, but we didn't see
>>> any complaints until it hit mainline :(
>>
>>
>> Unfortunately not yet. HiKey960 upstreaming is ongoing, and the UFS
>> support patches should land in the 4.19 merge window.
>> After which, it will enable more mainline testing as folks won't have
>> to carry patches just to get the system to boot.
>>
>
> A microSD rootfs gets me a working system on e.g. v4.17... except that
> even there the system hangs if I don't have 'clk_ignore_unused' on
> the kernel command line. I wonder if this is a known problem?

Oh, good point. I'm usually focusing on AOSP, so I've not tried
booting from the uSD slot.

As for the  clk_ignore_unused, I've not seen it, but I'm usually
testing with a much larger patch stack targeting AOSP (only
occasionally trying with a smaller set to validate patches being
prepped for upstream).  So if you want to file a bug, please do so
here: https://bugs.96boards.org/

Appreciate your testing! Please do feel free to reach out/cc me if you
run into other issues.

thanks
-john
