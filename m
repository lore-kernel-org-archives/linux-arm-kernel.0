From: drake@endlessm.com (Daniel Drake)
Date: Thu, 18 Sep 2014 17:53:40 -0600
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAD8Lp44n3xArQ-xvZsFdYn13x80Dqv1oCY=dLm1UPxKr8XbyJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 10:37 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The default mux and divider clocks are specified in device tree
> so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
> clocked from recommended clock source and with maximum supported
> frequency. If needed these settings could be overrode in board
> specific dts files, however they are in practice optimal in most
> cases.

Another consideration for this patch.

fimc-core.c already has probe-time code that tries to set the clock
frequency, using a clock-frequency property in the DT, and falling
back to a hardcoded value in the driver. Maybe it is best to just set
the clock rate from one place.

Daniel
