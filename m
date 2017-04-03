From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Apr 2017 10:49:45 +0100
Subject: [PATCH v23 09/11] acpi/arm64: Add memory-mapped timer support in
 GTDT driver
In-Reply-To: <20170331175105.8370-10-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-10-fu.wei@linaro.org>
Message-ID: <20170403094944.GC5706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 01, 2017 at 01:51:03AM +0800, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> On platforms booting with ACPI, architected memory-mapped timers'
> configuration data is provided by firmware through the ACPI GTDT
> static table.
> 
> The clocksource architected timer kernel driver requires a firmware
> interface to collect timer configuration and configure its driver.
> this infrastructure is present for device tree systems, but it is
> missing on systems booting with ACPI.
> 
> Implement the kernel infrastructure required to parse the static
> ACPI GTDT table so that the architected timer clocksource driver can
> make use of it on systems booting with ACPI, therefore enabling
> the corresponding timers configuration.
> 
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h      |   1 +
>  2 files changed, 147 insertions(+)

We need Lorenzo's ack on this.

Will
