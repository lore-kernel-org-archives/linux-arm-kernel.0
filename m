From: Leif.Lindholm@arm.com (Leif Lindholm)
Date: Mon, 4 Jan 2010 18:18:55 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v2)
In-Reply-To: <20091219172833.GA6187@n2100.arm.linux.org.uk>
References: <20091218182007.GF5527@n2100.arm.linux.org.uk>
	<1261243122.4637.9.camel@pc1117.cambridge.arm.com>
	<20091219172833.GA6187@n2100.arm.linux.org.uk>
Message-ID: <F74D5D79E8EA1244A97ECCA56C4D01DB771E2EDD86@BUNGLE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: 19 December 2009 17:29

> > I wonder if there could be an exploit with Leif's current
> > implementation. The LDREX/STREX pair to uncached or device memory may
> > never complete. This way a user SWP to something like the frame
> > buffer would lock the kernel.
>
> That means we shouldn't consider applying it until that has been
> investigated.

What if I modify the patch such that a failed STREX causes the emulation to
return success without readjusting the PC? This would result in the SWP
instruction being executed again upon returning to the application - removing
the potential kernel lockup.

/
        Leif

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
