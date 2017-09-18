From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Sep 2017 17:12:48 +0100
Subject: [PATCH] arm64: dts: foundation-v8: Enable PSCI mode
In-Reply-To: <20170918153832.16356-1-daniel.thompson@linaro.org>
References: <20170918153832.16356-1-daniel.thompson@linaro.org>
Message-ID: <20170918161248.GB5106@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, Sep 18, 2017 at 04:38:32PM +0100, Daniel Thompson wrote:
> Currently if the Foundation model is running ARM Trusted Firmware then
> the kernel, which is configured to use spin tables, cannot start secondary
> processors or "power off" the simulation.
> 
> Add a couple of labels to the include file, and introduce a new .dts
> file that uses these to override the enable-method.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

This looks good, but has the unfortunate effect of leaving the
(irrelevant) cpu-release-addr property in the PSCI dts files, as that's
in the underlying dtsi file.

Could we split spin-table / PSCI parts into separate dtsi files?

e.g. have:

* foundation-v8.dtsi
* foundation-v8-gicv{2,3}.dtsi
* foundation-v8-{psci,spin-table}.dtsi

... and then combine those to build the dts files we want.

FWIW, with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
