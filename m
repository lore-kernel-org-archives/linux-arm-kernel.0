From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 6 Jan 2010 18:17:05 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <1262795027.18401.28.camel@pc1117.cambridge.arm.com>
References: <20100105194328.GG14376@shareable.org>
	<1262795027.18401.28.camel@pc1117.cambridge.arm.com>
Message-ID: <20100106181705.GD11773@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> > Is there any reason why this wasn't always like that?
> 
> On ARMv6 onwards (where this user RO, kernel RO is supported) we cannot
> easily differentiate between the vectors page and a normal kernel page
> unless we use another L_PTE_ bit. We need the vectors page to be
> writable if there is no TLS register in hardware (I guess we could use
> domain switching to override this though). But on ARMv7 we always have a
> TLS register, so no need to write to the vectors page.

Could you map the TLS page writable (kernel access only) at another
address at the same time, carefully choosing an aliasing address so
that no cache flush is needed after writing?

-- Jamie
