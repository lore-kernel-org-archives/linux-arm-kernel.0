From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 08 Jan 2014 14:13:16 -0500
Subject: [PATCH v8 4/6] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <1389206998-27875-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1401081845040.21510@kaball.uk.xensource.com>
 <1389206998-27875-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <52CDA34C.2030605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 01/08/2014 01:49 PM, Stefano Stabellini wrote:
> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
> Necessary duplication of paravirt.h and paravirt.c with ARM.
> 
> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> runtime pvops patching needed.
> 
> This allows us to make use of steal_account_process_tick for stolen
> ticks accounting.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: will.deacon at arm.com
> CC: nico at linaro.org
> CC: marc.zyngier at arm.com
> CC: cov at codeaurora.org
> CC: arnd at arndb.de
> CC: olof at lixom.net
> CC: Catalin.Marinas at arm.com

Looks good to me.

Acked-by Christopher Covington <cov@codeaurora.org>

While I don't think it should necessarily gate these changes, I wonder if at
some point the config options could be consolidated across the various
architectures using them.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
