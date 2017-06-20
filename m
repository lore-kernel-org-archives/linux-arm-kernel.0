From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Jun 2017 10:45:17 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170615035407.GM13020@localhost>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io>
 <20170614083252.GK13020@localhost>
 <AD656BCC-5064-454F-9576-FA59283E0C45@aosc.io>
 <20170614084529.GL13020@localhost>
 <20170614090439.rkdaoo3uqzjqwuxq@flea.lan>
 <20170615035407.GM13020@localhost>
Message-ID: <20170620084517.giq3zhvbmhpx7pge@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 09:24:08AM +0530, Vinod Koul wrote:
> On Wed, Jun 14, 2017 at 11:04:39AM +0200, Maxime Ripard wrote:
> > On Wed, Jun 14, 2017 at 02:15:29PM +0530, Vinod Koul wrote:
> > > > SoC info is in compatible, so there's no reason to make it a property.
> > > 
> > > that's why it would need to be optional for the SoC's that needs these..
> > 
> > There's nothing optional about that behaviour, it's mandatory for the
> > SoC that need it, and useless on the SoC that don't.
> 
> And why should kernel put strings for each hw behaviour.

You will have strings in the kernel for each hw behaviour,
disregarding on whether you base the behaviour on the compatible or a
set of properties. In fact, you will have *much* more strings in the
kernel in the latter case.

> I am expecting DT to tell me if this SoC is a special case or not
> and kernel shall handle accordingly

How is this not the case here?

The DT tells you that this SoC is a special case through a compatible
already.

> > Plus, that would require changing the DT binding, which isn't
> > something we can do.
> 
> Any reason why bindings can't change..? I though this was support for new
> SoC...

No, this is a rework of an existing code to support a new SoC. The
code is already there, and the binding too. It has been for 3 years.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170620/88a09bac/attachment.sig>
