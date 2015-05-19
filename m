From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 May 2015 10:33:26 +0100
Subject: [PATCHv2 00/12] arm/arm64: Unify PSCI client support
In-Reply-To: <555AFA60.2070008@linaro.org>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <555AFA60.2070008@linaro.org>
Message-ID: <20150519093326.GC1035@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:54:56AM +0100, Hanjun Guo wrote:
> On 2015?05?18? 18:38, Mark Rutland wrote:
> > This series unifies the 32-bit and 64-bit PSCI client code, moving the bulk of
> > the FW invocation and probing out to a common locaiton in drivers/firmware.
> > As part of this, the remaining edge cases for PSCI 0.2 (Trusted OSs rejecting
> > CPU_OFF) are accounted for, maknig both 32-bit adn 64-bit clients more robust.
> >
> > This results in a reasonable saving in terms of lines of code, and will allow
> > for PSCI 1.0 support to be unified form the beginning, avoiding further
> > duplication.
> >
> > The series is based on v4.1-rc3.
> 
> Before I review this patch set,  I applied this patch set on
> top of v4.1-rc3 (and adding some SBSA uart patches), compiled both
> ok with ACPI=y/n on ARM64, and this patch set:
>    - booted ok with SMP with ACPI on ARM64;
>    - after boot, I do cpu hotplug operations for CPUs
>      (echo 0/1 > cpu*/online) , and it works pretty fine, so PSCI
>      CPU_ON/OFF works.
> 
> For this patch set:
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks for testing! It's very much appreciated.

Mark.
