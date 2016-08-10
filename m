From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 10 Aug 2016 10:21:46 +0200
Subject: [PATCH v1 1/4] nvmem: rockchip-efuse: update compatible strings
 for Rockchip efuse
In-Reply-To: <1470811843-42668-2-git-send-email-finley.xiao@rock-chips.com>
References: <1470811843-42668-1-git-send-email-finley.xiao@rock-chips.com>
 <1470811843-42668-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <18634361.lkZvz8cT7b@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finley,

Am Mittwoch, 10. August 2016, 14:50:40 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Rk3399-efuse is organized as 32bits by 32 one-time programmable
> electrical fuses. The efuse of earlier SoCs are organized as
> 32bits by 8 one-time programmable electrical fuses with random
> access interface.
> 
> Add different device tree compatible string for different SoCs
> to be able to differentiate between the two.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt index
> 8f86ab3..8ec1b80 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> @@ -1,7 +1,11 @@
>  = Rockchip eFuse device tree bindings =
> 
>  Required properties:
> -- compatible: Should be "rockchip,rockchip-efuse"
> +- compatible: Should be one of the following.
> +	"rockchip,rk3066a-efuse" - for RK3066a SoCs.
> +	"rockchip,rk3188-efuse" - for RK3188 SoCs.
> +	"rockchip,rk3288-efuse" - for RK3288 SoCs.
> +	"rockchip,rk3399-efuse" - for RK3399 SoCs.
>  - reg: Should contain the registers location and exact eFuse size
>  - clocks: Should be the clock id of eFuse
>  - clock-names: Should be "pclk_efuse"

you cannot drop the old compatible that way. Please add a new section

Deprecated properties:
- compatible: "rockchip,rockchip-efuse"
  Old efuse compatible value compatible to rk3066a, rk3188 and rk3288 efuses

and move the old compatible there.


Thanks
Heiko
