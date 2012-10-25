From: davidb@codeaurora.org (David Brown)
Date: Thu, 25 Oct 2012 13:34:03 -0700
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1351099475-29349-1-git-send-email-sboyd@codeaurora.org>
References: <1351099475-29349-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20121025203403.GA20767@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 10:24:35AM -0700, Stephen Boyd wrote:
> The TWD and SCU configs are selected by default as long as
> MSM_SCORPIONMP is false and/or MCT is false. Implementing the
> logic this way certainly saves lines in the Kconfig but it
> precludes those machines which select MSM_SCORPIONMP or MCT from
> participating in the single zImage effort because when those
> machines are combined with other SMP capable machines the TWD and
> SCU are no longer selected by default.
> 
> Push the select out to the machine entries so that we can compile
> these machines together and still select the appropriate configs.

>  arch/arm/mach-msm/Kconfig      | 7 ++-----

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
