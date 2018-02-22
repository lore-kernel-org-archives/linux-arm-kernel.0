From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 Feb 2018 00:18:15 +0900
Subject: [PATCH] pinctrl: samsung: Validate alias coming from DT
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
Message-ID: <CA+Ln22Hv=AawNquvGT=n4gxy7S=wOELPXX=c9NvzepmQjUVQqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-21 3:17 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Issue is present since first version of this driver so this should be
> backported as far as possible.
>
> Tested on Odroid HC1 (Exynos5422). Tests on S3C24xx, S3C64xx, Exynos
> ARM64 and any other chips are highly appreciated.
>
> Linus,
> I can take it through samsung/pinctrl tree and later send you again as
> pull request... or you can apply it directly as I do not have any other
> pinctrl patches queued so far.
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 56 +++++++++++++++++++----
>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 14 +++++-
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c      | 28 ++++++++++--
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c      |  7 ++-
>  drivers/pinctrl/samsung/pinctrl-samsung.c      | 61 ++++++++++++++++----------
>  drivers/pinctrl/samsung/pinctrl-samsung.h      | 40 ++++++++++-------
>  6 files changed, 154 insertions(+), 52 deletions(-)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks Geert for the report and Krzysztof for the patch.

Best regards,
Tomasz
