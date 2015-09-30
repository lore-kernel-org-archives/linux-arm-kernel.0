From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Sep 2015 14:24:28 +0800
Subject: [RESEND PATCH v3 0/5] usb: change clock information for chipidea
In-Reply-To: <20150930052835.GC18468@tiger>
References: <1443579925-1330-1-git-send-email-peter.chen@freescale.com>
 <20150930052835.GC18468@tiger>
Message-ID: <20150930062427.GA1665@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 01:28:36PM +0800, Shawn Guo wrote:
> On Wed, Sep 30, 2015 at 10:25:20AM +0800, Peter Chen wrote:
> > This patch set changes usb clock information for legacy i.mx platforms.
> > At these platforms, they needs three clocks to let controller work.
> > 
> > Hi Shawn,
> > 
> > Fabio has tested for both imx27 and imx25 platforms.
> > I have queued 1/5 and 5/5, would you please help to queue others,
> > thanks.
> > 
> > Changes for v3:
> > - Delete property "needs-three-clocks", and using of_device_id->data
> >   to differentiate platforms
> > - change <stable@vger.kernel.org> #v3.19+ to <stable@vger.kernel.org> #v4.1+
> 
> So the last patch will be sent as a fix with stable on copy?

Yes

> In that
> case, will USB driver just work without corresponding DTS change?  Or
> the driver change has a dependency on the DTS change?
> 

At v4.1, One of USB driver changes break i.mx27's USB function.
The driver's change at patch 5/5 is also tagged for stable tree,
so it needs both DTS and driver's change to let i.mx27 USB work from
v4.1.

-- 

Best Regards,
Peter Chen
