From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 21:15:10 -0700
Subject: [PATCH v7 11/11] clk: rockchip: add restart handler
In-Reply-To: <1408495538-27480-12-git-send-email-linux@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-12-git-send-email-linux@roeck-us.net>
Message-ID: <CAD=FV=U+WbodSLyQVQieiKkWNTBROCktJLgR9B8eOWZhGWYxgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter / Heiko,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> From: Heiko St?bner <heiko@sntech.de>
>
> Add infrastructure to write the correct value to the restart register and
> register the restart notifier for both rk3188 (including rk3066) and rk3288.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v7: Added patch to series.
>
>  drivers/clk/rockchip/clk-rk3188.c |  2 ++
>  drivers/clk/rockchip/clk-rk3288.c |  2 ++
>  drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  4 files changed, 30 insertions(+)

This patch doesn't apply cleanly with the in-flight (clk: rockchip:
protect critical clocks from getting disabled) patch from Heiko.  It's
trivial to resolve and unclear which will land first, so I think it's
fine...

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

(FYI: all patches tested by me were tested on rk3288-evb)
