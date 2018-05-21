From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 22 May 2018 00:50:23 +0300
Subject: [PATCH 12/33] clk: bcm2835: use match_string() helper
In-Reply-To: <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
Message-ID: <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

> -       size_t i, j;
> -       int ret;
> +       int i, ret;

I do not see any need to change type for i.

> +               ret = match_string(cprman_parent_names,
> +                                  ARRAY_SIZE(cprman_parent_names),
> +                                  parents[i]);
> +               if (ret >= 0)
> +                       parents[i] = cprman->real_parent_names[ret];


-- 
With Best Regards,
Andy Shevchenko
