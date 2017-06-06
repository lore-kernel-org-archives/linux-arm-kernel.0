From: rafalo@cadence.com (Rafal Ozieblo)
Date: Tue, 6 Jun 2017 08:54:50 +0000
Subject: [PATCH v2 4/4] net: macb: Add hardware PTP support
In-Reply-To: <20170604205516.GA7848@localhost.localdomain>
References: <1496413439-12900-1-git-send-email-rafalo@cadence.com>
 <1496413690-22826-1-git-send-email-rafalo@cadence.com>
 <20170604205516.GA7848@localhost.localdomain>
Message-ID: <BN3PR07MB251673623B941CAF5DEAB474C9CB0@BN3PR07MB2516.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: 4 czerwca 2017 22:55
> To: Rafal Ozieblo <rafalo@cadence.com>
> Cc: David Miller <davem@davemloft.net>; nicolas.ferre at atmel.com;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> harini.katakam at xilinx.com; andrei.pistirica at microchip.com
> Subject: Re: [PATCH v2 4/4] net: macb: Add hardware PTP support
> 
> On Fri, Jun 02, 2017 at 03:28:10PM +0100, Rafal Ozieblo wrote:
> 
> > +int gem_get_hwtst(struct net_device *dev, struct ifreq *rq)
> > +{
> > +	struct macb *bp = netdev_priv(dev);
> > +	struct hwtstamp_config *tstamp_config = &bp->tstamp_config;
> > +
> > +	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
> > +		return -EFAULT;
> 
> Segmentation fault?  Really?
> 
> ...
> 
> > +int gem_set_hwtst(struct net_device *dev, struct ifreq *ifr, int cmd)
> > +{
> > +	struct macb *bp = netdev_priv(dev);
> > +	struct hwtstamp_config *tstamp_config = &bp->tstamp_config;
> > +	enum macb_bd_control tx_bd_control = TSTAMP_DISABLED;
> > +	enum macb_bd_control rx_bd_control = TSTAMP_DISABLED;
> > +	u32 regval;
> > +
> > +	if ((bp->hw_dma_cap & HW_DMA_CAP_PTP) == 0)
> > +		return -EFAULT;
> 
> here again
Would "ENOTSUP" be sufficient ?

> 
> Thanks,
> Richard

Regards,
Rafal
