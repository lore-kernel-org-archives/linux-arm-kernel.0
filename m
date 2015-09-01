From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Tue, 01 Sep 2015 14:19:20 -0700
Subject: [PATCH] ARM: dts: keystone: use one to one address translations
 under netcp
In-Reply-To: <1441139324-29296-1-git-send-email-w-kwok2@ti.com>
References: <1441139324-29296-1-git-send-email-w-kwok2@ti.com>
Message-ID: <55E61658.9010207@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/1/15 1:28 PM, WingMan Kwok wrote:
> Network subsystem NetCP in Keystone-2 devices includes some HW blocks
> that are memory mapped to ranges outside that of the NetCP itself.
> Thus address space of a child node of the NetCP node needs to be
> mapped 1:1 onto the parent address space.  Hence empty ranges
> should be used under the NetCP node.
>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>   arch/arm/boot/dts/k2e-netcp.dtsi  |    8 +++-----
>   arch/arm/boot/dts/k2hk-netcp.dtsi |   14 ++++++--------
>   arch/arm/boot/dts/k2l-netcp.dtsi  |    8 +++-----
>   3 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/k2e-netcp.dtsi b/arch/arm/boot/dts/k2e-netcp.dtsi
> index b13b3c9..e103ed9 100644
> --- a/arch/arm/boot/dts/k2e-netcp.dtsi
> +++ b/arch/arm/boot/dts/k2e-netcp.dtsi
> @@ -111,9 +111,7 @@ netcp: netcp at 24000000 {
>   	compatible = "ti,netcp-1.0";
>   	#address-cells = <1>;
>   	#size-cells = <1>;
> -
> -	/* NetCP address range */
> -	ranges = <0 0x24000000 0x1000000>;
> +	ranges;
>
What blocks are we talking here. We need to increase the
range if the current range isn't covering entire NETCP
address space. Removing range isn't a solution.

Regards,
Santosh
