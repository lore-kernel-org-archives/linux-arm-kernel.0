From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2012 17:14:15 +0000
Subject: [PATCH] ARM: ptrace: Include linux/audit.h to fix build errors
In-Reply-To: <1329325622.2337.13.camel@localhost>
References: <1329284188.12708.1.camel@phoenix>
 <20120215083609.GD13673@n2100.arm.linux.org.uk>
 <1329325622.2337.13.camel@localhost>
Message-ID: <20120215171415.GE29319@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 05:07:02PM +0000, Eric Paris wrote:
> Fixing the arch flag to be correct means we could do that translation
> properly.  I haven't seen the patches to support translation of arm raw
> bits to something higher level in audit userspace, but I assume it's
> coming as soon as someone cares.
> 
> So if someone tells me how the code knows it's endianness I'll gladly
> write the ifdef to switch from AUDIT_ARCH_ARMEB to AUDIT_ARCH_ARM when
> appropriate....

You should just be able to use #ifdef __ARMEB__ for the big-endian case (we
don't support a little-endian kernel with a big-endian userspace or anything
funky like that). If Russell has reverted the original patch your best bet is
probably to spin a v2 of the ARM bits and post it to LAK.

Will
