From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Oct 2011 14:16:45 +0900
Subject: [PATCH 5/7] ARM: EXYNOS4: Add support external GIC
In-Reply-To: <4E944508.4050202@arm.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-6-git-send-email-chaos.youn@samsung.com>
	<4E8C61C4.9090709@arm.com>
	<00ec01cc83f1$81f84430$85e8cc90$%kim@samsung.com>
	<4E8D645D.4020601@arm.com> <4E8ECA1B.5010005@arm.com>
	<20111007151646.GA2398@mudshark.cambridge.arm.com>
	<4E92ECD1.2010303@arm.com>
	<00b901cc8810$8353e730$89fbb590$%youn@samsung.com>
	<4E944508.4050202@arm.com>
Message-ID: <063801cc889e$22a12c20$67e38460$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> 
> Hi Changwan,
> 
> On 11/10/11 13:22, Changhwan Youn wrote:
> >> Kukjin, could you please comment on the presence of a common memory
> >> region for the distributor? This seem quite odd...
> >
> > Some registers in Distributor are banked for PPI and SGI support (banked
> interrupts).
> > The register for pending and enable status of these interrupts are
> > banked.
> 
> Right, that explains it then.
> 
> > Marc, I think the approach in your patch is much better than mine if it
doesn't hurt
> > the performance of other platforms which use the common gic code.
> 
> It probably doesn't hurt the general case too much (I expect a bit more
> pressure on the d-cache because of the per-cpu stuff, but nothing to be
> too worried about).
> 
> > I'll re-work the exynos4 interrupt code based on your patch though
> > I'm not sure that it's possible to be merged in merge window.
> 
> My main concern at the moment is that mainline is broken as far as
> EXYNOS4 is concerned (there's a race with the EOI hook), so that should
> get fixed first.
> 
Hi Marc,

OK. I agree with Will and your opinions and I think Changhwan can fix it as
per your suggestion, but he needs fixed/updated regarding gic codes to avoid
re-work and conflicts with others. So it would be better to us if he could
fix it after merging your patches even probably at the end of upcoming merge
window. I hope he can do it before v3.2-rc1.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
