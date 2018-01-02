From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jan 2018 13:03:03 -0200
Subject: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
In-Reply-To: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, Jan 2, 2018 at 3:07 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Add 696MHz operating point according to datasheet
> (Rev. 0, 12/2015).

There is a newer version from 05/2017:
https://www.nxp.com/docs/en/data-sheet/IMX6ULAEC.pdf

>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index e0b4a46..86b3251 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -68,12 +68,14 @@
>                         clock-latency = <61036>; /* two CLK32 periods */
>                         operating-points = <
>                                 /* kHz  uV */
> +                               696000  1275000
>                                 528000  1175000
>                                 396000  1025000
>                                 198000  950000
>                         >;
>                         fsl,soc-operating-points = <
>                                 /* KHz  uV */
> +                               696000  1275000

Why 1.275V?

According to the datasheet, the minimum value for VDD_SOC_CAP is 1.15V
for all frequencies.

Adding 25mV of margin leads to 1.175V.
