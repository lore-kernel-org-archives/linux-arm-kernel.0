From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 13:37:43 +0900
Subject: [PATCH 0/3] ARM: shmobile: sh-eth pins in DT for armadillo800eva
In-Reply-To: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
References: <1359043653-11374-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130125043743.GP13691@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 05:07:30PM +0100, Guennadi Liakhovetski wrote:
> This patch series gets rid of gpio_request()-style ethernet pin 
> configuration on armadillo800eva in reference implementation.

Hi Guennadi,

these changes seem to be reasonable to me.

Are there any dependencies for the sh_eth patch?
I assume this will be handled by David Miller through the net-next tree.
Are there any dependencies? The last time I checked the DT bindings
for sh_eth had not been merged.

For the remaining two patches, which I assume will go through my renesas
tree:
* Are there any dependencies that aren't satisfied by the of-intc branch?
* Could you get some Acks. At least from Laurent?

> Guennadi Liakhovetski (3):
>   pinctrl: add ethernet pin groups to r8a7740
>   ethernet: add a PHY reset GPIO DT binding to sh_eth
>   ARM: shmobile: move pin configuration on armadillo800eva-reference to
>     DT
> 
>  Documentation/devicetree/bindings/net/sh_ether.txt |    2 +
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |    7 ++++
>  .../board-armadillo800eva-reference.c              |   24 ---------------
>  drivers/net/ethernet/renesas/sh_eth.c              |    9 +++++-
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   31 ++++++++++++++++++++
>  5 files changed, 48 insertions(+), 25 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
