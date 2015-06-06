From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 6 Jun 2015 13:58:33 +0200
Subject: [PATCH v5 1/2] ARM: dts: vfxxx: Add OCOTP and OCROM nodes
In-Reply-To: <fd4fcd83d901b2563ddbce84b339f42778c71260.1433494491.git.maitysanchayan@gmail.com>
References: <cover.1433494491.git.maitysanchayan@gmail.com>
 <fd4fcd83d901b2563ddbce84b339f42778c71260.1433494491.git.maitysanchayan@gmail.com>
Message-ID: <20150606115833.GP23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 05, 2015 at 02:52:37PM +0530, Sanchayan Maity wrote:
> Add a device tree node for the On-Chip One Time Programmable
> Controller (OCOTP) and the On-Chip ROM.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 2f4b04d..ed9b6b8 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -56,6 +56,13 @@
>  		compatible = "simple-bus";
>  		interrupt-parent = <&mscm_ir>;
>  		ranges;
> +		ocotp-cfg = <&ocotp 0x410 0x420>;
> +		rom-revision = <&ocrom 0x80>;
> +
> +		ocrom: ocrom {
> +			compatible = "fsl,vf610-ocrom", "syscon";
> +			reg = <0x00000000 0x18000>;
> +		};

Shouldn't that use the new nvmem framework currently being discussed,
instead of defining custom bindings?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150606/502566bf/attachment.sig>
