From: balbi@ti.com (Felipe Balbi)
Date: Fri, 17 Sep 2010 13:37:51 +0300
Subject: [PATCH 14/14] omap4: Fix bootup crash observed with higher CPU
	clocks
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014F13A77C@dlee02.ent.ti.com>
References: <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-15-git-send-email-santosh.shilimkar@ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C014F13A77C@dlee02.ent.ti.com>
Message-ID: <20100917103751.GO26474@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 17, 2010 at 05:14:59AM -0500, Menon, Nishanth wrote:
>> @@ -581,7 +581,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer
>> *timer, int source)
>>  	 * When the functional clock disappears, too quick writes seem
>>  	 * to cause an abort. XXX Is this still necessary?
>>  	 */
>> -	__delay(150000);
>> +	__delay(300000);
>What is the rationale for this increase? Lets say we have a CPU bumped
>up to 1GHz or something will we have weird numbers again?

yeah, I thought the _omap2_module_wait_ready() should handle that ??

-- 
balbi
