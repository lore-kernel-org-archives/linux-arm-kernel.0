From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 14 Mar 2013 16:49:06 +0100
Subject: [PATCH 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <1363257453-24747-4-git-send-email-avinashphilip@ti.com> (Philip
 Avinash's message of "Thu, 14 Mar 2013 16:07:33 +0530")
References: <1363257453-24747-1-git-send-email-avinashphilip@ti.com>
 <1363257453-24747-4-git-send-email-avinashphilip@ti.com>
Message-ID: <87mwu656dp.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "P" == Philip Avinash <avinashphilip@ti.com> writes:

 P> Add da850 EHRPWM & ECAP DT node.
 P> Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
 P> clock.

 P> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
 P> ---
 P> :100644 100644 3ec1bda... 9b5b613... M	arch/arm/boot/dts/da850.dtsi
 P> :100644 100644 72466ab... e32484c... M	arch/arm/mach-davinci/da8xx-dt.c
 P>  arch/arm/boot/dts/da850.dtsi     |   30 ++++++++++++++++++++++++++++++
 P>  arch/arm/mach-davinci/da8xx-dt.c |    5 +++++
 P>  2 files changed, 35 insertions(+)

 P> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
 P> index 3ec1bda..9b5b613 100644
 P> --- a/arch/arm/boot/dts/da850.dtsi
 P> +++ b/arch/arm/boot/dts/da850.dtsi
 P> @@ -107,6 +107,36 @@
 P>  			reg = <0x21000 0x1000>;
 P>  			status = "disabled";
 P>  		};
 P> +		ehrpwm0: ehrpwm at 01f00000 {
 P> +			compatible = "ti,da850-ehrpwm";

This should be:

compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";

 P> +		ecap0: ecap at 01f06000 {
 P> +			compatible = "ti,da850-ecap";

And:

compatible = "ti,da850-ecap", "ti,am33xx-ecap";

-- 
Bye, Peter Korsgaard
