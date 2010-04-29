From: jamie.iles@picochip.com (Jamie Iles)
Date: Thu, 29 Apr 2010 09:12:18 +0100
Subject: [PATCH] arch/arm: Fix missing define for ARM_PMU_DEVICE_CPU
In-Reply-To: <201004290231.03440.PeterHuewe@gmx.de>
References: <201004290231.03440.PeterHuewe@gmx.de>
Message-ID: <20100429081218.GA14783@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 02:31:03AM +0200, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch adds a define for ARM_PMU_DEVICE_CPU which seemed to be
> missing/undefined and caused some build failures [1-4].
> 
> I defined ARM_PMU_DEVICE_CPU = -1 as stated in
> Documentation/driver_model/platform.txt to indicate there is only one.
> I'm _not_ sure if this is correct, but due to the static nature of the
> define I assume it is.
Hi Peter,

This build error is due to the core patch of Will's "ARM: pmu: provide a
registration mechanism for IRQs" patch series not being merged yet. I'm not
sure what the status of that patch is at the moment though.

Jamie
