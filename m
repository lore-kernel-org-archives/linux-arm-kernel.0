From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 28 Dec 2014 23:19:24 +0100
Subject: [PATCH] clk: rockchip: fix rk3288 cpuclk core dividers
In-Reply-To: <1590307.oZ7E5cNY8h@phil>
References: <1590307.oZ7E5cNY8h@phil>
Message-ID: <6202678.ZafKNfsYJA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. Dezember 2014, 20:22:34 schrieb Heiko St?bner:
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

applied to my clk-fixes branch with fixed "Fixes"-Tag and Doug's review
