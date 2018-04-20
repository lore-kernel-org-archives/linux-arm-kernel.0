From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Apr 2018 11:41:22 +0200
Subject: [PATCH 1/8] drm/mediatek: Use regmap for register access
In-Reply-To: <1511427282.7685.1.camel@pengutronix.de>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-2-mbrugger@suse.com>
 <1511427282.7685.1.camel@pengutronix.de>
Message-ID: <3fffe06c-f19b-ef26-a19d-771611aae158@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 11/23/2017 09:54 AM, Philipp Zabel wrote:
> Hi Matthias,
> 
> On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
>> The mmsys memory space is shared between the drm and the
>> clk driver. Use regmap to access it.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 30 +++++++++++++++++-------------
>>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 13 ++++---------
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
>>  5 files changed, 26 insertions(+), 27 deletions(-)
> [...]
[...]
>>  	}
>>  
>>  	value = mtk_ddp_sel_in(cur, next, &addr);
>>  	if (value) {
>> -		reg = readl_relaxed(config_regs + addr) & ~value;
>> -		writel_relaxed(reg, config_regs + addr);
>> +		regmap_read(config_regs, addr, &reg);
>> +		reg &= ~value;
>> +		regmap_write(config_regs, addr, reg);
> 
> 		regmap_update_bits(config_regs, addr, value, 0);
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 

Thanks for having a look on that.

I'll update the next version with regmap_update_bits and leave your Reviewed-by,
hope that's ok.

Regards,
Matthias
