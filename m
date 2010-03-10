From: jamie.iles@picochip.com (Jamie Iles)
Date: Wed, 10 Mar 2010 11:03:37 +0000
Subject: [PATCH 2/6] ARM: perf-events: use numeric ID to identify PMU
In-Reply-To: <1268217690-29712-3-git-send-email-will.deacon@arm.com>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>
	<1268217690-29712-3-git-send-email-will.deacon@arm.com>
Message-ID: <20100310110336.GA4237@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 10:41:26AM +0000, Will Deacon wrote:
> The ARM perf-events framework provides support for a number of different
> PMUs using struct arm_pmu. The char *name field of this struct can be
> used to identify the PMU, but this is cumbersome if used outside of perf.
> 
> This patch replaces the name string for a PMU with an enum, which holds
> a unique ID for the PMU being represented. This ID can be used to index
> an array of names within perf, so no functionality is lost. The presence
> of the ID field, allows other kernel subsystems [currently oprofile] to
> use their own mappings for the PMU name.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jpihet@mvista.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Hi Will,

Looks good to me.

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
