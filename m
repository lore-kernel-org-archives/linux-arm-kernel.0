From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 Jun 2016 15:17:55 +0100
Subject: [PATCH v6] arm64: cpuinfo: Expose MIDR_EL1 and REVIDR_EL1 to sysfs
In-Reply-To: <20160628110621.GC5425@arm.com>
References: <1466507556-9027-1-git-send-email-suzuki.poulose@arm.com>
 <20160628110621.GC5425@arm.com>
Message-ID: <20160628141755.GE4585@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 12:06:22PM +0100, Will Deacon wrote:
> On Tue, Jun 21, 2016 at 12:12:36PM +0100, Suzuki K Poulose wrote:
> > +static struct attribute_group cpuregs_attr_group = {
> > +	.attrs = cpuregs_attrs,
> > +	.name = "identification"
> > +};
> 
> This makes sense because MIDR/REVIDR belong to the "Identification"
> functional group of registers, however I wonder if we should put this
> under a directory called "regs" or similar, so that we don't have a
> confusing top-level directory where "identification" lives alongside
> things like "hotplug" and "cpuidle".

IMO, there are too many subdirectories and I don't think we would expose
any other registers than the ID ones.

-- 
Catalin
