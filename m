From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 29 Mar 2017 09:37:56 +0100
Subject: [kvmtool PATCH v9 09/15] arm: allow creation of an MSI register
 frame region
In-Reply-To: <20170202163223.15372-10-andre.przywara@arm.com>
References: <20170202163223.15372-1-andre.przywara@arm.com>
 <20170202163223.15372-10-andre.przywara@arm.com>
Message-ID: <8f74de98-0418-615b-f852-893a9fa9c98c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/17 16:32, Andre Przywara wrote:
> The GICv3 ITS expects a separate 64K page to hold ITS registers.
> Add a function to reserve such a page in the guest's I/O memory and
> use that for the ITS vGIC type.

Strictly speaking, this should be a 128kB region, including the page
containing GITS_TRANSLATER. Not that it matters much, but maybe we
should consider some special handling if the guest wanders too close to
the doorbell...

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
