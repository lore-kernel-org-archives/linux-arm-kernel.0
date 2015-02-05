From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 05 Feb 2015 12:20:27 +0100
Subject: [PATCH] mmc: core: add runtime-resume caps to support resume at
 runtime_resume
In-Reply-To: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
References: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <3859799.8I7OHevdI7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

Am Donnerstag, 5. Februar 2015, 19:06:59 schrieb Addy Ke:
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  drivers/mmc/core/host.c                       |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
> b/Documentation/devicetree/bindings/mmc/mmc.txt index 438899e..303b448
> 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -40,9 +40,20 @@ Optional properties:
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
> +- runtime-resume: resume at runtime_resume is supported
>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>    programmed with. Valid range: [0 .. 0xffff].
> 
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card
> +>>>>>>> 0064e63... FROMLIST: mmc: core: add runtime-resume caps to support

you seem to have missed some merge artifacts here because your patch should 
probably only insert the one runtime-resume line above.


Heiko
