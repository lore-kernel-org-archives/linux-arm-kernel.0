From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 6 Jul 2010 14:58:00 +0900
Subject: [RFC PATCH 0/3] ARM: S5PV210: common struct clk support
In-Reply-To: <1278394874-8695-1-git-send-email-myungjoo.ham@samsung.com>
References: <1278394874-8695-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <AANLkTinlQw7KfnOjQxMOI-3I9pqFwUE4hnQ6hLNNmefF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I forgot to update copyright statements in these patches.

I will update them when I revise the patches with the comments.





Cheers!

- MyungJoo

On Tue, Jul 6, 2010 at 2:41 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> These patches enable S5PV210 to use the common struct clk patch:
> ([PATCH 0/2] Common struct clk implementation, v5) when a user selects
> "S5PV210_USE_COMMON_STRUCT_CLK" (Use common struct clk for S5PV210
> clock framework). Because the common struct clk implementation patches
> appear to be still in-progress, these patches allow users to turn-on and
> off common struct clk feature for S5PV210.
>
>
> Note that when common struct clk is used, a clock should be defined
> with struct clk_samsung, not with struct clk although struck clk can
> be registered because the behavior can be erratic.
>
>
> We will update the patch when Common struct clk implementation is updated.
> This patch is for v5 patch.
>
>
> MyungJoo Ham (3):
> ?ARM: SAMSUNG: Add common struct clk support for Samsung SoCs
> ?ARM: S5P: common struct clk support.
> ?ARM: S5PV210: common struct clk support.
>
> ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? ? ? ? ? ? ? | ? 10 +
> ?arch/arm/mach-s5pv210/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?5 +-
> ?arch/arm/mach-s5pv210/clock-common-clk.c ? ? ? ? ?| 1062 +++++++++++++++++++++
> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ? ? ? ?| ? ?3 +-
> ?arch/arm/plat-s5p/clock-common-clk.c ? ? ? ? ? ? ?| ?163 ++++
> ?arch/arm/plat-s5p/include/plat/s5p-clock.h ? ? ? ?| ? 18 +
> ?arch/arm/plat-samsung/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?9 +
> ?arch/arm/plat-samsung/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?9 +-
> ?arch/arm/plat-samsung/clock-clksrc-common-clk.c ? | ?238 +++++
> ?arch/arm/plat-samsung/clock-common-clk.c ? ? ? ? ?| ?471 +++++++++
> ?arch/arm/plat-samsung/include/plat/clock-clksrc.h | ? ?8 +
> ?arch/arm/plat-samsung/include/plat/clock.h ? ? ? ?| ? 68 ++
> ?arch/arm/plat-samsung/pwm-clock-common-clk.c ? ? ?| ?499 ++++++++++
> ?13 files changed, 2558 insertions(+), 5 deletions(-)
> ?create mode 100644 arch/arm/mach-s5pv210/clock-common-clk.c
> ?create mode 100644 arch/arm/plat-s5p/clock-common-clk.c
> ?create mode 100644 arch/arm/plat-samsung/clock-clksrc-common-clk.c
> ?create mode 100644 arch/arm/plat-samsung/clock-common-clk.c
> ?create mode 100644 arch/arm/plat-samsung/pwm-clock-common-clk.c
>
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
