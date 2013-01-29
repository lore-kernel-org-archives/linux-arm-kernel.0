From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 29 Jan 2013 09:20:44 +0100
Subject: [PATCH v2 8/9] ARM: DTS: AM33XX: Add nodes for OCMC RAM and
 WKUP-M3
In-Reply-To: <1359442762-13697-9-git-send-email-vaibhav.bedia@ti.com> (Vaibhav
 Bedia's message of "Tue, 29 Jan 2013 12:29:21 +0530")
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
 <1359442762-13697-9-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <87622ge6xv.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:

 Vaibhav> Since AM33XX supports only DT-boot, this is needed
 Vaibhav> for the appropriate device nodes to be created.

 Vaibhav> Note: OCMC RAM is part of the PER power domain and supports
 Vaibhav> retention. The assembly code for low power entry/exit will
 Vaibhav> run from OCMC RAM. To ensure that the OMAP PM code does not
 Vaibhav> attempt to disable the clock to OCMC RAM as part of the
 Vaibhav> suspend process add the no_idle_on_suspend flag.

 Vaibhav> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
 Vaibhav> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
 Vaibhav> ---
 Vaibhav> v2: Add reg property

 Vaibhav>  arch/arm/boot/dts/am33xx.dtsi | 14 +++++++++++++
 Vaibhav>  1 file changed, 14 insertions(+)

 Vaibhav> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
 Vaibhav> index c2f14e8..423f898 100644
 Vaibhav> --- a/arch/arm/boot/dts/am33xx.dtsi
 Vaibhav> +++ b/arch/arm/boot/dts/am33xx.dtsi
 Vaibhav> @@ -385,5 +385,19 @@
 Vaibhav>  				mac-address = [ 00 00 00 00 00 00 ];
 Vaibhav>  			};
 Vaibhav>  		};
 Vaibhav> +
 Vaibhav> +		ocmcram: ocmcram at 40300000 {
 Vaibhav> +			compatible = "ti,ocmcram";
 Vaibhav> +			reg = <0x40300000 0x10000>;
 Vaibhav> +			ti,hwmods = "ocmcram";
 Vaibhav> +			ti,no_idle_on_suspend;
 Vaibhav> +		};
 Vaibhav> +
 Vaibhav> +		wkup_m3: wkup_m3 at 44d00000 {
 Vaibhav> +			compatible = "ti,wkup_m3";


Both of these compatible properties should probably use less generic
names, like:

ti,am3352-ocmcram
ti,am3352-wkup-m3 ('-' instead of '_')

-- 
Bye, Peter Korsgaard
