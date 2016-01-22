From: dhdang@apm.com (Duc Dang)
Date: Fri, 22 Jan 2016 15:05:23 -0800
Subject: [PATCH v4 1/3] mailbox: Add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <201601162056.dOHk9NgN%fengguang.wu@intel.com>
References: <abff73c051fd06a9dd3b04a1e7957ad5a9b69a18.1452912126.git.dhdang@apm.com>
 <201601162056.dOHk9NgN%fengguang.wu@intel.com>
Message-ID: <CADaLNDmRL-PcwaM7=V_711cLDz=sf-BOycX7EnPcxtY8f_cEYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2016 at 4:31 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Duc,
>
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on v4.4 next-20160115]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Duc-Dang/mailbox-Add-support-for-APM-X-Gene-platform-mailbox-driver/20160116-110535
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
> config: arm64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All warnings (new ones prefixed by >>):
>
>>> WARNING: vmlinux.o(.data+0xfd6260): Section mismatch in reference from the variable slimpro_mbox_driver to the variable .init.text:$x
>    The variable slimpro_mbox_driver references
>    the variable __init $x
>    If the reference is valid then annotate the
>    variable with or __refdata (see linux/init.h) or name the variable:

I fixed the build warning, will post and updated after further comment
from Jassi.

I did not catch it before posting my patch because I did not compile
with  CONFIG_DEBUG_SECTION_MISMATCH=y. I will make sure I have this
option enabled for my build process going forward.

Regards,
Duc Dang.
>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
