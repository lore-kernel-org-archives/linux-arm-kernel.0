From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 May 2015 10:35:42 +0100
Subject: [PATCH 2/5] arm64: Juno: Split juno.dts into juno-base.dtsi and
 juno.dts.
In-Reply-To: <1431537092-19597-3-git-send-email-Liviu.Dudau@arm.com>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
 <1431537092-19597-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1431596142.2881.13.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 18:11 +0100, Liviu Dudau wrote:
> Prepare the device tree for adding more boards based on Juno r0.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 125 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno.dts       | 122 +-------------------------------


What criteria were used to select the contents of juno-base.dtsi?
>From what I can see, the stuff left out of base is still the same for r0
and r1 (cpu, pmu, memory, psci!). And so juno-r1.dts could just be

-------------------------------------------------------------------------
#include "juno.dts"

/ {
	model = "ARM Juno development board (r1)";

};

&memtimer {
	status = "okay";
};
-------------------------------------------------------------------------

Yes, it's a bit hacky, but avoids duplication of source code.

I can only assume there are come non-public differences between r0 and
r1?

-- 
Tixy
