From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 May 2016 02:04:41 +0200
Subject: [PATCH v4 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <3339348.mi5ytyqrb0@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2016 01:30:10 PM Sudeep Holla wrote:
> ACPI 6.0 introduced an optional object _LPI that provides an alternate
> method to describe Low Power Idle states. It defines the local power
> states for each node in a hierarchical processor topology. The OSPM can
> use _LPI object to select a local power state for each level of processor
> hierarchy in the system. They used to produce a composite power state
> request that is presented to the platform by the OSPM.
> 
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
> 
> This patch adds initial support for Platform coordination scheme of LPI.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/bus.c              |  11 +-
>  drivers/acpi/processor_driver.c |   2 +-
>  drivers/acpi/processor_idle.c   | 441 +++++++++++++++++++++++++++++++++++-----
>  include/acpi/processor.h        |  25 ++-
>  include/linux/acpi.h            |   4 +
>  5 files changed, 422 insertions(+), 61 deletions(-)
> 
> Hi Rafael,
> 
> Yet to be discussed(retained as in from previous version):

I somehow didn't realize that you had been waiting for my feedback.  Sorry
about that.

> - Kconfig entry removal: Need feedback on how to deal with that
>   without having to introduce dummy _CST related ARM64 callbacks
> - Didn't defer processing of LPI buffers to flattening as it
>   results in the same buffer decoded multiple times
> - ACPI_CSTATE_INTEGER : IMO it's reasonable to keep it aroundsince the
>   it's part of LPI specification(not just ARM FFH)

OK, I'll have a look tomorrow.

Thanks,
Rafael
