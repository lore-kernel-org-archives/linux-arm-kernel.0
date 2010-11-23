From: Pawel.Moll@arm.com (Pawel Moll)
Date: Tue, 23 Nov 2010 20:01:30 +0000
Subject: [PATCH v2] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <20101123195026.GC26510@n2100.arm.linux.org.uk>
References: <1290541542-12917-1-git-send-email-pawel.moll@arm.com>
	<20101123195026.GC26510@n2100.arm.linux.org.uk>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA45911B9845B@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +   gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
> > +   gic_irqs = (gic_irqs + 1) * 32;
>
> I think this should still be limited to 1020 IRQs.  Note that 1020 is
> not divisible by 32, so gic_irqs ends up being 1024 which is wrong.

You mean situation when ITLinesNumber=31, I suppose? Well, registers covering 1021-1023 would exist anyway, and I would hope that the relevant bits would be simply ignored, but we may safeguard ourselves anyway.

V3 follows.

Cheers!

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
