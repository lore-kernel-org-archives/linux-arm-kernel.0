From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2018 10:31:35 +0200
Subject: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
References: <20180606134338.4645-1-colin.king@canonical.com>
Message-ID: <CACRpkdZEawUiEU=qP+x7gTH5Sox9gH920ef7Cw-Y5-amxr9M2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2018 at 3:43 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
>
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Johan's and Tony's ACKs.

Yours,
Linus Walleij
