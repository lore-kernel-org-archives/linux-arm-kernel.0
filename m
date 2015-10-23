From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 23 Oct 2015 05:21:58 +0000
Subject: [PATCH 2/2] can: xilinx: fix bug in bus error handling
In-Reply-To: <20151022163315.GI5257@xsjsorenbubuntu>
References: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
 <1445489163-11045-2-git-send-email-appanad@xilinx.com>
 <20151022163315.GI5257@xsjsorenbubuntu>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4F3593@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

> -----Original Message-----
> From: S?ren Brinkmann [mailto:soren.brinkmann at xilinx.com]
> Sent: Thursday, October 22, 2015 10:03 PM
> To: Appana Durga Kedareswara Rao
> Cc: Anirudha Sarangi; wg at grandegger.com; mkl at pengutronix.de; Michal
> Simek; Appana Durga Kedareswara Rao; linux-can at vger.kernel.org;
> netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH 2/2] can: xilinx: fix bug in bus error handling
> 
> On Thu, 2015-10-22 at 10:16AM +0530, Kedareswara rao Appana wrote:
> > Simply resetting the peripheral on bus off condition is not enough,
> > Because we also need to re-initialize the whole device.
> > This patch fixes this issue.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> >  drivers/net/can/xilinx_can.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/xilinx_can.c
> > b/drivers/net/can/xilinx_can.c index 055d6f3..9aeb85f 100644
> > --- a/drivers/net/can/xilinx_can.c
> > +++ b/drivers/net/can/xilinx_can.c
> > @@ -529,6 +529,8 @@ static int xcan_rx(struct net_device *ndev)
> >  	return 1;
> >  }
> >
> > +static void xcan_chip_stop(struct net_device *ndev);
> 
> Isn't it possible to move the function and avoid the forward declaration?

Yes it is possible to move the function will fix it in the next version of the patch.

Regards,
Kedar.

> 
> 	S?ren
