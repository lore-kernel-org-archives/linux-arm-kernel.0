From: jacobchen110@gmail.com (Jacob Chen)
Date: Mon, 17 Jul 2017 11:09:30 +0800
Subject: [PATCH v2 5/6] ARM: dts: rockchip: enable RGA for rk3288 devices
In-Reply-To: <3257165.sao50mFgxX@avalon>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
 <2238838.k7NpPUxaC0@avalon>
 <CAFLEztRwuzkAn_QrgRNv_yrNixuicfr99PEpR2SDyRROqe=b7w@mail.gmail.com>
 <3257165.sao50mFgxX@avalon>
Message-ID: <CAFLEztQ1Cw2UeRGUo1eXx1q4hneHTf8amQeKcVGN90nhwx-6tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

2017-07-17 10:28 GMT+08:00 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Jacob,
>
> On Sunday 16 Jul 2017 12:23:02 Jacob Chen wrote:
>> 2017-07-15 17:16 GMT+08:00 Laurent Pinchart:
>> > On Saturday 15 Jul 2017 14:58:39 Jacob Chen wrote:
>> >> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
>> >> ---
>> >>
>> >>  arch/arm/boot/dts/rk3288-evb.dtsi                 | 4 ++++
>> >>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 4 ++++
>> >>  arch/arm/boot/dts/rk3288-firefly.dtsi             | 4 ++++
>> >>  arch/arm/boot/dts/rk3288-miqi.dts                 | 4 ++++
>> >>  arch/arm/boot/dts/rk3288-popmetal.dts             | 4 ++++
>> >>  arch/arm/boot/dts/rk3288-tinker.dts               | 4 ++++
>> >
>> > Some boards are missing from this list (Fennec, Phycore, ...) What
>> > criteria have you used to decide on which ones to enable the RGA ? That
>> > should be explained in the commit message.
>>
>> Ok.
>>
>> I just enable the boards i have tested, because i can't make sure it
>> won't break the other board because of clocks or power-domains.
>
> Given the clocks and power domains shouldn't be board-specific, would it make
> sense to try and get the change tested on the remaining boards ? You could

Not all drivers have handle power domains and clocks appropriately, It
may triggers bugs,
but since it's a V4l2 driver not DRM driver, i will enable it for all
rk3288 boards.
(DRM device will try to probe in very eraly stage and update
clocks/power-domains...)


> then enable the device in the SoC .dtsi file, which would be much simpler.
>

We have many different version RGA drivers in rockchip downstream kernel.
To keep consistent, i didn't enable it in .dtsi.


>> >>  6 files changed, 24 insertions(+)
>
> --
> Regards,
>
> Laurent Pinchart
>
