From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 15:07:39 +0000
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <509135BF.2080700@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate> <508FFADC.3080506@gmail.com>
 <50900C90.7070101@gmail.com> <20121030224703.GI21164@n2100.arm.linux.org.uk>
 <50906B16.8060204@gmail.com> <20121031115627.GA9123@localhost.conference>
 <509135BF.2080700@gmail.com>
Message-ID: <20121031150739.GM21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 09:29:19AM -0500, Rob Herring wrote:
> What about other asm header dependencies? cpu_logical_map is needed for
> example. I guess I'll leave all those for now.

That's one of the down-sides to moving this code out of arch/arm - your
existing set of five patches adds to the required asm headers (eg, it
now needs set_smp_cross_call() from ARMs asm/smp.h, whereas it didn't
need that before) and any SMP architecture re-using the GIC will need
to provide this function whether or not they use the SPI facility.

Further comments against your patch set...
