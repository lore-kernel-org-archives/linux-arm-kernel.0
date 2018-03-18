From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:52:12 -0500
Subject: [PATCH 1/8] drm/sun4i: Add compatible strings for A80 TCONs
In-Reply-To: <20180315114136.24747-2-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
 <20180315114136.24747-2-wens@csie.org>
Message-ID: <20180318030014.4rkxe4huxxhslj3v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 07:41:29PM +0800, Chen-Yu Tsai wrote:
> The A80 has 2 or 3 TCONs. The documentation and vendor kernel are very
> vague about the third TCON, to the point that it might not exist.
> 
> In the documentation, the first TCON is missing channel 1, and the
> second is missing channel 0. However the vendor kernel seems to be
> able to use them regardless. Here we model them like the old TCONs.
> 
> An oddity is that TCON0 requires the reset control for the eDP block
> to be deasserted, for any register access to stick.
> 
> This patch adds compatible strings for TCON0 and TCON1, with TCON0
> requiring an extra "edp" reset control.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
