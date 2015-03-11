From: jkosina@suse.cz (Jiri Kosina)
Date: Wed, 11 Mar 2015 17:06:47 +0100 (CET)
Subject: [PATCH v6 04/22] power_supply: Move run-time configuration to
 separate structure
In-Reply-To: <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <alpine.LRH.2.00.1503111706310.13021@twin.jikos.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Mar 2015, Krzysztof Kozlowski wrote:

> Add new structure 'power_supply_config' for holding run-time
> initialization data like of_node, supplies and private driver data.
> 
> The power_supply_register() function is changed so all power supply
> drivers need updating.
> 
> When registering the power supply this new 'power_supply_config' should be
> used instead of directly initializing 'struct power_supply'. This allows
> changing the ownership of power_supply structure from driver to the
> power supply core in next patches.
> 
> When a driver does not use of_node or supplies then it should use NULL
> as config. If driver uses of_node or supplies then it should allocate
> config on stack and initialize it with proper values.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> [for the nvec part]
> Reviewed-by: Marc Dietrich <marvin24@gmx.de>
> 
> [for drivers/platform/x86/compal-laptop.c]
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>

Reviewed-by: Jiri Kosina <jkosina@suse.cz>

for changes in drivers/hid/*

-- 
Jiri Kosina
SUSE Labs
