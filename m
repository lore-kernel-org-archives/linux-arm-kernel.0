From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Fri, 14 Mar 2014 23:56:37 +0000
Subject: [PATCH 2/2] arm/xen: Don't use xen DMA ops when the device is
 protected by an IOMMU
In-Reply-To: <5323334F.90700@linaro.org>
References: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
 <1392914159.32657.18.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1402241214570.4471@kaball.uk.xensource.com>
 <20140224151636.GA13489@kroah.com>
 <alpine.DEB.2.02.1402242036490.31489@kaball.uk.xensource.com>
 <5323334F.90700@linaro.org>
Message-ID: <20140314235637.GA5687@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 04:50:23PM +0000, Julien Grall wrote:
> On 02/24/2014 08:49 PM, Stefano Stabellini wrote:
> > On Mon, 24 Feb 2014, gregkh at linuxfoundation.org wrote: 
> > Julien is proposing to store the list of "safe" devices on an hash table
> > in the Xen specific code (in arch/arm/xen/enlighten.c, see
> > http://marc.info/?l=linux-kernel&m=139291370526082&w=2).
> > Whenever Linux is about to do DMA, we would check in the hashtable to
> > figure out whether we need to go through the swiotlb or we can simply
> > use the native dma_ops.
> > 
> > Ian and I were thinking that it would be much easier and faster to have
> > a "xen_safe_device" parameter in struct device and just check for that.
> > It doesn't actually need to be in struct device, it could simply be a
> > flag in struct device_dma_parameters as Ian was suggesting.
> > 
> > Julien, could you please come up with a simple patch to demonstrate the
> > concept?
> 
> Hello Stefano and Greg,
> 
> Sorry for the late answer. I wrote a simple patch which depend on patch #1.
> Let me know if it's the right direction.

I have no context here, care to start the patch series over?

thanks,

greg k-h
