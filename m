From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 6 Feb 2018 11:00:34 -0800
Subject: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
In-Reply-To: <086251c4-b012-236c-33e2-9cab551a4594@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
 <086251c4-b012-236c-33e2-9cab551a4594@codeaurora.org>
Message-ID: <20180206190034.GK9465@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29 Jan 00:18 PST 2018, Rajendra Nayak wrote:
> On 01/27/2018 03:48 AM, Stephen Boyd wrote:
> > On 01/25, Rajendra Nayak wrote:
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..b97f99e6f4b4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> @@ -0,0 +1,32 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +&tlmm {
> > 
> > I'm not the maintainer, but I find this approach to the pins
> > really annoying. I have to flip to another file to figure out how
> > a board has configured the pins. And we may bring in a bunch of
> > settings that we don't ever use on some board too. Why can't we
> > put the settings in the board file directly?
> 
> I was just keeping it consistent with how things are for other
> qualcomm platforms. I can move this to the board dts if no one else
> sees any issues.
> 

What we decided recently for 8916 (at least) was that we define the
functional properties in the soc dtsi and add the electrical properties
in the board dts(i).

I fully agree with Stephen on this one, but as you say we're keeping the
pinconf in separate files for the other platforms/boards.


I'll prepare and bring some new guidelines to our Thursday meeting and
we can decide what to do based on that.

Regards,
Bjorn
