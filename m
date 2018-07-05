From: faiz_abbas@ti.com (Faiz Abbas)
Date: Thu, 5 Jul 2018 12:23:45 +0530
Subject: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
In-Reply-To: <20180705055506.GI26255@atomide.com>
References: <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com> <20180703070743.GG112168@atomide.com>
 <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
 <20180703073139.GN112168@atomide.com>
 <1138704c-b7a4-391f-3404-e1bd25a4a0ff@ti.com>
 <20180705055506.GI26255@atomide.com>
Message-ID: <dccc7de2-f3d8-9fb7-4b79-951e2a59e0ca@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 05 July 2018 11:25 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180704 13:37]:
>> After taking a second look at this thread, I don't see anything big to
>> be modified.
>>
>> We both agree that "reset status bit in sysconfig register" is the quirk
>> case which can be added once such an IP is discovered in ti-sysc.
> 
> Yes agreed.
> 
>> All I need to change is SYSC_OMAP4_SOFTRESET to SYSC_SOFT_RESET_SHIFT_0
>> for better readability and rebase it to the latest mainline.
> 
> Let's not change SYSC_OMAP4_SOFTRESET as only the ti-sysc
> driver needs to know that and it can be set based on the
> compatible.

Ok.
> 
> How about replace ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS
> test with just ddata->cfg.syss_mask test in your sysc_reset()?
> 
> We still need to set SYSC_QUIRK_RESET_STATUS too for pdata
> callbacks.

Sure. Do reset in ti-sysc only if dt has the correct syss_mask.

Rebasing and posting v4 soon.

Thanks,
Faiz
