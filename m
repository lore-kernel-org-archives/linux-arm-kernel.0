From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 17 Jun 2014 12:25:04 +0300
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <20140617085846.GO17845@atomide.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <20140617085846.GO17845@atomide.com>
Message-ID: <53A00970.3090902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/14 11:58, Tony Lindgren wrote:

>> +/* rfbi */
> 
> I think we're still missing am43x_rfbi_sysc entry though?
> 
>> +static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
>> +	.name		= "dss_rfbi",
>> +	.class		= &omap2_rfbi_hwmod_class,
>> +	.clkdm_name	= "dss_clkdm",
>> +	.main_clk	= "disp_clk",
>> +	.prcm = {
>> +		.omap4 = {
>> +			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
>> +		},
>> +	},
>> +};

That should come from omap2/3 hwmod data, as the above references
omap2_rfbi_hwmod_class. The bits there looked correct for AM43xx to me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/734f2f87/attachment.sig>
