From: nm@ti.com (Nishanth Menon)
Date: Fri, 24 Jun 2016 11:54:52 -0500
Subject: [PATCH] hwrng: OMAP: Fix assumption that runtime_get_sync will
 always succeed
In-Reply-To: <1466787040-26184-2-git-send-email-nm@ti.com>
References: <1466787040-26184-1-git-send-email-nm@ti.com>
 <1466787040-26184-2-git-send-email-nm@ti.com>
Message-ID: <576D65DC.5050205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2016 11:50 AM, Nishanth Menon wrote:
> pm_runtime_get_sync does return a error value that must be checked for
> error conditions, else, due to various reasons, the device maynot be
> enabled and the system will crash due to lack of clock to the hardware
> module.
> 


Oh crap! Apologies, please ignore the v1 patch which was unfortunately
reposted. Sorry for the spam - i was pretty sure I cleared out the old
patch, but looks I was wrong.

V2 of the patch is here: https://patchwork.kernel.org/patch/9197919/



-- 
Regards,
Nishanth Menon
