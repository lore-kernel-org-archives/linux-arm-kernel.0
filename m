From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 26 Mar 2013 18:13:19 +0000 (UTC)
Subject: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
In-Reply-To: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
References: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1303261812010.23957@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Mar 2013, Vaibhav Hiremath wrote:

> During common-clock migration, .clkdm_name field got missed
> for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> unused; so boot process will try to disable the clockdomain
> even childs of this clock is enabled, which keeps child modules
> in idle mode.

Looks fine to me.  You're planning to update the patch description, right?  
So should I wait until you repost it?

Also you should probably trim the crash log after "[    2.626025] LR is at 
clk_enable+0x30/0x3c"



- Paul
