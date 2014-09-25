From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 25 Sep 2014 20:05:46 +0200
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <CAD8Lp45F_rgN0JZ2n77VXSqN4C6K_hkqu6vsPqha-UbsVf4bow@mail.gmail.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp45F_rgN0JZ2n77VXSqN4C6K_hkqu6vsPqha-UbsVf4bow@mail.gmail.com>
Message-ID: <5424597A.7040904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 18/09/14 21:27, Daniel Drake wrote:
> On Wed, Sep 10, 2014 at 10:37 AM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> > The default mux and divider clocks are specified in device tree
>> > so that the FIMC devices in Exynos4210 and Exynos4x12 SoCs are
>> > clocked from recommended clock source and with maximum supported
>> > frequency. If needed these settings could be overrode in board
>> > specific dts files, however they are in practice optimal in most
>> > cases.
>
> Just curious about the Exynos4x12 situation here.
> You set the FIMC clocks as 176MHz, child of MPLL, which works for
> ODROID with a divider:
> 
> 880MHz MPLL / 5 = 176MHz
> 
> However, talking of recommended frequencies... Is 880MHz really the
> standard there?
> Isn't 800MHz the more common one?

AFAIK 880 MHz is recommended MPLL frequency for Exynos4412 EVT2.0, which
is revision of the Exynos4412 SoC the Odroid U3 boards are populated with.
You can read the main/sub revision information from the chip ID register
(at 0x10000000).
The frequencies can always be overwritten in board specific dts or DTB
could be amended by bootloader if needed.

> Also, if you happen to know, I would be curious about the equivalent
> and recommended situation for the sclk_mfc clock. On the vendor kernel
> it is clocked at 880/4 = 220MHz. When booting mainline on an odroid it
> is 880/16 = 55MHz :/

I think we should add similar entry in device tree for the MFC devices.
AFAIR now the frequency has fixed value in the driver. I saw some changes
in s5p-mfc driver WRT to clock handling recently though, possibly Jacek
or Kamil could explain what current situation is.

--
Regards,
Sylwester
