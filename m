From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 10:14:59 -0500
Subject: [PATCH] DT: marvell,mmp2: add MMC controllers
In-Reply-To: <20180910120243.163979-1-lkundrak@v3.sk>
References: <20180910120243.163979-1-lkundrak@v3.sk>
Message-ID: <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There's apparently four of them on a MMP2.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/boot/dts/mmp2.dtsi | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 766bbb8495b6..51d4a2d70db9 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -18,6 +18,10 @@
>                 serial3 = &uart4;
>                 i2c0 = &twsi1;
>                 i2c1 = &twsi2;
> +               sdhci0 = &mmc1;
> +               sdhci1 = &mmc2;
> +               sdhci2 = &mmc3;
> +               sdhci3 = &mmc4;

Please drop this. MMC nodes don't need an alias and if they did,
"sdhci" wouldn't be the name.

Rob
