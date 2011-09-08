From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Thu, 8 Sep 2011 20:08:17 +0100
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <CAJe_Zhcq5ekv0TvUtYBaLb1=xrieiBrVTG0XrUHQCqRWJZ0Q0A@mail.gmail.com>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<20110908181831.GE3591@opensource.wolfsonmicro.com>
	<CAJe_Zhcq5ekv0TvUtYBaLb1=xrieiBrVTG0XrUHQCqRWJZ0Q0A@mail.gmail.com>
Message-ID: <CAG5Tg6XMwDi_VhJ8vChDgeL6_CPcwAY3j=i6vzBnsXqoxF4cyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2011 19:35, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 8 September 2011 23:48, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Sep 08, 2011 at 11:47:16PM +0530, Jassi Brar wrote:
>>
>>> Can't we do by having omap_init_audio() in arch/arm/mach-omap2/devices.c
>>> generate a platform device of name depending upon machine_is_* ?
>>
>> That's not a bad idea. ?If we were going to do that it shouldn't be OMAP
>> specific, any platform could use it. ?Though we'd need a way to override
>> it to provide platform data on systems that needs it.
> Perhaps by providing an optional call, say set_asoc_platdata(void *pdata),
> that boards could call from their init_machine() ?

That seems like a sensible approach to me.

-- 
Mans Rullgard
Multimedia
mans.rullgard at linaro.org
