From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 26 Oct 2010 20:13:24 +0300
Subject: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 7:15 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> This is the patch series shared by Paul, for a short term fix to
> a compile break due SCM layer layer violations from tidspbridge
> driver, where the latter is used to write directly into registers
> and use SCM layer macros, among other layer bypassing.
>
> patch: "staging: tidspbridge: use new SCM DSP boot control fns"
> was split from its original version, it is meant to be on hold until
> the rest of the series gets upstreamed and can be found in the
> staging tree (unless best advice is given).
>
> Paul Walmsley (4):
> ?OMAP: control: add functions for DSP boot address/mode control
> ?OMAP3: PM: update DSP reset code to use new SCM DSP boot control
> ? ?functions
> ?OMAP: dsp: convert OMAP3430 adaptation layer to use new SCM DSP boot
> ? ?control fns
> ?staging: tidspbridge: use new SCM DSP boot control fns
>
> ?arch/arm/mach-omap2/control.c ? ? ? ? ? ? ? ? | ? 51 ++++++++++++++++++++++
> ?arch/arm/mach-omap2/control.h ? ? ? ? ? ? ? ? | ? 16 ++++---
> ?arch/arm/mach-omap2/dsp.c ? ? ? ? ? ? ? ? ? ? | ? ?4 ++
> ?arch/arm/mach-omap2/pm34xx.c ? ? ? ? ? ? ? ? ?| ? ?6 +-
> ?arch/arm/plat-omap/include/plat/dsp.h ? ? ? ? | ? ?4 ++
> ?arch/arm/plat-omap/include/plat/iva2_dsp.h ? ?| ? 56 +++++++++++++++++++++++++

Why not use the already existing dsp.h?

-- 
Felipe Contreras
