From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Tue, 17 Oct 2017 00:29:42 +0200
Subject: [PATCH v4 0/6] K2G: Add QSPI support
In-Reply-To: <6f507813-388a-13e5-31ba-736b419744fa@gmail.com>
References: <20171003051925.8821-1-vigneshr@ti.com>
 <09cc0a61-3f73-4a10-2d67-32515a7da861@ti.com>
 <6f507813-388a-13e5-31ba-736b419744fa@gmail.com>
Message-ID: <69beca0c-68a2-2d2c-d4a8-6f05a1fbc957@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Le 16/10/2017 ? 11:28, Marek Vasut a ?crit?:
> On 10/16/2017 08:15 AM, Vignesh R wrote:
>>
>>
>> On Tuesday 03 October 2017 10:49 AM, Vignesh R wrote:
>>>
>>>
>>> This series adds support for Cadence QSPI IP present in TI's 66AK2G SoC.
>>> The patches enhance the existing cadence-quadspi driver to support
>>> loopback clock circuit, pm_runtime support and tweaks for 66AK2G SoC.
>>
>> Gentle ping on the series...
> 
> It's IMO OK, Cyrille, can you pick it ?
>

The series looks good to me too.

Marek, could you please add you "Acked-by" or "Reviewed-by" tag for the
record in patchwork ? It will be automatically added when I use
"pwclient git-am -s" to merge the patches into the spi-nor/next branch.

Best regards,

Cyrille


>>>
>>> Change log:
>>>
>>> v4:
>>> * New patch to fix error handling sequence in probe.
>>>
>>> v3:
>>> * Fix build warnings reported by kbuild test bot.
>>>
>>> Resend:
>>> * Rebase to latest linux-next.
>>> * Collect Acked-bys
>>>
>>> v2:
>>> * Drop DT patches. Will be sent as separate series as requested by
>>>  maintainer.
>>> * Split binding docs into separate patches.
>>> * Address comments by Rob Herring.
>>>
>>> Vignesh R (6):
>>>   mtd: spi-nor: cadence-quadspi: Add TI 66AK2G SoC specific compatible
>>>   mtd: spi-nor: cadence-quadspi: add a delay in write sequence
>>>   mtd: spi-nor: cadence-quadspi: Add new binding to enable loop-back
>>>     circuit
>>>   mtd: spi-nor: cadence-quadspi: Add support to enable loop-back clock
>>>     circuit
>>>   mtd: spi-nor: cadence-quadspi: Fix error path in probe
>>>   mtd: spi-nor: cadence-quadspi: Add runtime PM support
>>>
>>>  .../devicetree/bindings/mtd/cadence-quadspi.txt    |  7 ++-
>>>  drivers/mtd/spi-nor/cadence-quadspi.c              | 55 +++++++++++++++++++---
>>>  2 files changed, 55 insertions(+), 7 deletions(-)
>>>
>>
> 
> 
