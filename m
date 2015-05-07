From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Thu, 07 May 2015 06:44:51 -0400
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <CAD6h2NRbzdX8a+D8UUNkmaMpf1uw2nfriCHwY7L20j=VM7NOFQ@mail.gmail.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>	<20150507090210.GB22115@arm.com>
 <CAD6h2NRbzdX8a+D8UUNkmaMpf1uw2nfriCHwY7L20j=VM7NOFQ@mail.gmail.com>
Message-ID: <554B4223.7080507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 05:33 AM, Haojian Zhuang wrote:
> On 7 May 2015 at 17:02, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Bintian,
>>
>> On Tue, May 05, 2015 at 01:06:34PM +0100, Bintian Wang wrote:
>>> Hi6220 is one mobile solution of Hisilicon, this patchset contains
>>> initial support for Hi6220 SoC and HiKey development board, which
>>> supports octal ARM Cortex A53 cores. Initial support is minimal and
>>> includes just the arch configuration, clock driver, device tree
>>> configuration.
>>>
>>> PSCI is enabled in device tree and there is no problem to boot all the
>>> octal cores, and the CPU hotplug is also working now, you can download
>>> and compile the latest firmware based on the following link to run this
>>> patch set:
>>> https://github.com/96boards/documentation/wiki/UEFI
>>>
>>> Changes v4:
>>> * Rebase to kernel 4.1-rc1
>>> * Delete "arm,cortex-a15-gic" from the gic node in dts
>> I gave these patches a go on top of -rc2 using the ATF and UEFI you link to
>> above.
>>
>> The good news is that the thing booted and all the cores entered at EL2.
>> Thanks!
>>
>> The bad news is that running hackbench quickly got the *heatsink*
>> temperature to 73 degress C and rising (measured with an infrared
>> thermometer).
> Because you're just testing with minimum patch set. If you can choose
> our release
> on v3.10 & v3.18, you can observe lower temperature. Because we have thermal
> framework and cpufreq driver. We're also upstreaming the thermal driver, but
> it's not merged yet.

the thermal driver is now on v4 (see below)
https://lkml.org/lkml/2015/4/24/1

>
>> So my question is, does this SoC have an automatic thermal cut out?
> It's a low cost board. This feature is implemente by software. So we
> need thermal
> driver and cpufreq driver.
>
> Regards
> Haojian
