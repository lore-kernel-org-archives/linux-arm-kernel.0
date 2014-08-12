From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Aug 2014 18:33:55 +0100
Subject: [PATCH 1/6] ARM: dts: Create fragment for tps65090 PMU
In-Reply-To: <53EA4D1F.2030406@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
 <20140812165852.GT17528@sirena.org.uk>
 <53EA4D1F.2030406@collabora.co.uk>
Message-ID: <20140812173355.GV17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 07:21:35PM +0200, Javier Martinez Canillas wrote:
> On 08/12/2014 06:58 PM, Mark Brown wrote:
> > On Tue, Aug 12, 2014 at 06:44:23PM +0200, Javier Martinez Canillas wrote:

> >> The tps65090 is a Power Management Unit (PMU) used in several
> >> boards so the same information is described on different DTS.
> >> It is better to create a .dtsi fragment that can be included.

> > Why is it better to do this?

> Is better IMHO because we have a single place where the tps65090 information can
> be updated instead of duplicating the same definition on each DTS.

But there is no real information in this file.

> This appears to be the current trend to better manage shared DTS snippet across
> different boards. Others examples are arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> and arch/arm/boot/dts/twl6030.dtsi.

In the smsc911x case that's a block from a reference design that's
commonly repeated over multiple systems and is therefore similar to the
reference design elements that have been factored out for Chromebooks.

The twl6030 fragment is just broken - the regulator section is actively
harmful and should be removed.

> 
> >> +	regulators {
> >> +		tps65090_dcdc1: dcdc1 {
> >> +		};
> >> +
> > 
> > It appears to be largely content free, exactly the same effect should be
> > achieved by removing the entire regulators node.
> > 
> 
> Yes it's content free but later "[PATCH 6/6] ARM: dts: Add tps65090 FETs
> constraints" [0] fills the FETs constraints [0]. This is a preparatory patch.
> 
> Also, having all the regulators allows DTS files to reference the node by the
> label if they want to add other properties. I can squash this patch and 06/06 if
> you think that is better but I thought that the split makes it easier to review.
> 
> Best regards,
> Javier
> 
> [0]: https://lkml.org/lkml/2014/8/12/377
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140812/737becf2/attachment.sig>
