From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Mon, 31 Oct 2016 09:28:56 +0000
Subject: [v15, 6/7] base: soc: introduce soc_device_match() interface
In-Reply-To: <2572890.e6aV4hmMEL@wuerfel>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-7-git-send-email-yangbo.lu@nxp.com>
 <2572890.e6aV4hmMEL@wuerfel>
Message-ID: <DB6PR0401MB2536CAD001BF3CAB4EDB15DCF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, October 28, 2016 6:48 PM
> To: linuxppc-dev at lists.ozlabs.org
> Cc: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Scott
> Wood; Mark Rutland; Greg Kroah-Hartman; X.B. Xie; M.H. Lian; linux-
> i2c at vger.kernel.org; linux-clk at vger.kernel.org; Qiang Zhao; Russell King;
> Bhupesh Sharma; Joerg Roedel; Claudiu Manoil; devicetree at vger.kernel.org;
> Rob Herring; Santosh Shilimkar; linux-arm-kernel at lists.infradead.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Leo Li;
> iommu at lists.linux-foundation.org; Kumar Gala; Geert Uytterhoeven
> Subject: Re: [v15, 6/7] base: soc: introduce soc_device_match() interface
> 
> On Friday, October 28, 2016 2:50:17 PM CEST Yangbo Lu wrote:
> > +
> > +static int soc_device_match_one(struct device *dev, void *arg) {
> > +       struct soc_device *soc_dev = container_of(dev, struct
> soc_device, dev);
> > +       const struct soc_device_attribute *match = arg;
> > +
> > +       if (match->machine &&
> > +           !glob_match(match->machine, soc_dev->attr->machine))
> > +               return 0;
> > +
> > +       if (match->family &&
> > +           !glob_match(match->family, soc_dev->attr->family))
> > +               return 0;
> > +
> >
> 
> Geert found a bug in my code, and submitted a fix at
> https://patchwork.kernel.org/patch/9361395/
> 
> I think you should include that one in your series.
> 

[Lu Yangbo-B47093] Ok, no problem. Thanks :)

> 	Arnd
