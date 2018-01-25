From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 25 Jan 2018 11:27:06 +0100
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <ebc8b28d5c2948131cc187ac8177395c@codeaurora.org>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
 <20180123103609.GD27764@dragon> <1516713799.25726.21.camel@pengutronix.de>
 <ebc8b28d5c2948131cc187ac8177395c@codeaurora.org>
Message-ID: <1516876026.6411.23.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Am Donnerstag, den 25.01.2018, 17:48 +0800 schrieb aisheng.dong at codeaurora.org:
> Hi Lucas,
> 
> First of all, good to see this patch series in community.
> 
> Pengutronix has always been an active friendly contributor on IMX
> upstream activities.??You Did help us a lot!
> 
> On 2018-01-23 21:23, Lucas Stach wrote:
> 
> <snip>
> 
> > > > > > > > > > > > +			#address-cells = <1>;
> > > > > > > > > > > > +			#size-cells = <1>;
> > > > > > +			ranges = <0x30000000 0x30000000 0x400000>;
> > > > 
> > > > +
> > > > > > > > +			gpio1: gpio at 30200000 {
> > > > 
> > > > +				compatible = "nxp,imx8mq-gpio", "fsl,imx35-gpio";
> > > 
> > > It looks a bit odd to have different vendor prefix for the same?
> > > device.
> > > But we can understand the reason.??Just curious if this is what vendor
> > > kernel does?
> > 
> > No, I did it mostly to be consistent with the location of the DT files
> > under "nxp". I'll change this to match the "freescale" location.
> > 
> 
> Vendor tree mostly is still using fsl,imx8mq-xx.
> 
> And many binding doc format is:"compatible : Should be "fsl,<soc>-gpio".
> So we can't use 'nxp' prefix here without changing binding doc.
> 
> Then if we decided to use 'fsl' prefix, probably we may want to fix the
> rest of them in this file as well.

Yes, this is changed consistently to "fsl," for the next revision of
the patchset.

> And i see the dtsi file does not include Freescale/NXP copyright,
> is there a reason?

The dtsi is quite different from the downstream version. But you are
right, I looked extensively at the downstream version, so I'll add the
NXP copyright.

BTW: Could you check internally to see if Freescale/NXP would be okay
with relicensing the DT bits I pulled from downstream as dual GPL-2.0
and MIT, to align with other DTs in the kernel?

> BTW it's quite strange that my gmail did not receive your MX8MQ patch
> series except clk part.
> Lucas, Could you help have me CCed next time?
> I'd like to help review and test the patch series.
> 
> For this time, can you help send them all to me as attachment?

I'm about to send v2 of the series. I'll CC you on the submission.

> (You can also send all IMX related patches to linux-imx at nxp.com maillist
> i created recently for tracking all IMX related upstream activities.
> Most Freescale/NXP driver owners are in this list that could help on
> the review. Shawn, do you think if i can put it in MAINTAINER file?)

That's great news that there is now a common address for this. I think
it would be a good idea to have it added to MAINTAINERS as a reviewer.

Regards,
Lucas
