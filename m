From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 9 Jul 2018 09:01:31 -0700
Subject: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <CAHLCerMZw8mftQb8iRc5+RqGGjf26ebwynPfORz0hAPxp05YfA@mail.gmail.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <20180703214822.GD129942@google.com>
 <CAHLCerMZw8mftQb8iRc5+RqGGjf26ebwynPfORz0hAPxp05YfA@mail.gmail.com>
Message-ID: <20180709160131.GM129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 04:56:51PM +0530, Amit Kucheria wrote:
> On Wed, Jul 4, 2018 at 3:18 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > Hi,
> >
> > On Mon, Jul 02, 2018 at 06:14:09PM +0530, Amit Kucheria wrote:
> >> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> >> sensors.
> >>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> index cdaabeb..edf8505 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >> @@ -221,6 +221,22 @@
> >>                       #interrupt-cells = <2>;
> >>               };
> >>
> >> +             tsens0: tsens at c222000 {
> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> >> +                     reg = <0xc263000 0x1ff>, /* TM */
> >> +                           <0xc222000 0x1ff>; /* SROT */
> >> +                     #qcom,sensors = <13>;
> >> +                     #thermal-sensor-cells = <1>;
> >> +             };
> >> +
> >> +             tsens1: tsens at c223000 {
> >> +                     compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> >> +                     reg = <0xc265000 0x1ff>, /* TM */
> >> +                           <0xc223000 0x1ff>; /* SROT */
> >> +                     #qcom,sensors = <8>;
> >> +                     #thermal-sensor-cells = <1>;
> >> +             };
> >> +
> >>               spmi_bus: spmi at c440000 {
> >>                       compatible = "qcom,spmi-pmic-arb";
> >>                       reg = <0xc440000 0x1100>,
> >
> > I tested this series on an SDM845 board. Temperatures can be read from
> > the tsens0 sensors, however for tsens1 sensors I get:
> >
> > cat temp
> > cat: temp: No data available
> >
> > TRDY_READY_BIT set when reading TRDY_OFFSET in get_temp_tsens_v2().
> > Unfortunately I currently have no documentation of the registers or the
> > thermal sensors in general and couldn't investigate further.
> >
> > Any idea what could be the problem?
> 
> Strangely enough, I'm seeing this now after rebuilding my integration
> branch to test some other bits.
> 
> I've sent another version with this patch removed while I investigate
> this. Could you check if you're able to read all 8 sensors with v5?

With v6 all sensors can be read, thanks!
