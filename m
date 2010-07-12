From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 12 Jul 2010 12:50:35 +0100
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <201007121339.48719.arnd@arndb.de>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007092130.17504.arnd@arndb.de>
	<1278714714.30012.14.camel@e102109-lin.cambridge.arm.com>
	<201007121339.48719.arnd@arndb.de>
Message-ID: <20100712115035.GA7559@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> Ah, that's right: writel and outl both need the barrier before the access,
> but writel will never need a barrier after the access.
> The x86 variant of outl also has the implicit ordering after the access,
> but I'm not sure if we need to emulate that. I can't currently think
> of a case where it's strictly required because any later access to the same
> PCI function will be ordered anyway.

What about those ARMs which can buffer a write for an indefinite period?
Do any drivers expect writes to be posted in a reasonably short time?

-- Jamie
