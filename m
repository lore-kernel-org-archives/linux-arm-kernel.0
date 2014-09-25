From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 25 Sep 2014 20:17:46 +0200
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <CAD8Lp44n3xArQ-xvZsFdYn13x80Dqv1oCY=dLm1UPxKr8XbyJQ@mail.gmail.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44n3xArQ-xvZsFdYn13x80Dqv1oCY=dLm1UPxKr8XbyJQ@mail.gmail.com>
Message-ID: <54245C4A.8050902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/09/14 01:53, Daniel Drake wrote:
> On Wed, Sep 10, 2014 at 10:37 AM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> The default mux and divider clocks are specified in device tree
>> so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
>> clocked from recommended clock source and with maximum supported
>> frequency. If needed these settings could be overrode in board
>> specific dts files, however they are in practice optimal in most
>> cases.
> 
> Another consideration for this patch.
> 
> fimc-core.c already has probe-time code that tries to set the clock
> frequency, using a clock-frequency property in the DT, and falling
> back to a hardcoded value in the driver. Maybe it is best to just set
> the clock rate from one place.

Indeed, thanks for pointing this out. I will submit a patch to remove
the fallback in fimc-core.c. So the driver doesn't touch both: clock
rate and parent setting if 'clock-rates' property is specified in DT.
I think clock-frequency property in the FIMC DT binding should be
deprecated. So the initial parent clock and frequency settings are
handled similarly for all relevant IP blocks, and there is no need
to code such things in each individual driver.

--
Thanks,
Sylwester
