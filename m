From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Mar 2017 09:58:41 +0100
Subject: [kvmtool PATCH v9 00/15] kvmtool: arm: ITS emulation and GSI
 routing support
In-Reply-To: <20170202163223.15372-1-andre.przywara@arm.com>
References: <20170202163223.15372-1-andre.przywara@arm.com>
Message-ID: <997ccfcb-b569-cf99-aa72-36450f62c807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/17 16:32, Andre Przywara wrote:
> Hi,
> 
> an update to the ITS emulation series for kvmtool.
> I reworked the phandle allocation by actually removing and replacing it
> with some simple, static assignments. That definitely fits kvmtool's
> needs today, where the GIC and the PCI controller are statically
> assigned anyway. If that is too much of a simplification, let me know.
> Also I fixed the error return in case some GSI routing setup fails.
> On that way I use the opportunity to merge in 32-bit ARM support for the
> ITS and the VGICv3, as the kernel learned about it recently as well.
> The rest is effectively unchanged apart from some rebasing and
> adjustments due to the mentioned changes.

Hi Andre,

Sorry for the time it took me to get to this series. Overall, this is
looking good. There is a number of nits I'd like you to address (the
DEVID detection is pretty nasty), and I suspect a weird corner case when
irq__add_msix_route() fails in patch 6.

If you can respin it quickly, I promise to get back to it quickly, and
we can (finally) merge it!

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
