From: ashoks@broadcom.com (Ashok Kumar)
Date: Mon, 4 Apr 2016 04:51:58 -0700
Subject: [PATCH v3 0/6] arm64: perf: Broadcom Vulcan PMU support
In-Reply-To: <1459167823-487-1-git-send-email-ashoks@broadcom.com>
References: <1459167823-487-1-git-send-email-ashoks@broadcom.com>
Message-ID: <20160404115156.GA968@ashok.sekar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark/Will,

On Mon, Mar 28, 2016 at 05:23:37AM -0700, Ashok Kumar wrote:
> Cleaned up event naming convention as per ARM ARM.
> 
> Added macros for complete ARMv8 recommended implementation defined events.
> 
> Common architectural and micro-architectural events which are exported to /sys
> are now filtered using PMCEIDn_EL0
> 
> Added support for Broadcom Vulcan PMU.
> 
> changes since v2 [2]:
>  * Changed event filtering mechanism to use is_visible function pointer
>    of attribute_group instead of copying to a new events attribute 
>    structure as per Mark's review comments.
> 
> changes since v1 [1]:
>  Incorporated the following review comments from Will.
>  * cleaned up event naming convention as per ARM ARM
>  * Filtered common events based on PMCEIDn_EL0
>  * Removed exposing implementation defined events to /sys.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg490954.html
> [2] http://www.spinics.net/lists/arm-kernel/msg492439.html
I have incorporated your review comments from v1 and v2. 

I am going to post v4 for fixing the devicetree binding documentation patch
order in the series and adding the devicetree mailing list which I missed. 
If you have any comments, I can fix it and post with v4.

Thanks,
Ashok
> 
> Ashok Kumar (6):
>   arm64/perf: Changed events naming as per ARM ARM
>   arm64/perf: Define complete ARMv8 recommended implementation defined
>     events
>   arm64/perf: Filter common events based on PMCEIDn_EL0
>   arm64/perf: Add Broadcom Vulcan PMU support
>   arm64: dts: Add Broadcom Vulcan PMU in dts
>   Documentation: arm64: pmu: Add Broadcom Vulcan PMU binding
> 
>  Documentation/devicetree/bindings/arm/pmu.txt |   3 +-
>  arch/arm64/boot/dts/broadcom/vulcan.dtsi      |   2 +-
>  arch/arm64/kernel/perf_event.c                | 526 ++++++++++++++++++--------
>  include/linux/perf/arm_pmu.h                  |   2 +
>  4 files changed, 364 insertions(+), 169 deletions(-)
> 
> -- 
> 2.1.0
> 
