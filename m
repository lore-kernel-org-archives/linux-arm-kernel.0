From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jul 2015 22:14:03 +0200
Subject: [PATCH 04/13] pinctrl: tegra: Only set the gpio range if needed
In-Reply-To: <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CACRpkdY1PPTvuF1ntiybGYoN8nHD7dojtuuJkKpUPXNjBpK1nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 3:42 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:

> If the gpio DT node has the gpio-ranges property, the range will be
> added by the gpio core and doesn't need to be added by the pinctrl
> driver.
>
> By having the gpio-ranges property, we have an explicit dependency from
> the gpio node to the pinctrl node and we can stop using the deprecated
> pinctrl_add_gpio_range() function.
>
> Note that when the GPIO device gets probed before the associated
> princtrl device, the gpio core actually won't register the gpio range.
> Thus, this patch is only safe to be merged after we have in place a way
> to assure that gpio devices are probed after their associated pinctrl
> devices (such as ordered probing).
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

This doesn't look like it would hurt, but need Stephen's opinion
on it, and I think he's on vacation. Would check with next-in-line
Tegra maintainer, Thierry/Alexandre?

Yours,
Linus Walleij
