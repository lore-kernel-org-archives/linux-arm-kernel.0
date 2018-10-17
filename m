From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 Oct 2018 15:35:31 +0200
Subject: [PATCH] clk: rockchip: Fix static checker warning in
 rockchip_ddrclk_get_parent call
In-Reply-To: <20181016134144.12461-1-enric.balletbo@collabora.com>
References: <20181016134144.12461-1-enric.balletbo@collabora.com>
Message-ID: <2363939.EMdi4fOIx9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Oktober 2018, 15:41:44 CEST schrieb Enric Balletbo i Serra:
> Fixes the signedness bug returning '(-22)' on the return type by removing the
> sanity checker in rockchip_ddrclk_get_parent(). The function should return
> and unsigned value only and it's safe to remove the sanity checker as the
> core functions that call get_parent like clk_core_get_parent_by_index already
> ensures the validity of the clk index returned (index >= core->num_parents).
> 
> Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to my clk-branch with Stephen's Review


Thanks
Heiko
