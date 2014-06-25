From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 25 Jun 2014 15:29:06 +0100
Subject: [PATCH v5 8/8] arm64: boot: dts: update rtsm aemv8 dts with PSCI
 and idle states
In-Reply-To: <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-9-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <53AADCB2.9010802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/06/14 15:10, Lorenzo Pieralisi wrote:
> This patch updates the RTSM dts file with PSCI bindings and nodes
> describing the AEMv8 model idle states parameters.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 44 +++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> index d79de9c..4051ffb 100644
> --- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
> @@ -27,37 +27,65 @@
>   		serial3 = &v2m_serial3;
>   	};
>
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;

Standard PSCI v0.2 function IDs are used for "arm,psci-0.2", so you can drop
them here.

Regards,
Sudeep
