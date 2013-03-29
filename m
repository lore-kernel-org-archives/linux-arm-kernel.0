From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 17:10:54 +0530
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51557DC6.5060104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
> The noop functions code is not necessary because the header file is
> included in files which are compiled when CONFIG_CPU_IDLE is on.
> 
Well the inline function was to avoid buid breaks when
!CONFIG_CPU_IDLE.
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Function without definition will break the build, No? Just
declaration isn't won't help to get the build through.

Ofcourse if all idle drivers are build *only when*
CONFIG_CPU_IDLE=y, then the patch is should
be fine.

Regards,
Santosh
