From: dianders@chromium.org (Doug Anderson)
Date: Wed, 12 Nov 2014 13:49:18 -0800
Subject: [PATCH] clk: rockchip: ensure HCLK_VIO2_H2P and PCLK_VIO2_H2P
 stay enabled
In-Reply-To: <20141112213845.GA14153@dtor-ws>
References: <20141112213845.GA14153@dtor-ws>
Message-ID: <CAD=FV=UsYWDw0wB6KSANXZYnnBFdTL9wOEqf9DoUF8aFuDpNSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 12, 2014 at 1:38 PM, Dmitry Torokhov <dtor@chromium.org> wrote:
> Currently there is no driver owning these clocks and they have to stay
> up for the system to function properly, so let's mark them as
> CLK_IGNORE_UNUSED.
>
> Without this patch we have trouble with suspend/resume and we have
> trouble turning the eDP back on if it ever idles off.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm already on the signed-off-by (mostly because I tweaked the commit
message and tested this), but in case anyone cares I have reviewed
this and tested it.  ;)

...obviously we want to get to the bottom of the right way to handle
all of these clocks, but since we _just_ removed the blanket "leave
all clocks enabled" adding a few clocks back into the fold seems sane
until we get all our ducks in a row.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
