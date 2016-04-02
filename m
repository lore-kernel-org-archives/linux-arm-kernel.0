From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 2 Apr 2016 19:12:30 +0300
Subject: [PATCH] ARM: dts: armv7-m: add address to unit name
In-Reply-To: <1459577299-2818-1-git-send-email-stefan@agner.ch>
References: <1459577299-2818-1-git-send-email-stefan@agner.ch>
Message-ID: <56FFEF6E.2000002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/2/2016 9:08 AM, Stefan Agner wrote:

> Add address to unit name to remove the following warning:
>   Warning (unit_address_vs_reg): Node /nv-interrupt-controller has a
>   reg or ranges property, but no unit name
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Arnd,
>
> Not sure through which tree this should go but an earlier patch
> seemd to be applied directly by you...
>
> --
> Stefan
>
>   arch/arm/boot/dts/armv7-m.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armv7-m.dtsi b/arch/arm/boot/dts/armv7-m.dtsi
> index b1ad7cf..8126bec 100644
> --- a/arch/arm/boot/dts/armv7-m.dtsi
> +++ b/arch/arm/boot/dts/armv7-m.dtsi
> @@ -1,7 +1,7 @@
>   #include "skeleton.dtsi"
>
>   / {
> -	nvic: nv-interrupt-controller  {
> +	nvic: nv-interrupt-controller at 0xe000e100 {

    Drop "0x" from <unit address> please. And the name should be just 
"interrupt-controller at ..."

WBR, Sergei
