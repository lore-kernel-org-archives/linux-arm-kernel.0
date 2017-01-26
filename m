From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jan 2017 17:04:48 +0000
Subject: [PATCH] arm64: skip register_cpufreq_notifier on ACPI-based
 systems
In-Reply-To: <bbc37634-f087-feef-dacd-77c5adb9ed04@codeaurora.org>
References: <1485304992-26888-1-git-send-email-pprakash@codeaurora.org>
 <20170125120306.GC8093@e106622-lin>
 <bbc37634-f087-feef-dacd-77c5adb9ed04@codeaurora.org>
Message-ID: <20170126170447.GE25871@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:49:36AM -0500, Christopher Covington wrote:

> Are you testing on QEMU or Fast Models? I was under the impression that the
> former had ACPI support. For the latter, wouldn't it be nice to have ACPI
> support in the bootwrapper.

One goal of the boot wrapper is to be as simple as reasonably possible.
ACPI support in the boot wrapper would be far from trivial, at minimum
requiring EFI support (requiring either a whole reimplementation, or
work to make EDK2 run atop of the boot wrapper).

Given that it is already possible to use ARM Trusted Firmware and EDK2
in a model environment, and this can already be used to handover ACPI
tables, one would be served better by those.

> Out of curiosity, is Mark's bootwrapper repository on kernel.org the
> best one to use these days?
> 
> http://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/

That is the canonical repo these days, yes.

Thanks,
Mark.
