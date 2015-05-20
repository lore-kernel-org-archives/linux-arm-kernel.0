From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 14:02:40 +0200
Subject: [Linaro-acpi] [V4 PATCH 3/6] pci: Generic function for setting up
 PCI device DMA coherency
In-Reply-To: <555C7759.3040304@amd.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150520093401.GC25313@e104818-lin.cambridge.arm.com>
 <555C7759.3040304@amd.com>
Message-ID: <2673003.mTFjFBS7Ob@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 07:00:25 Suravee Suthikulanit wrote:
> It seems that there are several places that have similar check. Would it 
> be good to convert this into a macro? Something like:
> 
> #define OF_NODE_ENABLED(dev)    (IS_ENABLED(CONFIG_OF) && dev->of_node)
> 
> Thanks all for the review feedback.
> 

Better make that an inline function that returns the node:

struct device_node *dev_of_node(struct device *)
{
	if (IS_ENABLED(CONFIG_OF))
		return dev->of_node;

	return NULL;
}

	Arnd
