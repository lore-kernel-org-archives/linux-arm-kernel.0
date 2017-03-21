From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 16:47:07 +0000
Subject: [arm-platforms:timers/errata-rework 10/18]
 drivers/clocksource/arm_arch_timer.c:483:6: error: implicit declaration of
 function 'needs_unstable_timer_counter_workaround'
In-Reply-To: <201703212006.FklvpAFk%fengguang.wu@intel.com> (kbuild test
 robot's message of "Tue, 21 Mar 2017 20:52:09 +0800")
References: <201703212006.FklvpAFk%fengguang.wu@intel.com>
Message-ID: <87ziger304.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21 2017 at 12:52:09 pm GMT, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git timers/errata-rework
> head:   317327df79aeca1621758debe2c4c07f97f43f68
> commit: ffc9559fe76cd5bbd6562cf3a68f87b8c38e8176 [10/18] arm64: arch_timer: Get rid of erratum_workaround_set_sne
> config: arm-sunxi_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ffc9559fe76cd5bbd6562cf3a68f87b8c38e8176
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
>
> Note: the arm-platforms/timers/errata-rework HEAD 317327df79aeca1621758debe2c4c07f97f43f68 builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_set_next_event_virt':
>>> drivers/clocksource/arm_arch_timer.c:483:6: error: implicit declaration of function 'needs_unstable_timer_counter_workaround' [-Werror=implicit-function-declaration]
>      if (needs_unstable_timer_counter_workaround())
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>

Ah, nice catch. I've addressed the issue and pushed out an updated
branch.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
