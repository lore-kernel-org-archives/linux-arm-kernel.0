From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 19:12:13 +0200
Subject: [PATCH-RFT 2/2] pinctrl: samsung: Split Exynos drivers per ARMv7
 and ARMv8
In-Reply-To: <20170516200649.4730-3-krzk@kernel.org>
References: <20170516200649.4730-1-krzk@kernel.org>
 <20170516200649.4730-3-krzk@kernel.org>
Message-ID: <CACRpkdbfNu0SHPsPoRzAj2by3HGBcGwD2jLKr1sUHEA2scnyQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 10:06 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Exynos pinctrl drivers contain pretty big per-SoC data structures.  The
> pinctrl-exynos object file contained code and data for both ARMv7 and
> ARMv8 SoCs thus it grew big.  There will not be a shared image between
> ARMv7 and ARMv8 so there is no need to combine all of this into one
> driver.
>
> Splitting the data allows to make it more granular (e.g. code related to
> ARMv8 Exynos is self-contained), slightly speed up the compilation and
> reduce the effective size of compiled kernel.
>
> The common data structures and functions reside still in existing
> pinctrl-exynos.c.  Only the SoC-specific parts were moved out to new
> files.  Except marking few functions non-static and adding them to
> header, there were no functional changes in the code.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
I guess I will get this from you with a pull request?

Yours,
Linus Walleij
