From: ak@linux.intel.com (Andi Kleen)
Date: Tue, 27 Feb 2018 15:05:39 -0800
Subject: [RFC 1/3] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
In-Reply-To: <1519770848-26738-2-git-send-email-agustinv@codeaurora.org>
References: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
 <1519770848-26738-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <20180227230539.GF21543@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 05:34:06PM -0500, Agustin Vega-Frias wrote:
> Starting on v4.12 event parsing code for dynamic pmu events already
> supports prefix-based matching of multiple pmus when creating dynamic
> events. E.g., in a system with the following dynamic pmus:
> 
>     mypmu_0
>     mypmu_1
>     mypmu_2
>     mypmu_4
> 
> passing mypmu/<config>/ as an event spec will result in the creation
> of the event in all of the pmus. This change expands this matching
> through the use of fnmatch so glob-like expressions can be used to
> create events in multiple pmus. E.g., in the system described above
> if a user only wants to create the event in mypmu_0 and mypmu_1,
> mypmu_[01]/<config>/ can be passed.

Missing documentation for the globbing.

The rest looked ok to me. 

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
