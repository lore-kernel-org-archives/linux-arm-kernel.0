From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Jan 2015 15:30:13 -0800
Subject: [PATCH 2/3] clk: rockchip: add a dummy clock for the watchdog
 pclk on rk3288
In-Reply-To: <40627478.oB4De9HGiG@phil>
References: <1736604.toH3biuFW2@phil>
	<40627478.oB4De9HGiG@phil>
Message-ID: <CAD=FV=UhOAdCZNKdKu3d-gj4JB9Vcf+D3bJJ2_SMrfj_k4NmKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jan 21, 2015 at 11:56 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The pclk supplying the watchdog is controlled via the SGRF register area.
> Currently we don't have any clock-type handling external clock bits like
> this one. Additionally the SGRF isn't even writable in every boot mode.
>
> But still the clock control is available and in the future someone might
> want to use it. Therefore define a simple clock for the time being so
> that the watchdog driver can read its rate.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>

On rk3288 on a 3.14 kernel with backports, I tested this and confirmed
that the clock rate was right (when programmed to ~43 seconds, the
watchdog caused a reboot when not patted for ~43 seconds).

Tested-by: Doug Anderson <dianders@chromium.org>
