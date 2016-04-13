From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Apr 2016 06:25:53 +0100
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
Message-ID: <20160413052553.GF14664@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 06:23:15PM +0100, Catalin Marinas wrote:

> I'm fine with dropping the EXPERT dependency (of course, not a cc
> stable). While arm64 ACPI is not "done" yet (nor is DT; there are
> important ongoing developments like PCIe, IORT), I think the core arm64
> ACPI support passed the EXPERT stage. I also don't think a default y
> would imply any maintainer endorsement; vendors targeting ACPI are
> already doing this for various reasons (distro requirement, certain ACPI

So you're OK with the current patch?

> features like RAS). But, hopefully, it will encourage more vendors to
> start upstreaming their ACPI-related patches.

Yes, and also help include ACPI systems in the work we're doing testing
things upstream.

> However, building ACPI by default on arm64 doesn't mean that we can
> ignore potential misuses like PRP0001+_DSD blindly following DT
> (mis)concepts, breaking compatibility with older/newer firmware (this
> goes in both directions) or using ACPI for SoCs where it is clearly not
> suitable (e.g. non-SBSA). Such patches should be NAK'ed accordingly.

Yes, I'm very concerned about some of the activity I'm seeing there
myself - it does seem likely that we're going to have to extend ACPI for
arm64 SoCs simply because things like SBSA are so bare bones but we need
to pay attention to what's going on there to promote best practices and
try to get people producing firmwares that make well thought through
decisions regarding their ACPI usage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/cd774a02/attachment.sig>
