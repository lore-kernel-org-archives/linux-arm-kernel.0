From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 14 May 2015 11:30:40 +0100
Subject: [PATCH 2/5] arm64: Juno: Split juno.dts into juno-base.dtsi and
 juno.dts.
In-Reply-To: <1431596142.2881.13.camel@linaro.org>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
 <1431537092-19597-3-git-send-email-Liviu.Dudau@arm.com>
 <1431596142.2881.13.camel@linaro.org>
Message-ID: <20150514103040.GN2345@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 10:35:42AM +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2015-05-13 at 18:11 +0100, Liviu Dudau wrote:
> > Prepare the device tree for adding more boards based on Juno r0.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >  arch/arm64/boot/dts/arm/juno-base.dtsi | 125 +++++++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/arm/juno.dts       | 122 +-------------------------------
> 
> 
> What criteria were used to select the contents of juno-base.dtsi?
> From what I can see, the stuff left out of base is still the same for r0
> and r1 (cpu, pmu, memory, psci!). And so juno-r1.dts could just be
> 
> -------------------------------------------------------------------------
> #include "juno.dts"
> 
> / {
> 	model = "ARM Juno development board (r1)";
> 
> };
> 
> &memtimer {
> 	status = "okay";
> };
> -------------------------------------------------------------------------
> 
> Yes, it's a bit hacky, but avoids duplication of source code.
> 
> I can only assume there are come non-public differences between r0 and
> r1?

Hi Tixy,

There are potential differences. Cortex-A53 cluster in r1 has limited
CPUfreq functionality due to a chip errata and there were talks internally
to actually disable it, hence the reason for keeping CPUs outside the
juno-base.dtsi. r2 will have a different set of big CPUs as well, so this
is preparing for the future as well.

PMU are linked to the CPUs, hence the reason they stayed. As for the
memory and psci nodes the thinking behind it was mostly to allow for
ACPI to make changes there, but it does look now like retrofitting an
explanation to something that I did not give too much thought at that
moment.

Best regards,
Liviu

> 
> -- 
> Tixy
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
