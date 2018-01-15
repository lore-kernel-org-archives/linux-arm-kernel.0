From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Jan 2018 09:52:31 +0530
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CAK8P3a3MZX-ZsxX9h1-8kVQhn9hqY=c8L1+=e3uTfjEjBCYuPg@mail.gmail.com>
References: <20180112020711.6gp2pnsxxjzelidq@localhost>
 <20180112032223.GK3626@vireshk-i7>
 <CAOesGMggU73asY1SEUDD_BsWcrGYR___o8e5omjziOPEwJgqBQ@mail.gmail.com>
 <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
 <CAOesGMgcf9FovbzhPkKnrG4ETRFP3dsSJnTYNfp1wECMFeFOGA@mail.gmail.com>
 <CAL_JsqJVWLazDRB1me2OubqqMhdsqsR+cLSHR+K0OY3dZHcE-w@mail.gmail.com>
 <CAOesGMiyfpRyoe4dxQeNMF5invysVBEy+J5OwUhuop=JyAvZoQ@mail.gmail.com>
 <CAK8P3a3KTz0sOSbO9+sAY1Sv95hZF4Yg1qMzOaXPAZ_1pOgGpg@mail.gmail.com>
 <CAOesGMiHeitS_j9r0DsPf3k1jVJT9_z-bHyrhbB7fQ__LjjaqA@mail.gmail.com>
 <CAK8P3a3MZX-ZsxX9h1-8kVQhn9hqY=c8L1+=e3uTfjEjBCYuPg@mail.gmail.com>
Message-ID: <20180115042231.GA22978@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-01-18, 23:05, Arnd Bergmann wrote:
> I've sent patches for all the remaining MODULE_LICENSE warnings earlier
> this week, and we should now have patches for almost all the dtc
> warnings in flight. This is what I still see on my randconfig builder
> with linux-next + arm-soc/for-next + patches I sent:
> 
>      arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property):
> Missing property '#gpio-cells' in node /interrupt-controller at ec801000
> or bad phandle (referred from /ahb/apb/spi at e0100000:cs-gpios[6])
>      arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property):
> Property 'cs-gpios', cell 6 is not a phandle reference in
> /ahb/apb/spi at e0100000
>      arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property):
> Missing property '#dma-cells' in node /interrupt-controller at ec801000
> or bad phandle (referred from /ahb/apb/serial at b4100000:dmas[4])
>      arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property):
> Property 'dmas', cell 4 is not a phandle reference in
> /ahb/apb/serial at b4100000
>      arch/arm/boot/dts/spear600-evb.dtb: Warning
> (interrupts_property): Missing interrupt-parent for
> /ahb/apb/rtc at fc900000

These are all the warnings we got earlier. So none of my patches are in the
branch you tested I believe. Can you do a `git log` and see if they are present
?

-- 
viresh
