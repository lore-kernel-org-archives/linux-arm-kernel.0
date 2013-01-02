From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 11:16:19 -0700
Subject: [PATCH V4 2/3] clocksource: add common of_clksrc_init() function
In-Reply-To: <1353453142-4973-2-git-send-email-swarren@wwwdotorg.org>
References: <1353453142-4973-1-git-send-email-swarren@wwwdotorg.org>
 <1353453142-4973-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50E47973.9040401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 04:12 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> It is desirable to move all clocksource drivers to drivers/clocksource,
> yet each requires its own initialization function. We'd rather not
> pollute <linux/> with a header for each function. Instead, create a
> single of_clksrc_init() function which will determine which clocksource
> driver to initialize based on device tree.
> 
> Based on a similar patch for drivers/irqchip by Thomas Petazzoni.

I have applied this one patch to Tegra's for-3.9/arm-timer-rework branch
since. I'll send a pull request to include this is arm-soc in the next
day or two, so that others can build changes on top of it.
