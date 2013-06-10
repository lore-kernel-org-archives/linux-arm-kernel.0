From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 10 Jun 2013 11:58:38 +0100
Subject: [PATCH v2 09/11] ARM:stixxxx: Add stixxxx options to
 multi_v7_defconfig
In-Reply-To: <20130610104032.GA2513@e106331-lin.cambridge.arm.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856477-7237-1-git-send-email-srinivas.kandagatla@st.com>
 <20130610104032.GA2513@e106331-lin.cambridge.arm.com>
Message-ID: <51B5B15E.50901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for testing...
On 10/06/13 11:40, Mark Rutland wrote:
> On Mon, Jun 10, 2013 at 10:27:57AM +0100, Srinivas KANDAGATLA wrote:
>> > This patch adds stih415 and stih416 support to multi_v7_defconfig.
> This seems to drop a few options also:
> 
> CONFIG_ARM_ARCH_TIMER

Same as last comment 2:
> CONFIG_ARM_ERRATA_754322
ARM_ERRATA_754322 gets selected by the mach level Kconfig of stixxxx, so
it disappears, Should the mach level Kconfig select that?

> CONFIG_EXPERIMENTAL
> CONFIG_GPIO_PL061
> CONFIG_MMC_WMT

Comment 2: Without any modifications to multi_v7_defconfig if I run
savedefconfig CONFIG_ARM_ARCH_TIMER, CONFIG_EXPERIMENTAL,
CONFIG_GPIO_PL061 and CONFIG_MMC_WMT disappears.
Which suggests that these options seems to be selected by another
kconfigs or mach level. And since then the multi_v7_defconfig was not
run with savedefconfig.


Thanks,
srini
> 
> I just applied this to v3.10-rc5, and ran `make ARCH=arm multi_v7_defconfig`.
> It seems MMC_WMT and GPIO_PL061 get selected elsewhere, but ARM_ARCH_TIMER and
> ARM_ERRATA_754322 are left unselected.
> 
> Thanks,
> Mark.
> 
