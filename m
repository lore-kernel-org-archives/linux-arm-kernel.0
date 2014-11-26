From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 26 Nov 2014 15:50:45 +0300
Subject: [PATCH] ARM: shmobile: dts: koelsch: Fix flash partition label
 and size
In-Reply-To: <1416960805-15185-1-git-send-email-horms+renesas@verge.net.au>
References: <1416960805-15185-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <5475CCA5.2020300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/26/2014 3:13 AM, Simon Horman wrote:

> Update the size and names of flash partitions to match the
> expectations of the loader which are as follows:

> "loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
> "user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
> "flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]

> ["user"'s assumed breakdown]
> U-boot+ bootargs(0x0008_0000-0x0010_0000) 512KB
> Device tree     (0x0010_0000-0x0014_0000) 256KB
> uImage          (0x0014_0000-0x0060_0000) 4.75MB

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> ---

> This replaces a patch that I previously posted, "shmobile: koelsch: Fix
> flash partition label and size in device tree", which has the same aim but
> does so for an older version of the loader which to my knowledge is not
> found in the wild.

> I plan to post a similar patch for Lager if this one goes well.

> I have been informed that the flash layout should also be the same
> for Alt (which currently does not have flash in its dts file in mainline).

> Based on the renesas-devel-20141125-v3.18-rc6 tag of my renesas tree.
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 990af16..9a4e714 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -451,14 +451,14 @@
>   			reg = <0x00000000 0x00080000>;
>   			read-only;
>   		};
> -		partition at 80000 {
> -			label = "bootenv";
> -			reg = <0x00080000 0x00080000>;
> +		partition at 40000 {
> +			label = "user";
> +			reg = <0x00080000 0x00580000>;

    The "reg" prop doesn't match the <unit-address> pat of the name.

>   			read-only;
>   		};
> -		partition at 100000 {
> -			label = "data";
> -			reg = <0x00100000 0x03f00000>;
> +		partition at 440000 {
> +			label = "flash";
> +			reg = <0x00600000 0x03a00000>;

    Likewise.

[...]

WBR, Sergei
