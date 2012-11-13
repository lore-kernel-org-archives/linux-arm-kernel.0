From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 13 Nov 2012 13:03:30 -0600
Subject: [PATCH] arm: zynq: add system level control register manager
In-Reply-To: <39e6578d-01c8-4a05-8819-e089454c139a@CO9EHSMHS017.ehs.local>
References: <20121031183610.GA2603@thinkbox> <20121108160125.GA5550@kryptos>
 <5b1971ea-9ad9-4f58-841e-a3efb7cf905d@CO1EHSMHS022.ehs.local>
 <20121113183338.GJ1718@beefymiracle.amer.corp.natinst.com>
 <39e6578d-01c8-4a05-8819-e089454c139a@CO9EHSMHS017.ehs.local>
Message-ID: <20121113190330.GL1718@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 06:42:42PM +0000, John Linn wrote:
> > -----Original Message-----
> > From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> > Sent: Tuesday, November 13, 2012 10:34 AM
> > To: Michal Simek
> > Cc: Josh Cartwright; Daniel Borkmann; Arnd Bergmann; linux-arm-kernel at lists.infradead.org; John Linn
> > Subject: Re: [PATCH] arm: zynq: add system level control register manager
> > 
> > On Mon, Nov 12, 2012 at 11:35:46AM +0000, Michal Simek wrote:
> > > >    3. Figure out MIO pinctrl support and bindings (?)
> > >
> > > We will look at this topic more closely.
> >
> > For some clarification: are you (or someone at Xilinx) actively looking
> > at this?
>
> Hi Josh,
>
> No one is looking at it that I know of (other than maybe Michal). Our
> previous thinking was that this was low priority as the first stage
> boot loader sets up the MIO prior to the kernel running. U-boot needs
> the MIO setup for some set of devices also.
>
> I don't know the use cases for dynamic MIO, or I'm just
> misunderstanding what the pinctrl really does. Do designers often
> build a board to deal with being able use the pins for multiple
> purposes?

I'm less concerned about dynamic (runtime) MIO configuration.  What I
would personally like to see put into place before the peripherals are
moved over is for the MIO configuration to be explicitly modelled in the
device tree, instead of implicitly in the u-boot/kernel handoff as you
have described.

I think that also means the logic to commit whatever MIO configuration
described in the device tree to hardware would be there, too.

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/e4664d1c/attachment.sig>
