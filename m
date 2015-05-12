From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 11 May 2015 17:20:54 -0700
Subject: [PATCH v5 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmjR9a-M961-7+9LF2G18qiXYhT+1sb5TEbbrQcW1fnRtw@mail.gmail.com>
References: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
 <7ha8xgi10e.fsf@linaro.org>
 <CAAS=xmjR9a-M961-7+9LF2G18qiXYhT+1sb5TEbbrQcW1fnRtw@mail.gmail.com>
Message-ID: <CAGa+x85QDAzP_8_rPF3H0KpXO9rR2OhzYnMnAFydmBMicDzmEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 7, 2015 at 4:11 PM, Brent Wang <wangbintian@gmail.com> wrote:
> Hello Kevin,
>
> 2015-05-08 4:30 GMT+08:00 Kevin Hilman <khilman@linaro.org>:
>> Bintian Wang <bintian.wang@huawei.com> writes:
>>
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
>>
>> Do you have any tips for booting this using the HiSi bootloader?  It
>> seems that I need to add the magic hisi,boardid property for dtbTool to
>> work.  Could you share what that magic value is?
> Yes, you need it.
> Hisilicon has many different development boards and those boards have some
> different hardware configuration, so we need different device tree
> files for them.
> the original hisi,boardid is used to distinguish different boards and
> used by the
> bootloader to judge which device tree to use at boot-up.
>
>> and maybe add it to the wiki someplace?
> Maybe add to section "Known Issues" in
> "https://github.com/96boards/documentation/wiki/UEFI"
> is a good choice, I will update this section later.

You updated the wiki, but you didn't specify what the value should be
for this to work with the old bootloader.

Can you please give the value of that property?

Also, have you tested this series with the old bootloader as well?

Kevin
