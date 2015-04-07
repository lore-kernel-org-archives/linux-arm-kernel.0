From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 Apr 2015 11:21:35 +0100
Subject: irqchip heirarchy DT "break" series awareness?
In-Reply-To: <20150407115922.5d4c6233@free-electrons.com>
References: <20150406144647.GC7873@io.lakedaemon.net>
 <20150407115922.5d4c6233@free-electrons.com>
Message-ID: <5523AFAF.6040000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 07/04/15 10:59, Thomas Petazzoni wrote:

> But the point of the slides stand: even for a piece of hardware as
> well-documented as the GIC, as widely used as the GIC, with as many
> bright and smart engineers looking into it, the community has not been
> able to put out a DT binding that can be kept stable. How can we expect
> such a DT binding stability to occur for undocumented hardware, or
> SoC-specific hardware blocks that are definitely a lot less used than
> the GIC ?

The problem at hand is not so much the GIC itself, but the fact that
only the GIC was described in DT. The GIC binding is unchanged, but some
additional hardware is now described.

If the relationship between the GIC and the shadow interrupt controllers
had been described, we would have avoided breaking the compatibility. I
guess it was too tempting to reuse pre-DT mechanisms and to forget about
this entirely.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
