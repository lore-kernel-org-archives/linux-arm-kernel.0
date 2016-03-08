From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Mar 2016 17:31:34 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <87a8m93pt0.fsf@free-electrons.com>
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
 <20160308164117.2a3ed3a7@free-electrons.com>
 <87a8m93pt0.fsf@free-electrons.com>
Message-ID: <20160308173134.22a3ad64@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 08 Mar 2016 17:19:39 +0100, Gregory CLEMENT wrote:

> OK, so let's only use clk_enable() which can't sleep. On mvebu SoCs
> there is no prepare/unprepare operation for the clock, so trying to use
> clk_prepare_enable() is useless. Especially for this code which is not
> for a random IP but especially for the Armada XP SoC.
> 
> If in the future the same logic can be used for a new mvebu SoC which
> need the prepare/unprepare feature, then we will see how to deal with
> it, but I really doubt that it will happen.

I am not sure doing a clk_enable() without a clk_prepare() before it is
legal, and that's why the clk_prepare_enable() helper is widely used.

>From the clk_prepare() comment:

""
In fact clk_prepare must be called before clk_enable.
""

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
