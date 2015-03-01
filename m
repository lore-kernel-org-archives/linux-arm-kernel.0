From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 01 Mar 2015 20:59:13 +0300
Subject: [PATCH v3 1/2] dts: vt8500: Add SDHC node to DTS file for WM8650
In-Reply-To: <1425226007-2757-2-git-send-email-rvolkov@v1ros.org>
References: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>
 <1425226007-2757-1-git-send-email-rvolkov@v1ros.org>
 <1425226007-2757-2-git-send-email-rvolkov@v1ros.org>
Message-ID: <54F35371.7020608@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/1/2015 7:06 PM, Roman Volkov wrote:

> Since WM8650 has the same 'WMT' SDHC controller as WM8505, and the driver
> is already in the kernel, this node enables the controller support for
> WM8650

> Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
> Reviewed-by: Alexey Charkov <alchark@gmail.com>
> ---
>   arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
> index b1c59a7..e12213d 100644
> --- a/arch/arm/boot/dts/wm8650.dtsi
> +++ b/arch/arm/boot/dts/wm8650.dtsi
> @@ -187,6 +187,15 @@
>   			interrupts = <43>;
>   		};
>
> +		sdhc at d800a000 {

    According to the ePAPR standard, the device nodes should have generic 
names according to their functions, so this node should be named just 
"sd at d800a000".

WBR, Sergei
