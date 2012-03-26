From: scottwood@freescale.com (Scott Wood)
Date: Mon, 26 Mar 2012 10:53:29 -0500
Subject: [PATCH V2 3/3] ARM: kirkwood: Define NAND partitions in dts
In-Reply-To: <1332594876-8673-4-git-send-email-jm@lentin.co.uk>
References: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
 <1332594876-8673-4-git-send-email-jm@lentin.co.uk>
Message-ID: <4F7090F9.5000603@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2012 08:14 AM, Jamie Lentin wrote:
> Use devicetree to define NAND partitions. Use D-link partition scheme by
> default, to be vaguely compatible with their userland.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  arch/arm/boot/dts/kirkwood-dns320.dts |   35 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dns325.dts |   35 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dnskw.c  |   31 -----------------------------
>  3 files changed, 70 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
> index 58de7f2..fbf55ff 100644
> --- a/arch/arm/boot/dts/kirkwood-dns320.dts
> +++ b/arch/arm/boot/dts/kirkwood-dns320.dts
> @@ -25,5 +25,40 @@
>  			clock-frequency = <166666667>;
>  			status = "ok";
>  		};
> +
> +		nand at 3000000 {
> +			status = "ok";
> +

This should be "okay", not "ok" -- see IEEE1275.  Or just leave it out.

-Scott
