From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:12:14 +0100
Subject: [PATCH v4 13/13] firmware: arm_sdei: Discover SDEI support via
 ACPI
In-Reply-To: <20171017174432.1684-14-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-14-james.morse@arm.com>
Message-ID: <20171018111214.buwjjqzibh3ll6ef@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:32PM +0100, James Morse wrote:
> SDEI defines a new ACPI table to indicate the presence of the interface.
> The conduit is discovered in the same way as PSCI.
> 
> For ACPI we need to create the platform device ourselves as SDEI doesn't
> have an entry in the DSDT.
> 
> The SDEI platform device should be created after ACPI has been initialised
> so that we can parse the table, but before GHES devices are created, which
> may register SDE events if they use SDEI as their notification type.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
