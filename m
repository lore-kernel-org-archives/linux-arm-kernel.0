From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 23 Jun 2013 10:20:36 +0200
Subject: [PATCH v7] ARM: PJ4B: fix for 3.10-rc
In-Reply-To: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
References: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130623102036.66dd8b74@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 21 Jun 2013 17:31:03 +0200, Gregory CLEMENT wrote:

> This path allows to fix one errata for PJ4B CPUs.
> 
> Without this the Armada 370 based board can't boot anymore since
> 3.10-rc1. So this one really need to be applied on 3.10-rc.

I'd like to point out that this patch is really needed for 3.10-rc,
*OR* ae8a8b9553 ("ARM: 7691/1: mm: kill unused
TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead") should be
reverted, as it introduces a regression compared to 3.9.

Without one of those two solutions, 3.10 cannot boot on Armada 370
platforms, which is a clear regression compared to 3.9.

Linus has just released 3.10-rc7 and said it would most likely be the
last rc.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
