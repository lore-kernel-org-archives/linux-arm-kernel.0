From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Wed, 27 Apr 2016 09:32:10 +0800
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <20160426231115.GB23273@kroah.com>
References: <20160408140701.GA3547@kroah.com>
 <Pine.LNX.4.44L0.1604081120190.2069-100000@iolanthe.rowland.org>
 <20160426231115.GB23273@kroah.com>
Message-ID: <1461720730.11651.4.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2016-04-26 at 16:11 -0700, Greg Kroah-Hartman wrote:
> On Fri, Apr 08, 2016 at 11:21:05AM -0400, Alan Stern wrote:
> > On Fri, 8 Apr 2016, Greg Kroah-Hartman wrote:
> > 
> > > On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
> > > > NULL pointer dereferrence will happen when class driver
> > > > wants to allocate zero length buffer and pool_max[0]
> > > > can't be used, so skip reserved pool in this case.
> > > 
> > > Why would a driver want to allocate a 0 length buffer?  What driver does
> > > this?
> > > 
> > > Shouldn't we fix that issue instead?
> > 
> > And even if a driver does want to allocate a 0-length buffer, shouldn't 
> > the function simply return early instead of running through all its 
> > calculations?
> 
> Yes it should, Chunfeng, can you fix this patch to do that please.
> 
Ok, I will fix it later

> thanks,
> 
> greg k-h
