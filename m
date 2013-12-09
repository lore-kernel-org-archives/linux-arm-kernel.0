From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 18:03:51 +0100
Subject: [PATCH v3 3/5] dt-bindings: add binding for clock-controller of
 s3c2443 and following
In-Reply-To: <201312031623.10187.heiko@sntech.de>
References: <201312031619.58062.heiko@sntech.de>
 <201312031623.10187.heiko@sntech.de>
Message-ID: <6031022.c4eBMggiUt@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tuesday 03 of December 2013 16:23:09 Heiko St?bner wrote:
> Starting with the s3c2443 the s3c24xx series got a new clock tree
> compared to the previous s3c24xx socs. This binding describes the
> clock controller found in the s3c2443, s3c2416 and s3c2450 socs.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/samsung,s3c2443-clock.txt       |   46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt b/Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
> new file mode 100644
> index 0000000..a3eb4ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
> @@ -0,0 +1,46 @@
> +* Samsung S3C2443 Clock Controller
> +
> +The S3C2443 clock controller generates and supplies clock to various controllers
> +within the SoC. The clock binding described here is applicable to all SoCs in
> +the s3c24x family starting with the s3c2443.
> +
> +Required Properties:
> +
> +- compatible: should be one of the following.
> +  - "samsung,s3c2416-clock" - controller compatible with S3C2416 SoC.
> +  - "samsung,s3c2443-clock" - controller compatible with S3C2443 SoC.
> +  - "samsung,s3c2450-clock" - controller compatible with S3C2450 SoC.
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- #clock-cells: should be 1.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume. Some of the clocks are available only
> +on a particular SoC.
> +
> +All available clocks are defined as preprocessor macros in
> +dt-bindings/clock/samsung,s3c2443-clock.h header and can be used in device
> +tree sources.

I believe this driver needs some external clocks to be defined as fixed
rate clocks using generic bindings. It should be noted what clocks are
needed here in the documentation.

Otherwise the patch looks fine.

Best regards,
Tomasz
