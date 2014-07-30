From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Jul 2014 11:37:25 +0900
Subject: [RESEND RFC V2] devicetree: Dialog Semiconductor consolidate
 existing vendor prefixes to standardise on 'dlg'
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7D0B28E95@SW-EX-MBX02.diasemi.com>
References: <201407241554.s6OFsqbW031651@swsrvapps-01.diasemi.com>
 <20140725070002.GH7063@lee--X1>
 <6ED8E3B22081A4459DAC7699F3695FB7D0B28E95@SW-EX-MBX02.diasemi.com>
Message-ID: <20140730023725.GA23224@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 09:53:56AM +0000, Opensource [Steve Twiss] wrote:
> On 25 July 2014 08:00, Lee Jones wrote:
> 
> >On Thu, 24 Jul 2014, Opensource [Steve Twiss] wrote:
> >> From: Steve Twiss <stwiss.opensource@diasemi.com>
> >>
> >> This patch series updates the device tree vendor prefix for
> >> Dialog Semiconductor.
> >>
> >> Various methods are currently used throughout the kernel: 'diasemi',
> >> 'dialog' and 'dlg'. Others have also been suggested.
> >>
> >> This patch set aims to consolidate the usage of the vendor prefix to
> >> use a common standard. The prefix 'dlg' is used.
> >>
> >>
> >> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> >Didn't I Ack the MFD parts already?
> >
> 
> Yes -- certainly.
>  (I should have put them in the main body of the e-mail shouldn't I ..?)
> 
> I just need the SHMobile responses now.
> I will try to make contact with those guys this week.

Hi Steve,

I apologise for not noticing this earlier:
I am entirely unsure how I missed it.

In principle I am fine with this change so long as it does not
introduce any backwards-compatibility problems. In particular removing
compatibility strings that may already be in use by DTB blobs in the wild.

For SH Mobile it seems that Lager and Koelsch were using "diasemi,da9210"
which is unsupported by the driver at this time. So it seems there is no
backwards-compatibility problem there. I'm less sure about other aspects of
the patch. And I'm also less concerned about them.

I do have a slight preference for SH Mobile changes to go through my
renesas tree rather than elsewhere (as part of a more global change)
principally to try to avoid the possibility of conflicts. The SH Mobile dts
files in question are often updated. And for example I notice some fuzz
when applying this patch on top of the next-20140729 tag of linux-next.

If you were to break out the SH Mobile portion of this patch I would be
happy to take it once the driver portion is accepted.  That said, I do see
that everyone else has acked the change so clearly this is not an issue
from their point of view. So I will not complain if you decide not to break
the patch up (though please note my warning about possible conflicts).

In the case where you do not want to split up the patch:
Acked-by: Simon Horman <horms+renesas@verge.net.au>

> I have the following Acks so far.
> 
> >From: Rob Herring on 21 July 2014 16:43
> >I'm okay with this, but it also needs acks from i.MX and SHMobile
> >folks as it could break out of tree users.
> >  Acked-by: Rob Herring <robh@kernel.org>
> 
> >From: Shawn Guo on 22 July 2014 02:38
> >arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
> >arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
> >  Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> >From: Lee Jones on 22 July 2014 08:09
> >For the MFD changes:
> >  Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> and
> 
> >From: Philipp Zabel on 24 July 2014 20:44
> >  Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
