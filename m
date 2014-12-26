From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Dec 2014 22:23:26 +0100
Subject: [PATCH] clk: rockchip: fix rk3066 pll lock bit location
In-Reply-To: <2140322.FD0TUOM80V@phil>
References: <2140322.FD0TUOM80V@phil>
Message-ID: <2847519.2sf188msm1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. Dezember 2014, 15:11:00 schrieb Heiko St?bner:
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

applied to my clk-fixes branch with naobsd's tested-by.

I've also received another positive response of the patch fixing the issue on 
IRC.


Heiko
