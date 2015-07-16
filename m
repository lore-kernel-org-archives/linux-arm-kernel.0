From: parkch98@gmail.com (Chanho Park)
Date: Thu, 16 Jul 2015 09:34:02 +0900
Subject: [RFC] ARM: EXYNOS: reset KFC cores when cpu is up
In-Reply-To: <55A618C6.3020603@osg.samsung.com>
References: <1436924213-29732-1-git-send-email-parkch98@gmail.com>
 <55A618C6.3020603@osg.samsung.com>
Message-ID: <CAPTzV15kQjrnJCuwXGBdzzY6rjP1495Q=PbuCYHic0JakxD2QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

> I believe of_machine_is_compatible("samsung,exynos5800") is preferred
> nowadays over soc_is_exynos5800().
>
> Now, is correct to do this for all Exynos5422/5800 based boards? AFAIU
> from the previous discussions, this behavior is specific to the Odroid
> XU3 so maybe of_machine_is_compatible("hardkernel,odroid-xu3") instead?
>
> I know this can affect other Exynos5800 boards that are shipped with a
> similar binary BL1/BL2 blobs that also use SPARE2 as a sync mechanism
> but maybe is better to add more exceptions later rather than do it for
> all Exynos5800?
>
> The Exynos5800 based Chromebook doesn't have this issue for example and
> all the 8 cores are brought up correctly.
>
> Having said that, I tested this patch on an Exynos5800 Peach Pi and all
> the 8 cores are up and also after a S2R so seems to be a no-op when the
> PMU_SPARE2 is not used for this.

Thanks for the testing. I'll find more proper way it could be applied
only for exynos5422 boards.

-- 
Best Regards,
Chanho Park
