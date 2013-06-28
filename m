From: balajitk@ti.com (Balaji T K)
Date: Fri, 28 Jun 2013 21:18:59 +0530
Subject: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
In-Reply-To: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F0F95@DLEE08.ent.ti.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
 <CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
 <51CC2A1E.2040003@ti.com>
 <CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
 <51CC67CA.2070805@ti.com>
 <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F0F95@DLEE08.ent.ti.com>
Message-ID: <51CDB06B.9010604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 June 2013 11:38 PM, Fernandes, Joel wrote:
> Hi Balaji,
>

<snip>

>>> Some patches were squashed and others dropped in the series resulting
>>> in the single patch above. This patch should be good to apply
>> Hi Joel,
>>
>> Before pushing mmc dts support for am335x, Can you please let me
>> know if below 2 patches [1] are merged/accepted,
>> IIRC these patches are needed for MMC to work properly.
>>
>> I suggest to hold the dts patch until slave_sg_limit gets merged
>> otherwise it will cause regression in am335x mmc.
>>
>> [PATCH v4 1/3] dmaengine: add dma_get_slave_sg_limits()
>> [PATCH v4 2/3] dma: edma: add device_slave_sg_limits() support
>
> Actually this is an independent regression and is currently worked on by Lars-Peter Clausen [1].
>
> Currently not having the MMC DTS merged is also a regression,

No, Right now mmc support is not added to am335x, so it is not really a regression

 > so I suggest lets take it one
> step at a time and get the DTS merged in first. Also there will be overhead of reposting this
> DTS patch later again which will not change. What do you say?
>

If it gets enabled via dts, without slave sg limit support,
file read/write will fail, possibly corrupting file system.

> Thanks,
>
> -Joel
>
> [1] https://patchwork.kernel.org/patch/2228041/
>
