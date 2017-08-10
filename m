From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Aug 2017 16:28:41 +0100
Subject: [PATCH] irqchip/gic-v3-its-platform-msi: Fix msi-parent parsing
 loop
In-Reply-To: <20170810144117.17567-1-lorenzo.pieralisi@arm.com>
References: <20170810144117.17567-1-lorenzo.pieralisi@arm.com>
Message-ID: <5b33e776-802a-af30-f9e8-fa414df1b4e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/17 15:41, Lorenzo Pieralisi wrote:
> While parsing the msi-parent property to chase up the IRQ domain
> a given device belongs to, the index into the msi-parent tuple should
> be incremented to ensure all properties entries are taken into account.
> 
> Current code missed the index update so the parsing loop does not work
> in case multiple msi-parent phandles are present and may turn into
> an infinite loop in of_pmsi_get_dev_id() if phandle at index 0 does
> not correspond to the domain we are actually looking-up.
> 
> Fix the code by updating the phandle index at each iteration in
> of_pmsi_get_dev_id().
> 
> Fixes: deac7fc1c87f ("irqchip/gic-v3-its: Parse new version of msi-parent property")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Marc,
> 
> nothing urgent, I have just bumped into it while checking how ITS
> DeviceIDs are handled in DT.

Duh. Nice catch. Applied to the next batch of fixes (waiting for tglx to
resurface...).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
