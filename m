From: robherring2@gmail.com (Rob Herring)
Date: Wed, 15 Jun 2011 10:01:08 -0500
Subject: [PATCHv2 0/4] ARM: pmu: improve PMU type identification
In-Reply-To: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
References: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
Message-ID: <4DF8C934.4020008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On 06/15/2011 09:40 AM, Mark Rutland wrote:
> Hi,
> 
> This is version 2 of the patches originally posted here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052865.html
> 
> Changes since v1 include:
> 
>  * Added Acks from Jamie Iles & Rob Herring.
>  * Add "arm-pmu" binding to the platform_device_id table, as driver name
>    matching is not used when platform_driver::id_table exists.
>  * Fixed name clash in PLAT_MATCH_PMU macro.
>  * Removed unnecessary casts for platform_device_id::driver_data.
>  * Aligned trailing backslashes on multi-line *_MATCH_PMU macros.
>  * Removed spaces after casts.
> 
> The patches use {of,platform}_device_id tables to provide the PMU type, which
> can be used similarly (the macros make entries look identical apart from the
> {plat,of} prefix). This allows us to stop (ab)using platform_device::id, and
> should allow for easier addition/modification of PMU driver bindings.
> 
> BSPs need no longer care about the Type of PMUs they register; as long as a
> binding exists the type will be assigned correctly.
> 
> Rob, Jamie: would you mind if patches 3 & 4 were squashed together?
> Patch 4 depends heavily on patch 3, and there doesn't seem to be a clean way of
> fixing that.
> 
Interdependency is not really a good reason to combine patches, so I
would leave them as is. Functionality wise, they are doing different things.

Rob
