From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Dec 2014 14:16:49 -0800
Subject: [PATCH] clk: rockchip: fix rk3288 cpuclk core dividers
In-Reply-To: <1590307.oZ7E5cNY8h@phil>
References: <1590307.oZ7E5cNY8h@phil>
Message-ID: <CAD=FV=Uww1g4zb5WPRBMXSYEFSTz6dnZHRcqd6Fy+gbgQiy=yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Dec 18, 2014 at 11:22 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Commit 0e5bdb3f9fa5 (clk: rockchip: switch to using the new cpuclk type
> for armclk) didn't take into account that the divider used on rk3288
> are of the (n+1) type.
>
> The rk3066 and rk3188 socs use more complex divider types making it
> necessary for the list-elements to be the real register-values to write.
>
> Therefore reduce divider values in the table accordingly so that they
> really are the values that should be written to the registers.
>
> Reported-by: Sonny Rao <sonnyrao@chromium.org>
> Fixes: 0e5bdb3f9fa5
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: stable at vger.kernel.org
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Looks right to me:

Reviewed-by: Doug Anderson <dianders@chromium.org>

I've done basic testing on this and saw no problems, but I haven't
done stress testing yet...
