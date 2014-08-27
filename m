From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Aug 2014 10:22:08 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140827074057.GS17528@sirena.org.uk>
References: <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
Message-ID: <20140827082208.GQ15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr?m wrote:
> 
> > It is not clear to me where the hardware resources should be listed in
> > DT, being it a simplefb node or part of the actual hardware device node
> > properly marked as dynamic boot defaults or something else? It's
> > somewhere inbetween hardware and virtual device, and somewhat volatile.
> > As far as simplefb is concerned it is a hardware desription of the
> > framebuffer, but for a kms driver it's no more than firmware handover of
> > boottime settings and ceases to exists once the kms driver have
> > reconfigured the hardware.
> 
> Is simplefb something that should be in the device tree distinctly in
> the first place - shouldn't it be a subset of the functionality of the
> video nodes?  It's the same hardware being driven differently.

Therorically, yes, but that would mean knowing beforehand what the
final binding will look like, even before submitting the driver. Since
the bindings are always reviewed, and most of the time changed
slightly, that wouldn't work very well with the DT as a stable ABI
policy I guess.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/5c253fd7/attachment.sig>
