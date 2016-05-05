From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 May 2016 15:59:58 -0700
Subject: [PATCH v7 7/9] dt-bindings: i2c: rk3x: add support for rk3399
In-Reply-To: <1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=XXojzZiVFuXuChZdDeTxE6tFSJZ=8FqLpVTG2L6xWpBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 4, 2016 at 7:35 AM, David Wu <david.wu@rock-chips.com> wrote:
> The bus clock and function clock are separated at rk3399,
> and others use one clock as the bus clock and function clock.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> index 0b4a85f..82b6f6b 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>  Required properties :
>
>   - reg : Offset and length of the register set for the device
> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
> -               "rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
> + - compatible: should be one of the followings
> +   - "rockchip,rk3066-i2c": for rk3066
> +   - "rockchip,rk3188-i2c": for rk3188
> +   - "rockchip,rk3228-i2c": for rk3228
> +   - "rockchip,rk3288-i2c": for rk3288
> +   - "rockchip,rk3399-i2c": for rk3399
>   - interrupts : interrupt number
> - - clocks : parent clock
> + - clocks: See ../clock/clock-bindings.txt
> +   - For older hardware (rk3066, rk3188, rk3228, rk3288):
> +     - There is one clock that's used both to derive the functional clock
> +       for the device and as the bus clock.  REQUIRED.
> +   - For newer hardware (rk3399): specify by name
> +     - "i2c": REQUIRED. This is used to derive the functional clock.
> +     - "pclk": REQUIRED. This is the bus clock.equired on RK3066, RK3188 :

Looks great except that you need to delete the "equired on RK3066,
RK3188 :" part, which looks like it was leftover from some sort of
copy/paste.

Once that is done, feel free to add my Reviewed-by tag.


-Doug
