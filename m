From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:00 +0100
Subject: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <20140814112911.GA5039@red-moon>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
 <20140814112911.GA5039@red-moon>
Message-ID: <20140818142100.GD20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 12:29:11PM +0100, Lorenzo Pieralisi wrote:
> Here the refreshed patch is:
> 
> -- >8 --
> Subject: [PATCH] drivers: cpuidle: implement DT based idle states
>  infrastructure
> 
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
> 
> The parsing API accepts a start index that defines the first idle state
> that should be initialized by the parsing code in order to give new and
> legacy driver flexibility over which states should be parsed using the
> new DT mechanism.
> 
> The idle states list is obtained from the first cpu in the driver
> cpumask, which implicitly means the parsing code expects idle states
> (and related list of phandles) to be the same for all CPUs in the
> CPUidle driver mask. The kernel does not check this assumption, it must
> be enforced by the bootloader to ensure correct system behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig          |   3 +
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/dt_idle_states.c | 175 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/dt_idle_states.h |   5 ++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/cpuidle/dt_idle_states.c
>  create mode 100644 drivers/cpuidle/dt_idle_states.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
