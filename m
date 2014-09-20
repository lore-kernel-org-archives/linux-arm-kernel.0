From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 21 Sep 2014 01:46:03 +0200
Subject: [PATCH 3/5] ARM: mvebu: armada-xp: Correct misnumbered PCIe port
 nodes
In-Reply-To: <1411236391-422-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1411236391-422-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <541E11BB.7070202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2014 08:06 PM, Sebastian Hesselbarth wrote:
> Currently, Armada XP PCIe nodes are numbered pcie@<N>,0 with N just
> incrementing. To reflect port/lane relationship, rename the nodes
> to pcie@<port>,<lane>. While at it, add node aliases to each of pcie
> controller and port nodes and get rid of now redundant port/lane
> comments.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---

After thinking a while about the current numbering scheme, I have to
admit that it is correct. The @numbers represent assigned-address of
the pcie port and this what it is right now.

If there are no more comments, I'll resend the series without messing
with the numbering scheme.

Sebastian

> ---
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 11 ++++-------
>  arch/arm/boot/dts/armada-xp-db.dts               | 20 +++++++-------------
>  arch/arm/boot/dts/armada-xp-gp.dts               | 11 ++++-------
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  8 +++-----
>  arch/arm/boot/dts/armada-xp-matrix.dts           |  5 ++---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 12 ++++++------
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 20 ++++++++++----------
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 22 +++++++++++-----------
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 11 ++++-------
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  5 ++---
>  10 files changed, 53 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> index 0e53fad111de..1b2dd3a4000b 100644
> --- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> +++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> @@ -37,24 +37,21 @@
>  		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
>  			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
>  
> -		pcie-controller {
> +		pcie: pcie-controller {
>  			status = "okay";
>  
>  			/* First mini-PCIe port */
> -			pcie at 1,0 {
> -				/* Port 0, Lane 0 */
> +			pcie00: pcie at 0,0 {
>  				status = "okay";
>  			};
>  
>  			/* Second mini-PCIe port */
> -			pcie at 2,0 {
> -				/* Port 0, Lane 1 */
> +			pcie01: pcie at 0,1 {
>  				status = "okay";
>  			};
>  
>  			/* Renesas uPD720202 USB 3.0 controller */
> -			pcie at 3,0 {
> -				/* Port 0, Lane 3 */
> +			pcie03: pcie at 0,3 {
>  				status = "okay";
>  			};
>  		};
[...]
