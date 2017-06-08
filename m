From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 8 Jun 2017 09:15:24 +0200
Subject: [PATCH 0/3] omap_hsmmc: use mmc_regulator_get_supply() to get
 regulators
In-Reply-To: <20170607083612.14224-1-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
Message-ID: <CAPDyKFrMnZ0EGjdm4J0mTuaq+dp8eTEr3W-pOCowuwNEV2zwYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2017 at 10:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> This series deprecates "vmmc_aux" supply property and uses the generic
> "vqmmc" property.
>
> Not sure how exactly to handle omap3-overo-base.dtsi which already has
> both vqmmc-supply and vmmc_aux-supply without breaking old dt
> compatibility. (vqmmc-supply seems to have been added there by mistake
> from 3.15).
>
> In the dt series that will follow, will replace all vmmc_aux-supply
> with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
> vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).
>
> Kishon Vijay Abraham I (3):
>   mmc: host: omap_hsmmc: Do not initialize MMC regulators to NULL on
>     error
>   mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to get
>     regulators
>   Documentation: dt-bindings: Document deprecation of "vmmc_aux" and
>     using "vqmmc"
>
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  2 +-
>  drivers/mmc/host/omap_hsmmc.c                      | 55 +++++++++-------------
>  2 files changed, 24 insertions(+), 33 deletions(-)
>
> --
> 2.11.0
>

Besides the minor comment for patch2 this looks good to me.

In case there are no other comments, and that you agree with my
suggested change, you don't need to re-spin.

Kind regards
Uffe
