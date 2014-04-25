From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Apr 2014 13:28:07 +0300
Subject: [PATCH 01/23] OMAPDSS: HDMI: lane config support
In-Reply-To: <535A3395.4050106@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-2-git-send-email-tomi.valkeinen@ti.com>
 <535A3395.4050106@ti.com>
Message-ID: <535A38B7.9050009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/14 13:06, Archit Taneja wrote:

> I spent some time to see if we could get create lane_cfg_val without
> having the table above, looks like there is no pattern at all in the
> register field.

There is a pattern, but I wasn't able to figure out a formula to model
it. And as the array was not very long, and was easy to create with copy
paste and search-replace from the TRM, I thought it's just simplest way
to do it.

>> +
>> +    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, lane_cfg_val, 26,
>> 22);
>> +    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, pol_val, 30, 27);
>> +}
>> +
>>   int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp,
>>               struct hdmi_config *cfg)
>>   {
>> @@ -92,8 +183,7 @@ int hdmi_phy_enable(struct hdmi_phy_data *phy,
>> struct hdmi_wp_data *wp,
>>       /* Setup max LDO voltage */
>>       REG_FLD_MOD(phy->base, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
>>
>> -    /* Write to phy address 3 to change the polarity control */
>> -    REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);
> 
> wow, didn't realize it was hardcoded like this.
> 
> Reviewed-by: Archit Taneja <archit@ti.com?

Thanks!

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/78769b28/attachment.sig>
