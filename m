From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 20:10:42 +0000
Subject: OMAP3: Warning: swp{b} use is deprecated for this architecture
In-Reply-To: <AANLkTinXBx5F-wQC_eJPftsqgbaFUg9R8z5FxTFR+gTy@mail.gmail.com>
References: <AANLkTinmg4SyQNz5ide40YYC7k_MRQ6Q-j=WKN7jLC68@mail.gmail.com>
	<20101216115657.GP9937@n2100.arm.linux.org.uk>
	<AANLkTi=-ERvBARQ3bzOMZPx0s-OPuZHgXqjRet1aUxGw@mail.gmail.com>
	<AANLkTink3TJonOC+cnpRUKKu9_+OBhJKDQ25yvrZZsrQ@mail.gmail.com>
	<6188477658179778436@unknownmsgid>
	<AANLkTinL3oonBvkZwZFr=Wh2m_EYQ1WVudV9cxNqKRBx@mail.gmail.com>
	<AANLkTinXBx5F-wQC_eJPftsqgbaFUg9R8z5FxTFR+gTy@mail.gmail.com>
Message-ID: <20101216201042.GW9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 08:04:41PM +0000, Dave Martin wrote:
> Note that the above bit of code is similar/identical to a bit of code
> already present in the OMAP BSP... so this still needs to be
> addressed.
> 
> See arch/arm/mach-omap2/sleep34xx.S:lock_scratchpad_sem

That's odd.

| The following warning is issued by the compiler (gcc version 4.4.1
| (Sourcery G++ Lite 2010q1-202):
| arch/arm/mach-omap2/sleep34xx.S:87: Warning: swp{b} use is deprecated
| for this architecture

It seems we're discussing the same code!

As has been pointed out, and as Jean points out, this code is not called
at the moment, so can be removed to resolve the problem.
