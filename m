From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 9 Jun 2017 17:51:30 +0530
Subject: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
In-Reply-To: <20170608084619.GH3730@atomide.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
 <20170608084619.GH3730@atomide.com>
Message-ID: <a6ed36ef-9552-3bfb-c863-0819add51850@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 08 June 2017 02:16 PM, Tony Lindgren wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [170608 00:24]:
>> If it helps, I can host a branch with the updates on the omap_hsmmc
>> driver, such it can be pulled in from arm soc?
> 
> Great that works for me. Let's just make sure git bisect
> keeps working.
> 
>> I guess you need that as, the DT changes relies on the new vqmmc
>> binding. Or you thing it doesn't matter, because for the current
>> changes that regulator is always an always on regulator?
> 
> Or maybe we can just add the new regulator, then do a
> follow-up series to remove the old ones?

Since the driver has a fallback mechanism wherein if it's not able to find
vqmmc, it'll fallback to vmmc_aux, I don't think that's required.

Thanks
Kishon
