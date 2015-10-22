From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 22 Oct 2015 09:33:15 -0700
Subject: [PATCH 2/2] can: xilinx: fix bug in bus error handling
In-Reply-To: <1445489163-11045-2-git-send-email-appanad@xilinx.com>
References: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
 <1445489163-11045-2-git-send-email-appanad@xilinx.com>
Message-ID: <20151022163315.GI5257@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-22 at 10:16AM +0530, Kedareswara rao Appana wrote:
> Simply resetting the peripheral on bus off condition is not enough,
> Because we also need to re-initialize the whole device.
> This patch fixes this issue.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
>  drivers/net/can/xilinx_can.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 055d6f3..9aeb85f 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -529,6 +529,8 @@ static int xcan_rx(struct net_device *ndev)
>  	return 1;
>  }
>  
> +static void xcan_chip_stop(struct net_device *ndev);

Isn't it possible to move the function and avoid the forward
declaration?

	S?ren
