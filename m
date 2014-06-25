From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 12:12:13 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140625095735.GI6153@arm.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <130361958.xFghHXmZkz@wuerfel> <20140625095735.GI6153@arm.com>
Message-ID: <6589024.32Qh7fFhXo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 June 2014 10:57:36 Will Deacon wrote:
> So far, I've been avoiding the hardcoding. However, you could potentially
> build a system with a small number of SMRs (compared to the number of
> StreamIDs) and allocate the StreamIDs in such a way that I think the dynamic
> configuration would be NP complete if we require an optimal SMR allocation.
> 
> However:
> 
>   (1) I don't know of a system where this is the case
>   (2) Not much work has been done on improving the dynamic allocator yet
> 
> which is why I'm still favouring dynamic configuration in the driver.
> 
> The other thing I forgot to mention earlier is that we need to support
> device hotplug in the future, so some level of dynamic configuration
> will always be required.

Ok, got it. So we just hope that we can make dynamic configuration
work all the time, but if it all fails, then we come up with a
hardcoded configuration method.

I guess this could be done similarly to how we handle clocks on
a lot of systems: generally these are dynamic, but you have the
option to provide hints in the clock controller node about how
you expect things to be configured.

For the SMMU that could mean that (if we get into the situation you
describe), we add optional properties to the SMMU node itself
describing how we expect the SMRs to be used.

	Arnd
