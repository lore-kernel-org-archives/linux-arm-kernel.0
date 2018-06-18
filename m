From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 18 Jun 2018 20:37:50 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
In-Reply-To: <20180618174216.24801-2-krzk@kernel.org>
References: <20180618174216.24801-1-krzk@kernel.org>
 <20180618174216.24801-2-krzk@kernel.org>
Message-ID: <20180618183750.elfphari7vw2v2sl@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 07:42:16PM +0200, Krzysztof Kozlowski wrote:
> The decon, decon_tv and dsi nodes have only one child port so
> address/size mappings are not necessary.  This fixes DTC warnings like:
> 
>     Warning (graph_child_address): /soc/decon at 13800000/ports:
>         graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
>  2 files changed, 3 insertions(+), 15 deletions(-)

The patch 1/2 should not have any impact but this one could have and I forgot
to mention that it was not tested.  If someone could provide testing, it
would be highly appreciated.

Best regards,
Krzysztof
