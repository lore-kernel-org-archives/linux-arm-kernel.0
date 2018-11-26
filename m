From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 26 Nov 2018 14:19:07 +0530
Subject: [PATCH 3/3] ARM: dts: Add g3d bus nodes using VDD_INT for
 Exynos542x SoC
In-Reply-To: <5BFBA2D1.8090409@samsung.com>
References: <20181123094413.1108-1-linux.amoon@gmail.com>
 <CGME20181123094508epcas5p4b7958b812bf0f64ca47006ced9fda279@epcas5p4.samsung.com>
 <20181123094413.1108-3-linux.amoon@gmail.com> <5BFBA2D1.8090409@samsung.com>
Message-ID: <CANAwSgQv8e9geQCmnB7stH7GtQ__DmNDqReJaa_Au0hxvKij7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Mon, 26 Nov 2018 at 13:08, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Anand,
>
> CLK_DOUT_ACLK_G3D is the clock for GPU h/w and it requires the buck4_reg("vdd_g3d").
>
> bus_wcore uses the buck3_reg("vdd_int"). bus_wcore and bus_g3d don't share the
> same voltage line. It is wrong to make 'bus_g3d' as the child of 'bus_wcore'
> because of using the different regulator.
>
> CLK_DOUT_ACLK_G3D and buck4_reg should be controlled from MALI driver
> with DEVFREQ framework. Unfortunately, MALI driver is not posted to mainline.
>
>

Thanks for your clarification, I missed this point. mali gpu is linked
to buck4_reg
Next time I will ask for the expert how to proceed on some changes.

Best Regards
-Anand
