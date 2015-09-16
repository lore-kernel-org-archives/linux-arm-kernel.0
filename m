From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Wed, 16 Sep 2015 02:15:45 +0000
Subject: [PATCH v2 1/2] fsl: Add binding for RCPM
In-Reply-To: <1442361398.2909.164.camel@freescale.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
 <1442361398.2909.164.camel@freescale.com>
Message-ID: <SN1PR0301MB1616C48FB3D990BCA45289AB9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, September 16, 2015 7:57 AM
> To: Wang Dongsheng-B40534
> Cc: devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> robh+dt at kernel.org; linux-arm-kernel at lists.infradead.org; Wang Huan-B18965; Jin
> Zhengxiong-R64188; Zhao Chenhui-B35336; Tang Yuantian-B29983
> Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
> 
> On Tue, 2015-09-15 at 16:55 +0800, Dongsheng Wang wrote:
> > +* Freescale RCPM Wakeup Source Device Tree Bindings
> > +-------------------------------------------
> > +Required rcpm-wakeup property should be added to a device node if the
> > device
> > +can be used as a wakeup source.
> > +
> > +  - rcpm-wakeup: The value of the property consists of 3 cells. The first
> > cell
> > +     is a pointer to the rcpm node, the second cell is the bit mask that
> > +     should be set in IPPDEXPCR0, and the last cell is for IPPDEXPCR1.
> > +     Note: If the platform has no IPPDEXPCR1 register, put a zero here.
> 
> What if a future platform has more than two of these registers?

Those registers are only used for wakeup device, we have a lot of available bit
for feature. For example, In LS1021a platform only 7bits has used in the registers,
and 57bits is reserved.

Regards,
-Dongsheng
