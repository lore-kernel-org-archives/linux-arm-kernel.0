From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Aug 2015 14:38:20 +0200
Subject: [PATCH v4] pinctrl: mediatek: Fix multiple registration issue.
In-Reply-To: <1440549165-35637-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1440549165-35637-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZThvKa2sCC5HE_=nQXc0nTD7t-EkGwm6Lq8AUqUUjGFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 2:32 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Since our common driver need support main chip and PMU
> at the same time, that means it will register two
> pinctrl device, and the pinctrl_desc structure should
> be used two times.
>
> But pinctrl_desc use global static definition, then
> the latest registered pinctrl device will overwrite
> the old one's, all members in pinctrl_desc will set to
> the new one's, such as name, pins and pins numbers, etc.
> This is a bug.
>
> Move pinctrl_desc into mtk_pinctrl, assign new value for
> each pinctrl device to fix it.
>
> Cc: stable at vger.kernel.org # v4.1+
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> Reviewed-by: Axel Lin <axel.lin@ingics.com>
> ---
>  In order to fix multiple registration issue, move
>  pinctrl_desc into mtk_pinctrl, assign new value for
>  each pinctrl device.

This patch applied.

Yours,
Linus Walleij
