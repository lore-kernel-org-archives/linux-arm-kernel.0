From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Sep 2016 14:34:28 +0100
Subject: [PATCH 3/3] of: pci: remove unused MSI controller helpers
In-Reply-To: <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472744284-18305-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744284-18305-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <57C97FE4.8050808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 16:38, Thomas Petazzoni wrote:
> All the users of the small MSI controller API have been migrated to use
> the generic MSI infrastructure instead. We no longer need a global
> chained list of msi_controller. Instead, MSI controllers are now
> represented as irq domains attached to OF nodes, and the resolution
> between a device requesting an MSI and the corresponding MSI controller
> is done by the generic interrupt resolution logic.
> 
> Therefore, this API is now completely useless, and can be removed from
> the kernel.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Assuming no further issue with the two affected drivers:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
