From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Aug 2014 10:57:07 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <53DB490A.5040709@metafoo.de>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <53DA3A48.8070900@metafoo.de> <20140731161331.GD3952@lukather>
 <53DA74B3.6060502@metafoo.de> <20140731173730.GH3952@lukather>
 <53DB490A.5040709@metafoo.de>
Message-ID: <20140801085707.GI3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 10:00:10AM +0200, Lars-Peter Clausen wrote:
> On 07/31/2014 07:37 PM, Maxime Ripard wrote:
> >On Thu, Jul 31, 2014 at 06:54:11PM +0200, Lars-Peter Clausen wrote:
> >>On 07/31/2014 06:13 PM, Maxime Ripard wrote:
> >>[...]
> >>> From what you're saying, and judging from the drivers that already
> >>>implement it, can't it be moved directly to the framework itself ?
> >>>
> >>
> >>What exactly do you mean by moving it directly to the framework? The
> >>slave_caps API is part of the DMAengine framework.
> >
> >Not its implementation, which is defined by each and every driver,
> >while the behaviour of device_slave_caps is rather generic.
> >
> 
> Do you mean something like adding a dma_slave_caps struct field to
> the DMA channel that gets initialized when the channel is created
> and then remove the callback? That makes some sense.

I was rather thinking into something like:
  - Splitting device_control into independant functions
  - Then, knowing if you support pause/resume/terminate is trivial:
    either you implement the callback, or you don't
  - Putting the supported width and direction into fields of struct
    dma_device, which can eventually be used by the framework to
    filter out invalid configurations before calling the relevant
    callbacks
  - That would then be trivial to get from the framework, without
    calling any callback

> I think the main reason why we use a callback right now is that in
> earlier revisions of the API it was possible to pass a slave_config
> and the result would be the capabilities of the DMA channel for this
> particular config. But this was dropped before the final version was
> merged upstream.

Ah, that would explain yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/29c7db8a/attachment.sig>
