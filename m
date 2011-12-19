From: davidb@codeaurora.org (David Brown)
Date: Mon, 19 Dec 2011 15:21:27 -0800
Subject: [PATCH 12/20] ARM: mach-msm: hook special idle handlers to
 arm_pm_idle
In-Reply-To: <1324288069-21940-13-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-13-git-send-email-nico@fluxnic.net>
Message-ID: <20111219232127.GA9896@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 04:47:41AM -0500, Nicolas Pitre wrote:
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/mach-msm/idle.S                |   36 ----------------------
>  arch/arm/mach-msm/idle.c                |   49 +++++++++++++++++++++++++++++++
>  arch/arm/mach-msm/include/mach/system.h |    5 ++-
>  3 files changed, 53 insertions(+), 37 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/idle.S
>  create mode 100644 arch/arm/mach-msm/idle.c

I've tested this on 8660.  It'd be nice if someone was able to test
this on the G1 to make sure it doesn't break idle there.  I've compile
tested it, though.

We do have idle support for our newer chips, and hopefully we'll be
able to add that at some point.  There is also reset support.

But, this does help clean up the current functionality.

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
