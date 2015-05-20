From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 May 2015 15:32:59 -0700
Subject: [PATCH 2/2 v4] ARM: dts: atlas7: add fixed frequency clocks in
 car node
In-Reply-To: <1432111834-21178-2-git-send-email-21cnbao@gmail.com>
References: <1432111834-21178-1-git-send-email-21cnbao@gmail.com>
 <1432111834-21178-2-git-send-email-21cnbao@gmail.com>
Message-ID: <20150520223259.GV31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20, Barry Song wrote:
> From: Guo Zeng <Guo.Zeng@csr.com>
> 
> This patch adds the fixed clocks of external crystal oscillators.
> 
> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v4: move the clocks to be global;
> 
>  arch/arm/boot/dts/atlas7.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
> index a753178..1760dac 100644
> --- a/arch/arm/boot/dts/atlas7.dtsi
> +++ b/arch/arm/boot/dts/atlas7.dtsi
> @@ -38,6 +38,24 @@
>  		};
>  	};
>  
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;

This isn't necessary right? I dropped it and applied it.

----8<-----
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 1760dac6a2b0..5dfd3a44bf82 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -39,9 +39,6 @@
 	};
 
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-
 		xinw {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
