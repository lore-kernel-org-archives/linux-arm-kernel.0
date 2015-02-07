From: dvhart@infradead.org (Darren Hart)
Date: Fri, 6 Feb 2015 18:19:52 -0800
Subject: [PATCH v3 02/20] power_supply: Move run-time configuration to
 separate structure
In-Reply-To: <1422629278-12202-3-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150207021952.GA30250@fury.dvhart.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 03:47:40PM +0100, Krzysztof Kozlowski wrote:
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

For drivers/platform/x86/compal-laptop.c

Reviewed-by: Darren Hart <dvhart@linux.intel.com>
