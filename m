From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:34:38 -0600
Subject: [PATCH v2 2/6] dt-bindings: phy-rockchip-typec: move extcon
 property to be optional.
In-Reply-To: <20180301152515.20940-3-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-3-enric.balletbo@collabora.com>
Message-ID: <20180307193438.fogti4jodn2jgsb5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 04:25:11PM +0100, Enric Balletbo i Serra wrote:
> The extcon property is used to detect the cable-state but some boards
> just connect the type-c phy to a regular USB-A connector without any
> power-delivery and thus no controller reporting the cable-state.
> So the extcon property is not really a required property, move it to be
> optional instead.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
> Changes in v2:
> - [2/6] Rewrite the justification as suggested by Heiko Stuebner.
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 2 ++
>  1 file changed, 2 insertions(+)

And extcon should be deprecated IMO.

Reviewed-by: Rob Herring <robh@kernel.org>
