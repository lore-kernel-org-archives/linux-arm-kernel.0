From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 11:13:15 -0700
Subject: [PATCH v2] ARM: rockchip: convert smp bringup to
 CPU_METHOD_OF_DECLARE
In-Reply-To: <1878147.CvhHSZhTas@diego>
References: <1632873.urGeGsUMPH@diego>
 <20140326110024.GR10341@e106331-lin.cambridge.arm.com>
 <2151573.evmqdkWnet@diego> <1878147.CvhHSZhTas@diego>
Message-ID: <20140526181315.GA27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 01:06:32AM +0100, Heiko St?bner wrote:
> With the newly introduced CPU_METHOD_OF_DECLARE is not necessary anymore
> to reference the relevant smp_ops in the board file, but instead it can
> simply be set by the enable-method property of the cpu nodes.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied, however:

> ---
> changes since v1:
>   - add a short description to the enable-method binding
> 
>  Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>  arch/arm/boot/dts/rk3066a.dtsi                 | 1 +
>  arch/arm/boot/dts/rk3188.dtsi                  | 1 +
>  arch/arm/mach-rockchip/core.h                  | 2 --
>  arch/arm/mach-rockchip/platsmp.c               | 3 ++-
>  arch/arm/mach-rockchip/rockchip.c              | 1 -
>  6 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 333f4ae..f52a9ac 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "rockchip,rk3066-smp" - cpu-core handling of Socs
> +					from Rockchip starting with rk3066

Nobody else has a comment here, so I removed this one.

I noticed that the list is unsorted, in particular the new marvell entries were
appended instead of inserted at the right location, which caused a merge
conflict. Sigh. I'll do a separate commit on top to sort the list, since
we seem to have the new out-of-order additions in our tree.


-Olof
