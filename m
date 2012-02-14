From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 14 Feb 2012 15:34:15 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120214060627.GB13456@opensource.wolfsonmicro.com>
References: <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
 <20120214013506.GA3276@b20223-02.ap.freescale.net>
 <20120214060627.GB13456@opensource.wolfsonmicro.com>
Message-ID: <20120214073414.GB3276@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:06:28PM -0800, Mark Brown wrote:
> On Tue, Feb 14, 2012 at 09:35:07AM +0800, Richard Zhao wrote:
> > On Sun, Feb 05, 2012 at 12:50:15PM +0800, Richard Zhao wrote:
> 
> > > no, it is asoc machine driver to have machine specific code. 
> > > the machine driver do not correspond to any hw device, which cause hard
> > > to bind dt or create platform device.
> 
> > I'll have to keep audmux driver in arch/, till ASOC machine driver
> > has a way to get platfrom parameters.
> 
> Machine drivers can easily get platform data, they're just regular
> drivers of whatever type so can get platform data in the same way that
> any other driver for their bus can.
Machine drivers don't correspond to any hw devices. If we create a
virtual platform device, it'll be hard for DT binding.

Thanks
Richard
