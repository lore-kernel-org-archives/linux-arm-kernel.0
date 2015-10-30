From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Oct 2015 11:57:45 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <56335024.9090009@arm.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <20151029114005.GB389@arm.com> <1446159896024.99950@nvidia.com>
 <20151030110010.GA2854@e104818-lin.cambridge.arm.com>
 <56335024.9090009@arm.com>
Message-ID: <20151030115744.GC2854@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 11:10:28AM +0000, Sudeep Holla wrote:
> On 30/10/15 11:00, Catalin Marinas wrote:
> >BTW, it looks like I don't get any cache information on Juno with
> >4.3-rc7, it says "Unable to detect cache hierarchy from DT for CPU
> >0". I thought the point of the patch you are trying to revert was to
> >parse this information from the hardware registers. Sudeep, any
> >idea?
> >
> 
> Yes you need to have updated DT from the mainline. Since the
> architecture doesn't provide any way of detecting the cpus sharing
> particular cache, we get that information from DT.
> 
> If DT lacks that info we don't expose any information. It would be wrong
> to say that a shared cache is shared by all the cpus in the system. DT
> check was added explicitly to avoid that.

OK, thanks for the information. The good thing is that use space should
already be able to cope with cache information not present in sysfs.

So, rather than reverting this feature, for the Denver case we have the
option of either providing full cache topology information in DT or
providing a DT flag which states whether hardware cache ID information
is relevant.

What about ACPI? Are there any provisions for specifying such
information?

-- 
Catalin
