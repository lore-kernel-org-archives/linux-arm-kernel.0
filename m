From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 2 Feb 2016 17:00:43 +0000
Subject: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <56B09344.4000100@linaro.org>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
 <20160201180944.GV24726@rric.localdomain>
 <56B09344.4000100@linaro.org>
Message-ID: <20160202170043.GA30358@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:30:12PM +0800, Hanjun Guo wrote:

[...]

> >How about the following (similar to x86)?
> >
> >----
> >	if (!numa_off) {
> >#ifdef CONFIG_ACPI_NUMA
> >		if (!numa_init(acpi_numa_init))
> >			return 0;
> >#endif
> >#ifdef CONFIG_OF_NUMA
> >		if (!numa_init(of_numa_init))
> >			return 0;
> >#endif
> >	}
> >
> >	return numa_init(dummy_numa_init);
> >----
> >
> >Pretty straight and nice.
> >
> >Note: The !acpi_disabled check needs to be moved to the beginning of
> >acpi_numa_init(). Variable ret can be removed.
> 
> Lorenzo suggested to remove it, Lorenzo, what's your opinion here?

I do not think it is a big deal. OF is not a fall-back for ACPI,
which is what the code above may make us think, either you parse
ACPI or you parse DT.

I will have a look at the complete code to check if we can rewrite
it differently but I would not be too worried about it.

Lorenzo
