From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jul 2018 14:20:56 +0200
Subject: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos
 platform
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

Thanks for patch.

On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
> clk_summary do not show tmu_apbif clk enable, so replace
> the clk_prepare with clk_prepare_enables to enable tmu clk.

This is not valid reason to do a change. What is clk_summary does not
really matter. Your change has negative impact on power consumption as
the clock stays enabled all the time. This is not what we want... so
please explain it more - why you need the clock to be enabled all the
time? What is broken (clk_summary is not broken in this case)?

> simplify the enable of tmu_triminfo_apbif clk, also fixed
> the order of goto error for failed cases.

This has to be split into separate change.

Best regards,
Krzysztof
