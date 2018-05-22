From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 22 May 2018 10:42:21 +0100
Subject: [PATCH 2/6] arm_pmu: Change API to support 64bit counter values
In-Reply-To: <201805220546.ySDTMDEX%fengguang.wu@intel.com>
References: <1526638943-2110-3-git-send-email-suzuki.poulose@arm.com>
 <201805220546.ySDTMDEX%fengguang.wu@intel.com>
Message-ID: <8b243663-5ea6-b2a4-a57f-4e0f5b130070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/18 00:30, kbuild test robot wrote:
> Hi Suzuki,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v4.17-rc6 next-20180517]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-perf-Support-for-chaining-event-counters/20180521-102117
> config: arm-corgi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
> 
> All errors (new ones prefixed by >>):
> 
>     arch/arm/kernel/perf_event_xscale.c: In function 'xscale2pmu_init':
>>> arch/arm/kernel/perf_event_xscale.c:741:24: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
>       cpu_pmu->read_counter = xscale2pmu_read_counter;
>                             ^
>     arch/arm/kernel/perf_event_xscale.c:742:25: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
>       cpu_pmu->write_counter = xscale2pmu_write_counter;
>                              ^
>     cc1: some warnings being treated as errors


Thanks for the report, I have fixed this for the next version.

Suzuki
