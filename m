From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 20 Oct 2015 10:05:59 +0100
Subject: [PATCH v2 4/4] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <1444986537-28387-5-git-send-email-anup.patel@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
 <1444986537-28387-5-git-send-email-anup.patel@broadcom.com>
Message-ID: <562603F7.7000202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/10/15 10:08, Anup Patel wrote:
> The NAND controller on NS2 SoC is compatible with existing
> BRCM IPROC NAND driver so let's enable it in NS2 DT and
> NS2 SVK DT.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   arch/arm64/boot/dts/broadcom/ns2-svk.dts | 12 ++++++++++++
>   arch/arm64/boot/dts/broadcom/ns2.dtsi    | 14 ++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> index e5950d5..a754160 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> @@ -63,5 +63,17 @@
>   		uart3: serial at 66130000 {
>   			status = "ok";
>   		};

Better to change even the above reference, see below.

> +
> +		nand: nand at 66460000 {

In most of the cases where such static overlays are done, I have seen
the labels being used to refer back the node. Using the complete node
name again is kind of inviting trouble as even minor typo results in
creation of another node.

-- 
Regards,
Sudeep
