From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Feb 2016 10:01:31 +0100
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <20160209085633.GA5388@kwain>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
 <56B8B45D.1020902@arm.com> <20160209085633.GA5388@kwain>
Message-ID: <20160209090131.GB5388@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 09:56:33AM +0100, Antoine Tenart wrote:
> Hi Marc,
> 
> On Mon, Feb 08, 2016 at 03:29:33PM +0000, Marc Zyngier wrote:
> > On 08/02/16 09:11, Antoine Tenart wrote:
> > 
> > > +		gic: gic at f0100000 {
> > > +			compatible = "arm,gic-v3";
> > > +			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
> > > +			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
> > > +			      <0x0 0xf0100000 0x0 0x2000>;	/* GICC */
> > > +			interrupt-controller;
> > > +			#interrupt-cells = <3>;
> > > +		};
> > 
> > Something is wrong here. Either you are missing GICH and GICV (assuming
> > you have legacy support), or you have an extra GICC region (which
> > doesn't make sense on its own).
> 
> I'll add the missing regions.

Hmm, in fact the GICC region shouldn't be there. I'll make some tests
and remove it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/e4c102f6/attachment.sig>
