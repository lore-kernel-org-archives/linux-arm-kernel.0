From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 30 Oct 2015 11:10:28 +0000
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <20151030110010.GA2854@e104818-lin.cambridge.arm.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <20151029114005.GB389@arm.com> <1446159896024.99950@nvidia.com>
 <20151030110010.GA2854@e104818-lin.cambridge.arm.com>
Message-ID: <56335024.9090009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/10/15 11:00, Catalin Marinas wrote:
> On Thu, Oct 29, 2015 at 11:03:27PM +0000, Alexander Van Brunt wrote:

[...]

> BTW, it looks like I don't get any cache information on Juno with
> 4.3-rc7, it says "Unable to detect cache hierarchy from DT for CPU
> 0". I thought the point of the patch you are trying to revert was to
> parse this information from the hardware registers. Sudeep, any
> idea?
>

Yes you need to have updated DT from the mainline. Since the
architecture doesn't provide any way of detecting the cpus sharing
particular cache, we get that information from DT.

If DT lacks that info we don't expose any information. It would be wrong
to say that a shared cache is shared by all the cpus in the system. DT
check was added explicitly to avoid that.

-- 
Regards,
Sudeep
