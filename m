From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Dec 2012 09:29:44 +0100
Subject: [PATCH 02/10] SH: intc: Add support OF of IRQ
In-Reply-To: <1355562224-29448-3-git-send-email-horms+renesas@verge.net.au>
References: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
 <1355562224-29448-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2838757.yMqfipzqR7@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iwamatsu-san,

Thank your for the patch.

On Saturday 15 December 2012 18:03:36 Simon Horman wrote:
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> Add information of device node to struct intc_desc.
> 
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v7
> * Delete "renesas,sh_intcs" and "renesas,sh_intca_irq_pins" as compatible.
>   Update their documentation.
> * Remove of_sh_intc_get_meminfo() and of_sh_intc_get_pint and
>   of_sh_intc_get_intc(). They are not used.
> 
> v2 - v6
> * No change
> ---
>  Documentation/devicetree/bindings/sh/intc.txt |   15 +----
>  drivers/sh/intc/core.c                        |    2 +-
>  drivers/sh/intc/internals.h                   |    3 +-
>  drivers/sh/intc/irqdomain.c                   |    6 +-
>  drivers/sh/intc/of_intc.c                     |   76 ----------------------
>  include/linux/sh_intc.h                       |   29 +---------
>  6 files changed, 9 insertions(+), 122 deletions(-)

Shouldn't this be squashed into patch 01/10 ? 01/10 adds DT bindings support, 
and you already modify them in this patch.

-- 
Regards,

Laurent Pinchart
