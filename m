From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Nov 2014 22:26:19 -0500
Subject: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
In-Reply-To: <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141107032619.GD3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> The Armada 375 Z1 SoC revision is no longer supported. This commit
> removes the quirk needed for the thermal sensor.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
>  drivers/thermal/armada_thermal.c                     | 20 --------------------
>  2 files changed, 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index 4cf0249..4698e0e 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -5,17 +5,9 @@ Required properties:
>  - compatible:	Should be set to one of the following:
>  		marvell,armada370-thermal
>  		marvell,armada375-thermal
> -		marvell,armada375-z1-thermal
>  		marvell,armada380-thermal
>  		marvell,armadaxp-thermal
>  
> -		Note: As the name suggests, "marvell,armada375-z1-thermal"
> -		applies for the SoC Z1 stepping only. On such stepping
> -		some quirks need to be done and the register offset differs
> -		from the one in the A0 stepping.
> -		The operating system may auto-detect the SoC stepping and
> -		update the compatible and register offsets at runtime.
> -
>  - reg:		Device's register space.
>  		Two entries are expected, see the examples below.
>  		The first one is required for the sensor register;

I've no problem with removing support for the z1 stepping from the
kernel.  However, I don't think we should erase it from binding docs.
I'm not sure what the DT maintainers think is the appropriate action
here, but I'm thinking we could add a 'Deprecated' section at the end of
the doc and move these hunks there.  With a little rewording of course.

I'm primarily concerned about users with older dtbs looking to upgrade,
"Hey, wtf is marvell,armada375-z1-thermal?  I looked in the binding docs
and there's nothing there, do I replace it with marvell,armada375-thermal?"

thx,

Jason.
