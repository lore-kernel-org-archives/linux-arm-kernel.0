From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Sep 2014 15:58:04 +0200
Subject: [PATCH v4 3/4] ARM: dts: add main Thermal info to rk3288
In-Reply-To: <540FBC21.2090504@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <3426113.Zcq8V2S7cg@diego> <540FBC21.2090504@rock-chips.com>
Message-ID: <6563337.jht9ZmlHCg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 10. September 2014, 10:49:05 schrieb Caesar Wang:
> Hi Heiko,
> 
> ? 2014?09?09? 19:37, Heiko St?bner ??:
> > Am Mittwoch, 3. September 2014, 10:10:38 schrieb Caesar Wang:
> >> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> >> ---
> >> 
> >>   arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/rk3288.dtsi
> >> b/arch/arm/boot/dts/rk3288.dtsi
> >> index 36be7bb..3d672e3 100644
> >> --- a/arch/arm/boot/dts/rk3288.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288.dtsi

[...]

> >> @@ -611,5 +622,12 @@
> >> 
> >>   				rockchip,pins = <5 15 3 &pcfg_pull_none>;
> >>   			
> >>   			};
> >>   		
> >>   		};
> >> 
> >> +
> >> +		tsadc {
> >> +			tsadc_int: tsadc-int {
> >> +				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
> >> +			};
> >> +		};
> > 
> > After looking this up in the schematics I see that this is the
> > overtemperature-protection output pin ... labeled OTP_OUT.
> > So I'd think the pinconfig should reflect this pin-name, especially as
> > tsadc-int suggests, that this would be an interrupt leading into the
> > tsadc, while in fact it is an output to a separate circuit.
> 
> Maybe,I guess  your mean as the follows .
> Please correct it and  Laugh out if I got it wrong.

I'll never laugh ... just try get the best solution / trying to understand 
backgrounds.

> 
> tsadc {
>              otp_out: otp-out {
>                  rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_none>;
>              };
> 
>              tsadc_int: tsadc-int {
>                  rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
>              };
>          };
> Then,I deal with the otp_out in thermal driver.
> I believe The "otp_out" will restart board if it's a high active.
> 
> tsadc_int: tsadc-int {
> +				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_up>;
> +			};
> 
> But,I think the about will be implemented in thermal driver.

I only meant the pin name (tsadc-int -> otp-out). In the schmatics the pin 
(controlled by the tsadc) is labeled otp_out and leads to the overtemperature 
protection circuit as expected. And as it's controlled by the tsadc, it should 
of course stay as the desired func_1.


Heiko
