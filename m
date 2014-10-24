From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Oct 2014 23:22:07 +0200
Subject: [PATCHv0 2/2] arm: mvebu: clarify (e)SATA ports info in NETGEAR
 ReadyNAS 102 .dts file
In-Reply-To: <4af680f9a68281755e31df2491f0590046138230.1414185031.git.arno@natisbad.org>
References: <cover.1414185031.git.arno@natisbad.org>
 <4af680f9a68281755e31df2491f0590046138230.1414185031.git.arno@natisbad.org>
Message-ID: <20141024212207.GC6436@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 11:22:16PM +0200, Arnaud Ebalard wrote:
> 
> On NETGEAR ReadyNAS 102, the two disks are connected to the external
> Marvell 88SE9170 SATA Controller connected to the PCIe bus. The rear
> eSATA port is connected to the native Armada 370 SATA controller.
> 
> This patch updates the comments in .dts file wrt SATA interfaces and
> reduces the number of ports for native Armada 370 interface from 1
> to 2.

Typ0. 

Jason, can you swap the 1 and 2 around when you commit?
Save having a v2.

Otherwise

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew


> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index f79579bdf8fe..1e38628f4060 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -35,7 +35,7 @@
>  		pcie-controller {
>  			status = "okay";
>  
> -			/* Connected to Marvell SATA controller */
> +			/* Connected to Marvell 88SE9170 SATA controller */
>  			pcie at 1,0 {
>  				/* Port 0, Lane 0 */
>  				status = "okay";
> @@ -53,8 +53,9 @@
>  				status = "okay";
>  			};
>  
> +			/* eSATA interface */
>  			sata at a0000 {
> -				nr-ports = <2>;
> +				nr-ports = <1>;
>  				status = "okay";
>  			};
>  
> -- 
> 2.1.1
> 
