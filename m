From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 May 2015 15:20:47 +0200
Subject: [PATCH][V2] pinctrl: mediatek: mtk-common: initialize unmask
In-Reply-To: <1429545557-3404-1-git-send-email-colin.king@canonical.com>
References: <1429545557-3404-1-git-send-email-colin.king@canonical.com>
Message-ID: <CACRpkdY8CX2aErL8jSGYwZrBn45QQo7jeND3xwMNm9g7Lh-UMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 5:59 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> cppcheck detected an uninitialized variable:
>
> [drivers/pinctrl/mediatek/pinctrl-mtk-common.c:897]:
>   (error) Uninitialized variable: unmask
>
> unmask should be initialized to zero to ensure unmasking
> only occurs if a previous mask occurred. The current situation
> is that the unmask variable could contain any random garbage
> causing random unexpected unmasking.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied for fixes.

Yours,
Linus Walleij
