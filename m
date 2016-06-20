From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 20 Jun 2016 15:35:47 +0200
Subject: [PATCH 1/3] clk: samsung: exynos5433: prepare for adding CPU
 clocks
In-Reply-To: <CA+Ln22GmeuHaNwpHOMxP0SA9-KaJp4D4sM5aF3bVRWm5Xb72fA@mail.gmail.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-2-git-send-email-b.zolnierkie@samsung.com>
 <CA+Ln22GmeuHaNwpHOMxP0SA9-KaJp4D4sM5aF3bVRWm5Xb72fA@mail.gmail.com>
Message-ID: <1687314.R0ikIvAotG@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tomasz,

On Saturday, June 18, 2016 11:40:05 PM Tomasz Figa wrote:
> Hi Bartlomiej,
> 
> 2016-05-24 22:19 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> > Open-code samsung_cmu_register_one() calls for CMU_APOLLO and
> > CMU_ATLAS setup code as a preparation for adding CPU clocks
> > support for Exynos5433.
> 
> Why do we need to open code it? Even if it's really necessary, it

We want to register CPU clock before calling samsung_clk_sleep_init()
and samsung_clk_of_add_provider() (just as we do it on other Exynos
SoCs) so we cannot use samsung_cmu_register_one() helper.

> would make sense to state it in the commit description for lazy
> readers reviewing the patches in order. :)

Right, sorry about that.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
