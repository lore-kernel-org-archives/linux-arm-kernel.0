From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 05 Sep 2013 12:10:26 +0200
Subject: [PATCH 2/2] arm: dt: Exynos5420: populate cpu node enteries to 8
 cpus
In-Reply-To: <CANuQgHGSAGhA_LzU1aP05J86wjjS0qibPTXZM8ka0O3jZz8Kpw@mail.gmail.com>
References: <1378373086-30676-1-git-send-email-chander.kashyap@linaro.org>
 <3875313.jvPsk6a1oV@amdc1227>
 <CANuQgHGSAGhA_LzU1aP05J86wjjS0qibPTXZM8ka0O3jZz8Kpw@mail.gmail.com>
Message-ID: <1772890.cJdvnBcfyj@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 of September 2013 15:33:17 Chander Kashyap wrote:
> Hi Tomasz,
> 
> On 5 September 2013 15:25, Tomasz Figa <t.figa@samsung.com> wrote:
> > Hi Chander,
> > 
> > On Thursday 05 of September 2013 14:54:46 Chander Kashyap wrote:
> >> Exynos5420 is octacore SoC from samsung.
> >> Hence populate all the cpu node enteries.
> >> 
> >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> >> ---
> >> 
> >>  arch/arm/boot/dts/exynos5420.dtsi |   28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> >> b/arch/arm/boot/dts/exynos5420.dtsi index e97c87b..59489f6 100644
> >> --- a/arch/arm/boot/dts/exynos5420.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> >> @@ -57,6 +57,34 @@
> >> 
> >>                       reg = <0x3>;
> >>                       clock-frequency = <1800000000>;
> >>               
> >>               };
> >> 
> >> +
> >> +             cpu4: cpu at 4 {
> > 
> > I believe this is a typo. The @unit-address suffix should match the
> > value of reg property.
> 
> No this is not typo. It is the MPIDR value of the cpu. (24 bits of
> MPIDR register).

Right. This is what the reg property should be set to. However, the @unit-
address prefix of node name should match the value of reg property, so if 
the value of reg property is 0x100, then the node should be named cpu at 100.

Best regards,
Tomasz
