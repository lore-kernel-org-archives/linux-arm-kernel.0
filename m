From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Feb 2016 09:56:33 +0100
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <56B8B45D.1020902@arm.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <56B8B45D.1020902@arm.com>
Message-ID: <20160209085633.GA5388@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Feb 08, 2016 at 03:29:33PM +0000, Marc Zyngier wrote:
> On 08/02/16 09:11, Antoine Tenart wrote:
> 
> > +		gic: gic at f0100000 {
> > +			compatible = "arm,gic-v3";
> > +			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
> > +			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
> > +			      <0x0 0xf0100000 0x0 0x2000>;	/* GICC */
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +		};
> 
> Something is wrong here. Either you are missing GICH and GICV (assuming
> you have legacy support), or you have an extra GICC region (which
> doesn't make sense on its own).
> 
> You're also missing the maintenance interrupt.
> 
> Has Anapurna really built a GICv3 without an ITS?

I documented myself and Annapurna's GIC really doesn't have an ITS.

I'll add the missing regions.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/61618e8e/attachment.sig>
