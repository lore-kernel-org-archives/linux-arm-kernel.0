From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 10:55:20 -0600
Subject: [RFC PATCH] tty/serial: atmel_serial: add device tree support
In-Reply-To: <4E8B054B.3060506@gmail.com>
References: <1317635502-9430-1-git-send-email-nicolas.ferre@atmel.com>
	<4E8A6858.6020700@gmail.com> <4E8AC171.4020706@atmel.com>
	<4E8B054B.3060506@gmail.com>
Message-ID: <20111004165520.GB10919@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 08:08:27AM -0500, Rob Herring wrote:
> Nicolas,
> 
> On 10/04/2011 03:18 AM, Nicolas Ferre wrote:
> > On 10/04/2011 03:58 AM, Rob Herring :
> >> On 10/03/2011 04:51 AM, Nicolas Ferre wrote:
> >>> +Optional properties:
> >>> +- atmel,use-dma-rx: use of PDC or DMA for receiving data
> >>> +- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> >>
> >> Is this an internal DMA or separate DMA controller? If the latter, these
> >> should be phandles to a DMA channel/request.
> > 
> > Well, for now it relies on PDC (looks like an internal DMA). There is no
> > notion of channel/request so I think it is appropriate to keep it like this.
> > 
> 
> Okay. Although, this is a bit of Linux creeping into DT. DT should
> describe the h/w. You should really be describing whether the h/w
> supports DMA or not rather than whether you want to use DMA or not.
> Since DMA support is really tied to the SOC rather than board, you could
> just use the compatible string to distinguish platforms that support DMA
> or not. So what is determining this setting? Is it purely user choice?

It is okay for a binding to still requires config properties like this
to state if the DMA can be used, even if compatible is enough to
distinquish.  However, you're right to bring it up.  It is a design
choice that should be made thoughtfully.

g.
