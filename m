From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 6 Oct 2015 12:09:23 +0100
Subject: [PATCH v2 12/22] arm64: Delay cpu feature checks
In-Reply-To: <201510061230.QVbFYdKy%fengguang.wu@intel.com>
References: <201510061230.QVbFYdKy%fengguang.wu@intel.com>
Message-ID: <5613ABE3.6060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 05:41, kbuild test robot wrote:
> Hi Suzuki,
>
> [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
>
> config: arm64-alldefconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm64
>
> Note: the linux-review/Suzuki-K-Poulose/arm64-Consolidate-CPU-feature-handling HEAD bfdef3a10032e84cc7ae186a058443219f110679 builds fine.
>        It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>     arch/arm64/kernel/cpufeature.c: In function 'cpu_enable_features':
>>> arch/arm64/kernel/cpufeature.c:733:52: error: 'const struct arm64_cpu_capabilities' has no member named 'sys_reg'
>        if(!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
>                                                         ^
>     arch/arm64/kernel/cpufeature.c:739:47: error: 'const struct arm64_cpu_capabilities' has no member named 'sys_reg'
>        if (!feature_matches(read_cpu_sysreg(caps[i].sys_reg), &caps[i]))
>                                                    ^

That was a mistake in rebase/reordering of patches. Have fixed it internally, will include
it in the next version

Thanks @kbuild-test-robot for the report

Suzuki
