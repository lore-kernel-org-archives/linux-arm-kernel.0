From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jul 2011 22:21:44 +0100
Subject: [PATCH V2 3/8] ARM: EXYNOS4: Add support PM with external GIC
In-Reply-To: <1309485457-13305-4-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
	<1309485457-13305-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110701212144.GF21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 10:57:32AM +0900, Kukjin Kim wrote:
> From: Jaecheol Lee <jc.lee@samsung.com>
> 
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Why not fix arch/arm/common/gic.c to save and restore the GIC state
itself?

You really need to start thinking bigger than just Samsung with this
stuff - we can't have SoC people addressing these obviously common
issues within their own code and duplicating it across all SoCs.  We
_need_ you folk to start thinking about implementing common support
where its needed.
