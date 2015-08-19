From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 19 Aug 2015 08:19:47 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <20150818232806.GC140911@google.com>
References: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
 <20150818224831.GA140911@google.com> <20150818232806.GC140911@google.com>
Message-ID: <10828643.SSUS2EOuvv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. August 2015, 16:28:06 schrieb Brian Norris:
> Now that I'm looking a little closer, it seems like other existing DTS's
> are broken too, then. Jerry looks like it was converted to the
> regulator-state-mem node binding, but the conversion doesn't seem to
> make sense when I compare the chromium DTS sources with the for-next
> source I see in your tree.
> 
> In -next:
> 
>      regulators {
>              mic_vcc: LDO_REG2 {
>                         regulator-name = "mic_vcc";
>                         regulator-always-on;
>                         regulator-boot-on;
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <1800000>;
>                         regulator-state-mem {
>                                 regulator-on-in-suspend;
>                         };
>                 };
>          };
> 
> But chromium had:
> 
>        regulators {
>                 mic_vcc: LDO_REG2 {
>                         regulator-always-on;
>                         regulator-boot-on;
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <1800000>;
>                         regulator-name = "mic_vcc";
>                         regulator-suspend-mem-disabled;
>                 };
>        };
> 
> So I guess I'll make the proper conversion for all the veyron variants I
> see.

great, just take into account the deep vs. shallow suspend modes :-)

The original regulator-state changes did happen when we had this suspend 
instability (counter and gpioint stuff) and I did go with the values similar to 
the rk3288-evb, as this was the only one resuming at all at the time. So I 
guess I never looked to closesly what it did, as long as the system came out 
of suspend sucessfully again :-)


Heiko
