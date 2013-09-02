From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 17:27:29 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902141631.GV6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
Message-ID: <20130902162729.GT3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 03:16:31PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 03:06:32PM +0100, Mark Brown wrote:

> > Yes, and this is one of the reasons for suggesting getting either/or
> > support merged - it will help things like the binding definition
> > progress (as well as being useful for any users with a S/PDIF only
> > system).

> Sorry, but I believe the exact opposite:

> 1. The DAI link binding created for a dual-DAI driver is completely
>    different from the DAI link binding for a DPCM driver.  The dual
>    DAI link binding will have to be completely rewritten when the
>    driver is converted to DPCM.

That seems like overstating the difficulties.  The updates for any new
S/PDIF drivers will be pretty much the same as those for the existing
I2S drivers and should just be mechanical changes, nothing too taxing.

> 2. When the driver is converted to DPCM, it must use DPCM for
>    everything, otherwise it has no way to know which of SPDIF or I2S to
>    enable.  The only way I know to work around that is to add additional
>    routes to link up the AIF widgets, and that's the solution you're all
>    telling me is not acceptable, as per the patch set at the start of
>    this thread.

What we have been telling you is that if there is a DAI link present
(there should be one for each physical DAI link) then this should be
enough information for the framework to know that the two DAIs are
linked and if any routes are needed in DAPM these should be added
automatically in the same way that we add links for CODEC<->CODEC links
at present.

It's been said to you off-list that having the links manually added
but marking them for removal when the framework figures out how to do
that should be OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/8a631a0f/attachment.sig>
