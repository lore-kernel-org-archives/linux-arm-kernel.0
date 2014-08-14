From: addy.ke@rock-chips.com (addy ke)
Date: Thu, 14 Aug 2014 11:57:02 +0800
Subject: [PATCH] ARM: dts: Add mmc0 and mmc1 aliases for rk3288
In-Reply-To: <CAD=FV=XNJ9RRnOaJ5e-D60S5vjZu6UbphdWqqfRq_YfZaXoq+A@mail.gmail.com>
References: <1407974880-30626-1-git-send-email-dianders@chromium.org>	<53EC177B.1080706@rock-chips.com>
 <CAD=FV=XNJ9RRnOaJ5e-D60S5vjZu6UbphdWqqfRq_YfZaXoq+A@mail.gmail.com>
Message-ID: <53EC338E.9060409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Addy,
> 
> On Wed, Aug 13, 2014 at 6:57 PM, Addy <addy.ke@rock-chips.com> wrote:
> 
>> I think maybe it is suitable as follows:
>> mmc0 = &sdmmc
>> mmc1 = &sdio0
>> mmc2 = &sdio1
>> mmc3 = &emmc
> 
> Right, except the only ones that have landed in Heiko's tree are sdmmc
> and emmc, so we can't do sdio0 and sdio1 yet.  You could post support
> for sdio0 and adio1?

yes, I will post it today.
> 
> Also: it's really handy if emmc is 0.  See below: I don't think it's
> great to use the ID to find the sysconfig registers.
> 
> 
>> So we can get ctrl_id:
>> ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
> 
> Somehow I hadn't realized that was there.  I guess we could use that
> too.  I'd vote to remove that and use the standard "mmc" numbering
> (and get some momentum to land those patches).  If you want I'll
> repost using the mshc stuff, though.
> 
> 
>> and can get offset of registers:
>> offset = 0x200 + ctrl_id * 8 + 4 * drive_or_sample
> 
> I thought the plan was to actually implement the phase stuff as a clock driver.
> 
> ...even if we didn't, I'd rather not rely on ID like this to find the
> right address.  It's really non-obvious.
> 
> 
> 
