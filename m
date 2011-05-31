From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 31 May 2011 10:08:58 -0700
Subject: [RFC PATCH v5 13/13] ARM: SMP: automatically select ARM_GIC_VPPI
In-Reply-To: <1306830060.27474.302.camel@e102391-lin.cambridge.arm.com>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>	
	<1306749894-28749-14-git-send-email-marc.zyngier@arm.com>	
	<4DE4A100.8020009@codeaurora.org>
	<1306830060.27474.302.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DE520AA.9050300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 01:21 AM, Marc Zyngier wrote:
> On Tue, 2011-05-31 at 01:04 -0700, Stephen Boyd wrote:
>> Would it be better to select GIC_VPPI only if GIC is selected as well? So
>>
>>     select ARM_GIC_VPPI if ARM_GIC
> Possibly.
>> Or put this select under ARM_GIC and have it be
>>
>>     select ARM_GIC_VPPI if SMP
>>
>> ?
> No, I want to be able to select GIC_VPPI even on UP (A15x1 requires it,
> for exemple).
>
> But in the end, if everybody agrees this whole series is sensible, I'd
> rather get rid of the option and make it a permanent feature (patch #11
> removes gic_enable_ppi() anyway, making the use of naked PPIs tricky at
> best...).

That sounds even better.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
