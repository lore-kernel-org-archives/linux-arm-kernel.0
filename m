From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 1 Jul 2016 10:28:05 -0500
Subject: [PATCH 09/11] arm64: pmu: Add routines for detecting differing
 PMU types in the system
In-Reply-To: <87mvm1e9ye.fsf@e105922-lin.cambridge.arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-10-git-send-email-jeremy.linton@arm.com>
 <87mvm1e9ye.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <57768C05.1050509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2016 08:58 AM, Punit Agrawal wrote:
(trimming)
>> +			if (!pmu) {
>> +				pr_warn("Unable to allocate pmu_types\n");
>
> Bail out with error if the memory can't be allocated. Otherwise, we risk
> silently failing to register a PMU type.

Reading this again, I think I misunderstood what you were saying.. Aka, 
this should be pr_error() not that the error handing is failing to catch 
the failure.

Anyway, I will promote this.
