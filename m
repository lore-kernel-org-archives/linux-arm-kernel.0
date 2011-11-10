From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 10 Nov 2011 14:52:24 +0900
Subject: [PATCH 1/3] ARM: EXYNOS: Add ASV feature for Exynos4 series
In-Reply-To: <1319677938-25732-2-git-send-email-boyko.lee@samsung.com>
References: <1319677938-25732-1-git-send-email-boyko.lee@samsung.com>
 <1319677938-25732-2-git-send-email-boyko.lee@samsung.com>
Message-ID: <CAJ0PZbTHmgAkLuSRJfmkKr_uTCD+YqAj3q10SMg9XkziR6i_ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 10:12 AM, Jongpill Lee <boyko.lee@samsung.com> wrote:
> This patch adds ASV feature for exynos4 seires.
> Asv(Adoptive support voltage) feature support to get spec of SoC.
> And we can use to adjust voltage for operation SoC usign by ASV result.
>
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> ---
> ?arch/arm/mach-exynos4/Makefile ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-exynos4/asv.c ? ? ? ? ? ? ?| ? 78 ++++++++++++++++++++++++++++++
> ?arch/arm/mach-exynos4/include/mach/asv.h | ? 42 ++++++++++++++++
> ?3 files changed, 121 insertions(+), 1 deletions(-)
> ?create mode 100644 arch/arm/mach-exynos4/asv.c
> ?create mode 100644 arch/arm/mach-exynos4/include/mach/asv.h
>

Hello,


As long as we have <mach/asv.h> in our hands, we can have the ASV
value stored at the common place declared by this asv.h rather than at
INFORM2 as I've mentioned before at another thread. This location
<mach/asv.h> seems the perfect location for the purpose. Besides, now,
with Exynos4x12s, I start to hear cases where all the INFORMx
registers are fully used; thus, it seems that it's time to remove
unnecessary usage of the registers.



Cheers!
MyungJoo

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
