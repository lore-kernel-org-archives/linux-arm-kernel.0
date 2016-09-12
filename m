From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2016 14:29:37 +0200
Subject: [PATCH v2 3/3] gpio: mxc: add generic gpio request/free callbacks
 to pinctrl
In-Reply-To: <1473299296-22458-4-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1473299296-22458-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1473299296-22458-4-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <CACRpkdYL4PR1AYGhuT7rLZv3xepk1pqJ=Gg4MhUU+CPsCaJvMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 3:48 AM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:

> If a GPIO controller description in board DTB contains information
> about mappings between GPIOs and pads under IOMUX control use it to
> request and free GPIOs with respect to pinctrl/pinmux subsystems.
>
> One of immediate positive functional changes is inability to
> request non-existing GPIOs, i.e. if there is no pad such. Also
> pinctrl/pinmux may now properly account pads occupied by requested
> GPIOs.
>
> The change has no effect, if "gpio-ranges" property is not found
> including the case if a board has no DTB firmware.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> Changes from v1 to v2:
> * none

Patch applied with Shawn's ACK.

Yours,
Linus Walleij
