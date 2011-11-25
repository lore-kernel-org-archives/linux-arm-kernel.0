From: amit.kachhap@gmail.com (amit kachhap)
Date: Fri, 25 Nov 2011 09:14:17 +0530
Subject: [PATCH V3 0/6] ARM: exynos: Add l2 retention mode cpuidle state
In-Reply-To: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <CADGdYn46oLjkfrRgc--khr851Gw7ZPb_htpfyS9vas==mCiAjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin Kim,

Any comments or feedback on this patchset from your side. I am
preparing another version with fixes/issues suggested by Russell
and Inder.

Thanks,
Amit Daniel

On Tue, Nov 22, 2011 at 3:05 PM, Amit Daniel Kachhap
<amit.kachhap@linaro.org> wrote:
> Changes since V2:
> *Implemented the suggestion of MyungJoo Ham and used INFORM0/1
> registers for resume for some board versions.
> *Added back save/restore through CPU PM notifiers as suggested by
> Lorenzo Pieralisi. This is useful to restore vfp state.
> *some patch modularization (s5p/exynos) and proper commit logs.
>
> Changes since V1:
> *rebased the whole patch against 3.2-rc1 tree
> *removed GIC save/restore in AFTR cpuidle state as it is external
> to cpu powerdomain
> *Added L2 setup code through device tree
> *Removed only l2 save/restore registers in sleep
>
> This Patch series adds support for AFTR mode cpuidle state based on
> patch (http://www.spinics.net/lists/arm-kernel/msg132243.html) earlier
> submitted by Jaecheol Lee <jc.lee@samsung.com>.
>
> This patch uses CPU PM notifiers , common l2 save/restore and
> new cpu_suspend/resume interfaces and is based on the tip of
> for-next branch of samsung tree.
> (git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next).
>
> Amit Daniel Kachhap (6):
> ?ARM: exynos: Add support AFTR mode on EXYNOS4210
> ?ARM: s5p: remove useless churn in sleep.S
> ?ARM: exynos: save L2 settings during bootup
> ?ARM: s5p: add L2 early resume code
> ?ARM: exynos: remove useless code to save/restore L2
> ?ARM: exynos: Enable l2 configuration through device tree
>
> ?arch/arm/mach-exynos/cpu.c ? ? ? ? ? ? ?| ? 60 +++++++++---
> ?arch/arm/mach-exynos/cpuidle.c ? ? ? ? ?| ?152 ++++++++++++++++++++++++++++++-
> ?arch/arm/mach-exynos/include/mach/pmu.h | ? ?2 +
> ?arch/arm/mach-exynos/pm.c ? ? ? ? ? ? ? | ? 15 ---
> ?arch/arm/plat-s5p/sleep.S ? ? ? ? ? ? ? | ? 32 ++++++-
> ?5 files changed, 226 insertions(+), 35 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
