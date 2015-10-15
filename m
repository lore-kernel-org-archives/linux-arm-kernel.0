From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 14:21:12 +0100
Subject: [PATCH v5 2/2] arm: perf: Add event descriptions
In-Reply-To: <20151013153644.GC18121@dreric01-gentoo.localdomain>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
 <20151009165330.GA22415@dreric01-gentoo.localdomain>
 <20151012143025.GG16124@arm.com>
 <20151012181037.GA16013@dreric01-gentoo.localdomain>
 <20151013153644.GC18121@dreric01-gentoo.localdomain>
Message-ID: <20151015132111.GD29301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 08:36:45AM -0700, Drew Richardson wrote:
> Add additional information about the ARM architected hardware events
> to make counters self describing. This makes the hardware PMUs easier
> to use as perf list contains possible events instead of users having
> to refer to documentation like the ARM TRMs.
> 
> Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> ---
>  arch/arm/kernel/perf_event_v7.c | 121 ++++++++++++++++++++++++++++++++++++++++
>  drivers/perf/arm_pmu.c          |   1 +
>  2 files changed, 122 insertions(+)

[...]

> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2365a32a595e..e933d2dd71c0 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -548,6 +548,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
>  		.stop		= armpmu_stop,
>  		.read		= armpmu_read,
>  		.filter_match	= armpmu_filter_match,
> +		.attr_groups	= armpmu->pmu.attr_groups,

I don't understand this hunk. What's it doing?

Will
