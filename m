From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 9 Jun 2017 13:21:17 +0530
Subject: [PATCH 0/3] omap_hsmmc: use mmc_regulator_get_supply() to get
 regulators
In-Reply-To: <CAPDyKFrMnZ0EGjdm4J0mTuaq+dp8eTEr3W-pOCowuwNEV2zwYw@mail.gmail.com>
References: <20170607083612.14224-1-kishon@ti.com>
 <CAPDyKFrMnZ0EGjdm4J0mTuaq+dp8eTEr3W-pOCowuwNEV2zwYw@mail.gmail.com>
Message-ID: <19f289a5-cc1d-a14a-130a-ae45710d969e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uffe,

On Thursday 08 June 2017 12:45 PM, Ulf Hansson wrote:
> On 7 June 2017 at 10:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> This series deprecates "vmmc_aux" supply property and uses the generic
>> "vqmmc" property.
>>
>> Not sure how exactly to handle omap3-overo-base.dtsi which already has
>> both vqmmc-supply and vmmc_aux-supply without breaking old dt
>> compatibility. (vqmmc-supply seems to have been added there by mistake
>> from 3.15).
>>
>> In the dt series that will follow, will replace all vmmc_aux-supply
>> with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
>> vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).
>>
>> Kishon Vijay Abraham I (3):
>>   mmc: host: omap_hsmmc: Do not initialize MMC regulators to NULL on
>>     error
>>   mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to get
>>     regulators
>>   Documentation: dt-bindings: Document deprecation of "vmmc_aux" and
>>     using "vqmmc"
>>
>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  2 +-
>>  drivers/mmc/host/omap_hsmmc.c                      | 55 +++++++++-------------
>>  2 files changed, 24 insertions(+), 33 deletions(-)
>>
>> --
>> 2.11.0
>>
> 
> Besides the minor comment for patch2 this looks good to me.
> 
> In case there are no other comments, and that you agree with my
> suggested change, you don't need to re-spin.

Your suggested change looks good.

Thanks
Kishon
