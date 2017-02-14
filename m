From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Feb 2017 18:52:29 +0200
Subject: [GIT PULL 4/4] arm64: dts: exynos: DT64 for v4.11, third round
In-Reply-To: <8a236294-a561-a857-403e-3a3a794b31f3@samsung.com>
References: <20170202183008.23500-1-krzk@kernel.org>
 <20170202183008.23500-5-krzk@kernel.org>
 <2382634.UqDUkYPZrI@wuerfel>
 <CGME20170209185703epcas3p181b744c7022b24d383bdce8409ece2ec@epcas3p1.samsung.com>
 <20170209185654.yxmubj3r4gjxcfm6@kozik-lap>
 <8a236294-a561-a857-403e-3a3a794b31f3@samsung.com>
Message-ID: <20170214165229.y3udmy7w5gm27tys@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 12:30:48PM +0100, Sylwester Nawrocki wrote:
> On 02/09/2017 07:56 PM, Krzysztof Kozlowski wrote:
> > On Thu, Feb 09, 2017 at 04:19:57PM +0100, Arnd Bergmann wrote:
> >> On Thursday, February 2, 2017 8:30:08 PM CET Krzysztof Kozlowski wrote:
> >>>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  34 +++
> >>>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  34 +++
> >>>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  49 +++-
> >>>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 302 +++++++++++----------
> >>>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |  34 +++
> >>>  drivers/clk/samsung/clk-exynos5433.c               |   8 +-
> >>>  include/dt-bindings/clock/exynos5433.h             |   5 +-
> >>>  include/dt-bindings/pinctrl/samsung.h              |   8 +
> >>>
> >> It seems a drivers/clk change slipped in there in addition to the header changes.
> >> We are trying to keep the next/dt branches free of driver changes, are you
> >> able to rework the branch without this?
> >
> > +Cc Sylwester,
> > 
> > This came from clk tree from Sylwester. It contains two changes in
> > clocks:
> > 1. Mew clock ID - we need only the header but Sylwester provided also
> >    the source file change,
> 
> That's a one patch made so there is no runtime regression.  If we stick
> to the next/dt branches being clean of driver changes I'm afraid we need
> to be prepared for the bisection breaks.
> 
> > 2. Update of frequency (used in DTS as assigned clock rate) - this
> >    is strictly source file change and we need it.
> > 
> > Overall, rework would not be trivial and it would involve Sylwester.
> > I think it is better to stay with this as is. I will remember the policy
> > for future dependencies.
> 
> The clk changes are already pulled into clk tree, we would get conflicts
> with commits that are already in the clock tree if the branch is reworked
> now.  This might not be a big issue but bisection would be broken for sure.
> 
> I'll also try to keep in future include/dt-bindings changes separate.

Arnd,

Any further comments? Are you going to pull it in?

Best regards,
Krzysztof
