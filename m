From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jan 2017 17:00:10 +0000
Subject: [PATCH v19 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20161221064603.11830-1-fu.wei@linaro.org>
References: <20161221064603.11830-1-fu.wei@linaro.org>
Message-ID: <20170116170010.GH5908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 21, 2016 at 02:45:48PM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
>     (1)Preparation for adding GTDT support in arm_arch_timer:
>         1. Move some enums and marcos to header file;
>         2. Add a new enum for spi type;
>         3. Improve printk relevant code;
>         4. Rename some enums and defines;

Can we please rework these first few patches into a series:

1. Clean up printk() usage
2. Rename the type macros
3. Rename the PPI enum & enum values
4. Move the type macro and PPI enum into a header
5. Add new enum for SPIs

Please leave CNTHCL_* as they originally were. It's not part of the
interface of the driver, and leaving them as they are will save us an
interdependency with KVM.

I'm happy to queue that immediately, as it's purely structural and
shouldn't have a functional impact anywhere. That will also shrink the
series a bit, and we can rebase the following patches atop of that.

>         5. Rework PPI determination;
>         6. Rework counter frequency detection;
>         7. Refactor arch_timer_needs_probing, move it into DT init call
>         8. Introduce some new structs and refactor the MMIO timer init code
>         for reusing some common code.

I'll review these in separate replies.

Thanks,
Mark.
