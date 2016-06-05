From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 5 Jun 2016 11:00:06 -0300
Subject: [PATCH RFT 2/4] ARM: dts: imx28-eukrea-mbmx28lc: add missing reg
 properties
In-Reply-To: <1465134666-13459-1-git-send-email-stefan.wahren@i2se.com>
References: <1465134666-13459-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAOMZO5DqYV97M+heNaehqFCTEiYnYKRqCfiF0FMxzqEvw-gkZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 5, 2016 at 10:51 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch adds the missing reg properties for the regulator nodes
> in order to fix the dtc warnings.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> index 8859474..581e85f 100644
> --- a/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> +++ b/arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
> @@ -84,6 +84,7 @@
>
>                 reg_3p3v: regulator at 0 {
>                         compatible = "regulator-fixed";
> +                       reg = <0>;

The proper fix here would be to remove "@0" instead.
