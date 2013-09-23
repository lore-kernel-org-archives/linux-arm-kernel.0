From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 23 Sep 2013 14:32:40 +0200
Subject: [PATCH] DT: S5P: If detected device tree skip irq init
In-Reply-To: <1379931222-29307-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379931222-29307-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <1623257.C2BrDo7kio@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 of September 2013 12:13:42 Mateusz Krawczuk wrote:
> It prevents from executing code already called by device tree.

I'd say that it prevents from executing code handling things that, when 
booting with device tree, are already handled by other code, namely the 
pinctrl-exynos driver.

> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/s5p-irq-eint.c | 4 ++++
>  1 file changed, 4 insertions(+)

Otherwise, after fixing commit message:

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
