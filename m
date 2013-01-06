From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 6 Jan 2013 10:52:17 +0800
Subject: [PATCH 0/9] ARM: PRIMA2: bringup new CSR SiRFmarco SMP SoC
In-Reply-To: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4wxJR0y1OXEjN1wYY2BTfPXe=WJ7QC8anQMLYuywT5B2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
happy new year.

2012/12/20, Barry Song <Barry.Song@csr.com>:
> this patch series enables the new CSR SiRFmarco SMP SoC.
>
> change list:
> 1. Marco has different OS timer hardware with Prima2, so add a new
> timer-marco
> 2. add platsmp.c, headsmp.S and hotplug.c for MPcore support
> 3. some hardwares have changed, like rstc, so use of_compatible to branch
> Prima2
>    and Marco
> 4. add initial .dtsi for Marco SoC and initial .dts for the EVB
> 5. use GIC for Marco instead of Prima2's IRQ controller
> 6. add DEBUG_LL uart ports for Prima2 and Marco debug ports
>
> Barry Song (9):
>   ARM: PRIMA2: add CSR SiRFmarco device tree .dts
>   ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in Kconfig
>   ARM: PRIMA2: initialize l2x0 according to mach from DT
>   ARM: PRIMA2: mv timer to timer-prima2 as we will add timer-marco
>   ARM: PRIMA2: rstc: enable the support for Marco
>   ARM: PRIMA2: rtciobg: it is also compatible with marco
>   ARM: PRIMA2: irq: make prima2 irq can work even we enable GIC for
>     Marco
>   ARM: PRIMA2: add new SiRFmarco SMP SoC infrastructures
>   ARM: PRIMA2: provide two DEBUG_LL ports for prima2 and marco
>

except those from Mark, would you kindly give more feedbacks about
this series? after this, i'd like to send out a series about SiRF
firmware based on trustzone.

-barry
