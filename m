From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 01 Jun 2015 17:14:21 -0700
Subject: [PATCH v9 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
 (Bintian Wang's message of "Sat, 30 May 2015 09:50:55 +0800")
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <7hd21fc6g2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bintian Wang <bintian.wang@huawei.com> writes:

> Hi6220 is one mobile solution of Hisilicon, this patchset contains
> initial support for Hi6220 SoC and HiKey development board, which
> supports octal ARM Cortex A53 cores. Initial support is minimal and
> includes just the arch configuration, device tree configuration, the
> clock driver has been picked up by clock maintainers in clk tree.
>
> PSCI is enabled in device tree and there is no problem to boot all the
> octal cores, and the CPU hotplug is also working now, you can download
> and compile the latest firmware based on the following link to run this
> patch set:
> https://github.com/96boards/documentation/wiki/UEFI
>
> Chnages v9:
> * Rebase to linus/master 4.1-rc1
> * Remove the clock driver from this version because the clock maintainers
>   have queued up the clock driver:
>   git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next-hi6220
> * This version also includes clock header file:
>   [PATCH v9 6/6] dt-bindings: Add header file of hi6220 clock driver
>   Although above patch is included in clock driver, I add to this series
>   because the device tree file includes it, there will be compile error
>   without it.
>   At last, we just need to keep one when merged together.

I know I already gave my tested-by on v8, but FYI, I also tested this
series on v4.1-rc1 merged with the clk-next-hi6220 branch currently in
the clk-next tree, and it's booting all 8 cores.

Next step: collect acks from DT maintainers for the bindings.

Kevin
