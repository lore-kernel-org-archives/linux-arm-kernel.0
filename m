From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 May 2015 10:02:11 +0100
Subject: [PATCH v4 0/5] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <20150507090210.GB22115@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bintian,

On Tue, May 05, 2015 at 01:06:34PM +0100, Bintian Wang wrote:
> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, clock driver, device tree
> configuration.
> 
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI 
> 
> Changes v4:
> * Rebase to kernel 4.1-rc1
> * Delete "arm,cortex-a15-gic" from the gic node in dts 

I gave these patches a go on top of -rc2 using the ATF and UEFI you link to
above.

The good news is that the thing booted and all the cores entered at EL2.
Thanks!

The bad news is that running hackbench quickly got the *heatsink*
temperature to 73 degress C and rising (measured with an infrared
thermometer).

So my question is, does this SoC have an automatic thermal cut out? Whilst
I'm all for merging enabling code into the kernel, if it really relies on
the kernel to stop it from catching fire, maybe it's not a great idea
putting these patches into people's hands just yet.

Will
