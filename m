From: amit.kachhap@linaro.org (amit kachhap)
Date: Tue, 3 Jan 2012 11:52:26 +0530
Subject: [PATCH V4 0/5] ARM: exynos: Add l2 retention mode cpuidle state
In-Reply-To: <1323083172-14096-1-git-send-email-amit.kachhap@linaro.org>
References: <1323083172-14096-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <CADGdYn7ZU5xiDvOLMR4wVHEWtF-2p86jNZFCOXMV6PrZXuLWbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr kim,

All the comments have been addressed for the Exynos cpu idle patchset.
The updated patchset was posted about one month back and there have
been no further comments on the patchset since then.

As this patchset seems to be stable now, do you think these these
patches can merged in this 3.3 merge window? Kindly let me know your
opinion.

Thanks,
Amit Daniel

On Mon, Dec 5, 2011 at 4:36 PM, Amit Daniel Kachhap
<amit.kachhap@linaro.org> wrote:
> Changes since V3:
> *Implemented Russell feedback and moved sleep magic 4byte memory before
> s3c_cpu_resume to data section.
>
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
> Amit Daniel Kachhap (5):
> ?ARM: exynos: Add support AFTR mode on EXYNOS4210
> ?ARM: exynos: save L2 settings during bootup
> ?ARM: s5p: add L2 early resume code
> ?ARM: exynos: remove useless code to save/restore L2
> ?ARM: exynos: Enable l2 configuration through device tree
>
> ?arch/arm/mach-exynos/cpu.c ? ? ? ? ? ? ?| ? 60 +++++++++---
> ?arch/arm/mach-exynos/cpuidle.c ? ? ? ? ?| ?152 ++++++++++++++++++++++++++++++-
> ?arch/arm/mach-exynos/include/mach/pmu.h | ? ?2 +
> ?arch/arm/mach-exynos/pm.c ? ? ? ? ? ? ? | ? 15 ---
> ?arch/arm/plat-s5p/sleep.S ? ? ? ? ? ? ? | ? 44 ++++++++-
> ?5 files changed, 233 insertions(+), 40 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
