From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 27 Feb 2016 21:17:00 +0300
Subject: [PATCH 3/4] ARM: bcm2835: Include SDHOST in the device tree.
In-Reply-To: <1456527942-3045-4-git-send-email-eric@anholt.net>
References: <1456527942-3045-1-git-send-email-eric@anholt.net>
 <1456527942-3045-4-git-send-email-eric@anholt.net>
Message-ID: <56D1E81C.9040003@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/27/2016 02:05 AM, Eric Anholt wrote:

> It's disabled by default, and will be enabled by a particular board's
> DT.  The DMA channels are also currently left out, because our DMA
> engine support doesn't yet include slave SG, and there doesn't appear
> to be a clean way to include "does slave SG" in the channel
> request/config process.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>   arch/arm/boot/dts/bcm283x.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 597a78f..7b2721b 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -366,6 +366,14 @@
>   			status = "disabled";
>   		};
>
> +		sdhost: sdhost at 7e202000 {

    Please just sd at 7e202000 to better comply with ePAPR.

[...]

MBR, Sergei
