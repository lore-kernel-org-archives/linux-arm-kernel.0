From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 7 Sep 2018 10:56:45 +0200
Subject: [PATCH v2] usb: xhci: fix interrupt transfer error happened on
 MTK platforms
In-Reply-To: <1536309826.32173.45.camel@mhfsdcap03>
References: <e8698cc5710a9d1f25e33e2201e2177bfbfec75c.1536305256.git.chunfeng.yun@mediatek.com>
 <20180907074251.GA2079@kroah.com>
 <1536309826.32173.45.camel@mhfsdcap03>
Message-ID: <20180907085645.GA17270@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 04:43:46PM +0800, Chunfeng Yun wrote:
> Hi,
> 
> On Fri, 2018-09-07 at 09:42 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 07, 2018 at 03:29:12PM +0800, Chunfeng Yun wrote:
> > > The MTK xHCI controller use some reserved bytes in endpoint context for
> > > bandwidth scheduling, so need keep them in xhci_endpoint_copy();
> > 
> > If they are "reserved" shouldn't they be properly named?  And by using
> > reserved bytes, isn't that a spec violation?
> It indeed violates the spec, "they shall be treated by system software
> as Reserved and Opaque", and it's a quirk of the MTK xHCI controller.

So as the "system software" here, we should just ignore them otherwise
we violate the spec?  :)

Anyway, that's fine, no objection from me for the patch, thanks.

greg k-h
