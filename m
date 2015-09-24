From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Sep 2015 17:54:18 +0100
Subject: [PATCH v5 0/6] irqchip, gicv3: Updates and Cavium ThunderX
 errata workarounds
In-Reply-To: <20150922204134.7491db93@arm.com>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <20150922175701.65ee4437@arm.com> <20150922190932.4391652a@arm.com>
 <20150922182726.GN7356@arm.com> <20150922204134.7491db93@arm.com>
Message-ID: <20150924165418.GK13823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 08:41:34PM +0100, Marc Zyngier wrote:
> On Tue, 22 Sep 2015 19:27:26 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Sep 22, 2015 at 07:09:32PM +0100, Marc Zyngier wrote:
> > > > Catalin, Will: assuming you don't have any objection to this series,
> > > > how do you want to deal with patch 2?
> > 
> > What are the actual dependencies here? AFAICT, the series is addressing
> > multiple errata, so would it be possible to make the arm64 bits somewhat
> > independent from the gic parts?
> 
> Patch 2 could be split into an arm64-specific part and a gic part, with
> a bit of #ifdef-ery in gicv3_enable_quirks().

The arm64 part without CONFIG_CAVIUM_ERRATUM_* wouldn't cause any
problem. Anyway, I'm not too bothered about separate patches, I think
the whole series could go in via a single tree (irqchip).

> > Also, I assume this is targetting 4.4?
> 
> Up to you, really. It is not a regression, but it would still be nice
> to have 4.3 working reliably on this HW.

I don't have any objection to this patchset but it looks like quite a
lot of code for 4.3 and it is not a regression. Anyway, for the
arch/arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
