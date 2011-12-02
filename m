From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 2 Dec 2011 18:23:39 +0900
Subject: [PATCH 3/4] ARM Exynos4210-Nuri: remove compiler errors
In-Reply-To: <04f901ccb0d0$b94191b0$2bc4b510$%kim@samsung.com>
References: <1322730317-8171-1-git-send-email-myungjoo.ham@samsung.com>
 <1322730317-8171-4-git-send-email-myungjoo.ham@samsung.com>
 <04f901ccb0d0$b94191b0$2bc4b510$%kim@samsung.com>
Message-ID: <CAJ0PZbTKgqgg3SZN3KyVFzGDuSU8qjM5NjwNcM28mtmzfbS0Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 2, 2011 at 5:59 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Hamm wrote:
>>
> What's the 'compiler errors'?
>
> And I don't know why this patch included in this series, maybe this should
> be separated from this series?

The error is:
arch/arm/mach-exynos/mach-nuri.c: In function ?nuri_power_init?:
arch/arm/mach-exynos/mach-nuri.c:1080:2: error: implicit declaration
of function ?irq_alloc_descs?
It is due to the recent changes in some of the header files (they
removed some header inclusion from header fiiles).

In this patchset, we are providing a test case (Exynos4210-Nuri) for
the device driver and we had to resolve the compiler error first.

Cheers!
MyungJoo


-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
