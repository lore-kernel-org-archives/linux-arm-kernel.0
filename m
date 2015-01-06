From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Jan 2015 16:09:17 +0100
Subject: [PATCH v5 1/3] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <1420541578-27968-2-git-send-email-mikko.perttunen@kapsi.fi>
References: <1420541578-27968-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420541578-27968-2-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <20150106150916.GP31830@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 12:52:56PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Hardware-triggered thermal reset requires configuring the I2C
> reset procedure. This configuration is read from the device tree,
> so document the relevant properties in the binding documentation.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 68ac65f..2fd5051 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -47,6 +47,23 @@ Required properties when nvidia,suspend-mode=<0>:
>    sleep mode, the warm boot code will restore some PLLs, clocks and then
>    bring up CPU0 for resuming the system.
>  
> +Hardware-triggered thermal reset:
> +On Tegra30, Tegra114 and Tegra124, if the 'i2c-thermtrip' subnode exists,
> +hardware-triggered thermal reset will be enabled.
> +
> +Required properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
> +- nvidia,i2c-controller-id : ID of I2C controller to send poweroff command to. Valid values are
> +                             described in section 9.2.148 "APBDEV_PMC_SCRATCH53_0" of the
> +                             Tegra K1 Technical Reference Manual.
> +- nvidia,bus-addr : Bus address of the PMU on the I2C bus
> +- nvidia,reg-addr : I2C register address to write poweroff command to
> +- nvidia,reg-data : Poweroff command to write to PMU
> +
> +Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
> +- nvidia,pinmux-id : Pinmux used by the hardware when issuing poweroff command.
> +                     Defaults to 0. Valid values are described in section 12.5.2
> +                     "Pinmux Support" of the Tegra4 Technical Reference Manual.

As discussed on IRC, I'd prefer if this referred to the Tegra K1 TRM
like the comment for the nvidia,i2c-controller-id above so that people
aren't required to look at two different documents to get these values.
I've filed an internal bug to get this information added to the Tegra K1
TRM. In addition it might be nice to copy the table with the values into
the binding document for easier reference and in case the TRM suddenly
becomes unavailable.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/28d68e5d/attachment.sig>
