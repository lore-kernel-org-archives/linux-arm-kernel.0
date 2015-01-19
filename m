From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Jan 2015 11:19:41 -0800
Subject: [GIT PULL v2]Hisilicon hip01 soc and development board updates
 for 3.20
In-Reply-To: <54B723AB.7080506@hisilicon.com>
References: <54B723AB.7080506@hisilicon.com>
Message-ID: <20150119191941.GE16883@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 10:19:23AM +0800, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin, 
> 
> Could you please help to merge the pull request of hisilicon hip01 soc for 3.20. 
> Thanks!
> 
> Best Regards,
> Wei
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hip01-for-3.20-v2
> 
> for you to fetch changes up to 27040189cb050cbe52a81c0e6aeb552872aa0736:
> 
>   ARM: hisi: enable smp for HiP01 (2015-01-15 09:59:51 +0800)
> 
> ----------------------------------------------------------------
> ARM: mach-hisi: Hisilicon hip01 soc and development board updates for 3.20
> 
> - Add hip01 debug UART
> - Add hip01 DT_MACHINE and ARCH_HIP01 configure item
> - Add dts for Hisilicon hip01-ca9x2 board
> - Enable ARCH_HIP01 in the hisi_defconfig
> - Rename hix5hd2_smp_prepare_cpus to hisi_common_smp_prepare_cpus
> - Rename hix5hd2_secondary_startup to hisi_secondary_startup
> - Enable smp for hip01

Actually, you're adding a new dts file that's conflicting at the top level now,
and we don't want that.

Please split your branches like other maintainers do into soc and dt branches.

dt
soc
defconfig

I don't know your workflow, if you have users of your branches. If not, and if
your tree isn't in linux-next, I can cherry pick the branch apart as needed
here. Just let me know.


Thanks.

-Olof
