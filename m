From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Jun 2014 10:58:01 -0700
Subject: [PATCH] clocksource: arch_arm_timer: Fix timecounter
 initialization
In-Reply-To: <bce193f3fc264abf82ff52ef69f0b86a@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1402475861-15354-1-git-send-email-Li.Xiubo@freescale.com>
 <5398A7B2.6030807@codeaurora.org>
 <bce193f3fc264abf82ff52ef69f0b86a@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <5399EA29.7090302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/14 00:45, Li.Xiubo at freescale.com wrote:
>
> And if so, why not just set it to 0 ? And by the way, 0 is must here ?
>
>

I would just set it to 0 and be done with it. But all of this doesn't
seem very urgent. The only user of this timecounter is using it for the
read() and mult/shift members. We never call timecounter_read() or
timecounter_cyc2time() so the nsec member is irrelevant.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
