From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Apr 2016 15:52:38 +0200
Subject: [PATCH v2] pinctrl-exynos5440: Use off-stack memory for
 pinctrl_gpio_range
In-Reply-To: <1461117257-27048-1-git-send-email-andrew@aj.id.au>
References: <1461117257-27048-1-git-send-email-andrew@aj.id.au>
Message-ID: <CACRpkdYczBP58uS4nVpUGUevb7E+OCXmXA60SydigQo=AzX8Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 3:54 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> The range is registered into a linked list which can be referenced
> throughout the lifetime of the driver. Ensure the range's memory is useful
> for the same lifetime by adding it to the driver's private data structure.
>
> The bug was introduced in the driver's initial commit, which was present in
> v3.10.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Fixes: f0b9a7e521fa ("pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC")
> Cc: stable at vger.kernel.org
> ---
> Since v1:
>
> * Add range member kerneldoc addressing Tomasz Figa's comment

Patch applied with the ACKs.

Yours,
Linus Walleij
