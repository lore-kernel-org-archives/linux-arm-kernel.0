From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 15 Jun 2015 16:49:39 +0530
Subject: [RFC] ARM: exynos: MCPM: [is this a] fix for secondary boot on
 5422?
In-Reply-To: <557EA6AE.304@samsung.com>
References: <1416896510-24612-1-git-send-email-khilman@kernel.org>
 <CAJKOXPfLEV1sQsz87ULDKX4vijqRpbGj7AcOEDiy83kukvVKVg@mail.gmail.com>
 <557EA6AE.304@samsung.com>
Message-ID: <CAP245DVU4RmkSuOR2dNV+GMwkKxAXFs_p3zo90DP2Zo4-hbhcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 3:49 PM, Przemyslaw Marczak
<p.marczak@samsung.com> wrote:
> Hello Krzysztof,
>
>
> On 06/14/2015 10:56 AM, Krzysztof Koz?owski wrote:

<snip>

> I'm trying port the hardkernel's SPL to the mainline U-Boot at present. The
> mainline SPL is implemented for E5420 and E5800. But there are few
> differences:
> - different DRAM
> - different clocks
> - different boot core (peach-pi boots from A15)
> - bl2 signature
> - hdk's SPL uses smc calls
> ... and some more.

This is really good news! Would this work leave CCI control to Linux
so that we may use MCPM to manage cpu and cluster OFF?

> The BL1 keeps signature key and some part of code, but it's code is
> proprietary - but we should be able to setup the secondary cores in BL2.
>
> When, I get the basic setup working, then I'm going to focus on the
> secondary CPU's init. I don't have the documentation for iROM code, so
> everything takes a while.
>
>  If you looking for the lowlevel code, which is executed after wakeup,
> please check this :
> https://github.com/hardkernel/u-boot/blob/odroidxu3-v2012.07/board/samsung/smdk5422/lowlevel_init.S
>
> The 'lowlevel_init' label is always executed on boot.
