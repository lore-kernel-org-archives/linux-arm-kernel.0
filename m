From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 28 Feb 2014 18:28:34 -0800
Subject: [PATCH 2/2] ARM: zynq: dt: Add I2C nodes to Zynq device tree
In-Reply-To: <1393632046-20062-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
 <1393632046-20062-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <ce5fbea5-de6e-4a29-9807-cccf0f59f654@CO9EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-28 at 04:00PM -0800, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)
> 
[...]
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index c913f77a21eb..91a3a560f03b 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
[...]
> +
> +		i2c at 7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +			hwmon at 52 {
> +				compatible = "pmbus,ucd9248";
> +				reg = <52>;
> +			};
> +			hwmon at 53 {
> +				compatible = "pmbus,ucd9248";
> +				reg = <53>;
> +			};
> +			hwmon at 54 {
> +				compatible = "pmbus,ucd9248";
All these occurrences of 'pmbus' should rather be replaced with 'ti'.
I wasn't aware of how this DT node to I2C probing works - and still
haven't fully understood it - but the vendor prefix is apparently a
don't care and we could simply use the correct one here.
I have no idea how I came up with the description using 'pmbus' (we
carry this in our vendor tree for quite a while already).
Is there any document describing how a DT node is matched to an
appropriate driver? These I2C drivers usually don't have the common
'struct of_device_id'. Hence my preferred way of simply grepping through
the kernel for the compatibility string does not work.

[...]
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index 88f62c50382e..dab30f80d5b0 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
[...]
> +		i2c at 7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +			ucd90120 at 65 {
> +				compatible = "pmbus,ucd90120";
same here

	S?ren
