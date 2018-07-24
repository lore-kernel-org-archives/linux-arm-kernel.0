From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 24 Jul 2018 20:39:57 +0300
Subject: [PATCH v9 00/24] ILP32 for ARM64
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Message-ID: <20180724173957.GA22106@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

+ Pavel Machek, Palmer Dabbelt, Wookey.

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is the update of the series based on 4.17 kernel
https://github.com/norov/linux/tree/ilp32-4.17
with the following non-critical changes:
 - documentation patch extended with few words about ILP32 in general, and
   the link to ARM document about it added;
 - nds32 and riscv32 exceptions added for ARCH_32BIT_OFF_T and
   {get,set}rlimit (patches 4 and 5).
 - changes to architectures that are unsupported anymore are dropped.
 - Chris Metcalf's ack for patch #3 removed, as it is related to
   tile32 which is unsupported now.

Reminder to Arnd. There's arch subseries acked by you but still
without progress. Could you consider taking it upstream?
[PATCH 03/24] compat ABI: use non-compat openat and open_by_handle_at variants
[PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
[PATCH 05/24] asm-generic: Drop getrlimit and setrlimit syscalls from default list

Yury
