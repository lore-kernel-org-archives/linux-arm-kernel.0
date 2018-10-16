From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 11:18:15 -0700
Subject: [PATCH] clk: rockchip: Fix static checker warning in
 rockchip_ddrclk_get_parent call
In-Reply-To: <20181016134144.12461-1-enric.balletbo@collabora.com>
References: <20181016134144.12461-1-enric.balletbo@collabora.com>
Message-ID: <153971389560.5275.17687261861802609299@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Enric Balletbo i Serra (2018-10-16 06:41:44)
> Fixes the signedness bug returning '(-22)' on the return type by removing the
> sanity checker in rockchip_ddrclk_get_parent(). The function should return
> and unsigned value only and it's safe to remove the sanity checker as the
> core functions that call get_parent like clk_core_get_parent_by_index already
> ensures the validity of the clk index returned (index >= core->num_parents).
> 
> Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
