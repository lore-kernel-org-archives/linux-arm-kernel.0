From: drake@endlessm.com (Daniel Drake)
Date: Thu, 18 Sep 2014 13:27:29 -0600
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAD8Lp45F_rgN0JZ2n77VXSqN4C6K_hkqu6vsPqha-UbsVf4bow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Wed, Sep 10, 2014 at 10:37 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The default mux and divider clocks are specified in device tree
> so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
> clocked from recommended clock source and with maximum supported
> frequency. If needed these settings could be overrode in board
> specific dts files, however they are in practice optimal in most
> cases.

Just curious about the Exynos4x12 situation here.
You set the FIMC clocks as 176MHz, child of MPLL, which works for
ODROID with a divider:

880MHz MPLL / 5 = 176MHz

However, talking of recommended frequencies... Is 880MHz really the
standard there?
Isn't 800MHz the more common one?

Also, if you happen to know, I would be curious about the equivalent
and recommended situation for the sclk_mfc clock. On the vendor kernel
it is clocked at 880/4 = 220MHz. When booting mainline on an odroid it
is 880/16 = 55MHz :/

Thanks
Daniel
