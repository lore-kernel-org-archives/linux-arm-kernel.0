From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Sat, 27 Dec 2014 00:54:44 +0900
Subject: [PATCH] clk: rockchip: fix rk3066 pll lock bit location
In-Reply-To: <2140322.FD0TUOM80V@phil>
References: <2140322.FD0TUOM80V@phil>
Message-ID: <CAFnsNoTnsG3JPxA9cYyxozofThn78VCZJjV2VhLKwsx2DDYhEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wed, Dec 24, 2014 at 11:11 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The bit locations indicating the locking status of the plls on rk3066 are
> shifted by one to the right when compared to the rk3188, bits [7:4] instead
> of [8:5] on the rk3188, thus indicating the locking state of the wrong pll
> or a completely different information in case of the gpll.
>
> The recently introduced pll init code exposed that problem on some rk3066
> boards when it tried to bring the boot-pll value in line with the value
> from the rate table.
>
> Fix this by defining separate pll definitions for rk3066 with the correct
> locking indices.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3188.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

it worked fine on ChipSPARK Rayeager PX2(=RK3066) board, thanks!

Tested-by: FUKAUMI Naoki <naobsd@gmail.com>
