From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 16 Nov 2014 18:39:55 +0000
Subject: [PATCH v5 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <1416048391-7557-5-git-send-email-bhupesh.sharma@freescale.com>
 (Bhupesh Sharma's message of "Sat, 15 Nov 2014 10:46:29 +0000")
References: <1416048391-7557-1-git-send-email-bhupesh.sharma@freescale.com>
 <1416048391-7557-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <86lhnb7zwk.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15 2014 at 10:46:29 AM, Bhupesh Sharma <bhupesh.sharma@freescale.com> wrote:
> This patch adds the device tree support for FSL LS2085A SoC
> based on ARMv8 architecture.
>
> Following levels of DTSI/DTS files have been created for the
> LS2085A SoC family:
>
> - fsl-ls2085a.dtsi:
> DTS-Include file for FSL LS2085A SoC.
>
> - fsl-ls2085a-simu.dts:
> DTS file for FSL LS2085a software simulator model.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Arnab Basu <arnab_basu@rocketmail.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>  arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   65 ++++++++++++
>  arch/arm64/boot/dts/fsl-ls2085a.dtsi     |  163 ++++++++++++++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a-simu.dts
>  create mode 100644 arch/arm64/boot/dts/fsl-ls2085a.dtsi
>
[...]

> diff --git a/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> b/arch/arm64/boot/dts/fsl-ls2085a.dtsi
> new file mode 100644
> index 0000000..5ff3d77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/fsl-ls2085a.dtsi

[...]

> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * We expect the enable-method for cpu's to be "psci", but this
> +		 * is dependent on the SoC FW, which will fill this in.
> +		 *
> +		 * Currently supported enable-method is psci v0.2
> +		 */
> +
> +		/* We have 4 clusters having 2 Cortex-A57 cores each */
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a57";
> +			reg = <0x0 0x0>;
> +		};
> +

[...]

> +	timer {
> +		compatible = "arm,armv8-timer";
> + interrupts = <1 13 0x1>, /* Physical Secure PPI, edge triggered */
> + <1 14 0x1>, /* Physical Non-Secure PPI, edge triggered */
> +			     <1 11 0x1>, /* Virtual PPI, edge triggered */
> +			     <1 10 0x1>; /* Hypervisor PPI, edge triggered */

Are you sure about this "edge triggered"? The A57 TRM suggests otherwise:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0488g/way1382454511590.html

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
