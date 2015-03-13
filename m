From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 13 Mar 2015 10:50:42 -0500
Subject: [PATCH v4 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <20150313105207.GB3592@leverpostej>
References: <1426182985-10425-1-git-send-email-galak@codeaurora.org>
 <20150313105207.GB3592@leverpostej>
Message-ID: <04AD8E46-277D-4652-88AF-D16538C2AA87@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 13, 2015, at 5:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:

>> +/ {
>> +	chosen {
>> +		stdout-path = &blsp1_uart2;
>> +	};
> 
> It would be good if we had the configuration too (see
> Documentation/devicetree/bindings/chosen.txt), as that avoids any
> reliance on kernel defaults.
> 
> You can refer to an alias, so this could be:
> 
> aliases {
> 	serial0 = &blsp1_uart2;
> };
> 
> chosen {
> 	stdout-path = "serial0:115200n8";
> };
> 
> ...assuming that 115200n8 is correct for your UART, of course.
> 
> 
> [?]

Where is the code that actually handles this parsing?  I?m not see it in early_init_dt_scan_chosen_serial and I don?t believe fdt_path_offset does anything special with ?:'

> 
>> +#include "skeleton.dtsi"
> 
> I'd like to get rid of skeleton.dtsi; it causes more problems than it
> solves (the address/size cells mismatch is confusing and hidden, people
> forget to fill in memory nodes appropriately, etc).
> 
> Please remove this include and place appropriate #address-cells and #size-cells here.
> 
> I'd strongly recommend going with /#size-cells = <2>; it' will save on a
> lot of pain if you need to add PCIe or something with large ranges
> later. If things all fall in 4GB within the SoC then have
> /soc/#size=cells = <1> and an appropriate /soc/ranges property.
> 
> I note this DT doesn't have any memory nodes. Is that an accident or
> does the loader fill that in?

it was coming out of skeleton.dtsi

> 
> If the latter, have an empty node with a comment to that effect.

I?ll kill off usage of skeleton.dtsi

- k
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
