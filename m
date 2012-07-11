From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 11 Jul 2012 15:34:07 +0900
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <4FE1FB15.3090305@codeaurora.org>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
Message-ID: <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd wrote:
> 
> On 06/11/12 12:25, Russell King - ARM Linux wrote:
> > On Mon, Jun 11, 2012 at 10:41:15AM -0700, Stephen Boyd wrote:
> >> On 06/11/12 10:18, Nicolas Pitre wrote:
> >>> It certainly works for all the targets I'm looking at right now.  In
> >>> those cases the boot protocol couldn't care less about the IPI number
> as
> >>> the point is only to kick the target CPU out of WFI.
> >>>
> >>> And that message certainly has to go as it may be triggered multiple
> >>> times per second in some use cases here.
> >>>
> >>>
> >> Last time this came up I thought we covered most of the platforms?
> >>
> >> OMAP, Realview, Versatile Express, and MSM are covered by this thread
> >>
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-
> January/039275.html
> > Ok, in that case I've just committed three patches to make those
> platforms
> > use SGI0 instead of SGI1.
> 
> Great. Kukjin Kim, can exynos use SGI0? It looks like exynos is the only
> one left to move to SGI0.
> 
Yeah, EXYNOS can use SGI0 instead of SGI1 :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
