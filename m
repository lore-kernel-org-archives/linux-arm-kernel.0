From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 11 Jun 2014 20:25:49 +0200
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 6:18 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
>
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
>
> Code that initializes idle states checks the CPU idle driver cpumask so
> that multiple CPU idle drivers can be initialized through it in the
> kernel. The CPU idle driver cpumask defines which idle states should be
> considered valid for the driver, ie idle states that are valid on a set
> of cpus the idle driver manages.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig          |   9 ++
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/of_idle_states.c | 282 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/of_idle_states.h |   8 ++
>  4 files changed, 300 insertions(+)
>  create mode 100644 drivers/cpuidle/of_idle_states.c
>  create mode 100644 drivers/cpuidle/of_idle_states.h
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 1b96fb9..760ce20 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,6 +30,15 @@ config CPU_IDLE_GOV_MENU
>         bool "Menu governor (for tickless system)"
>         default y
>
> +config OF_IDLE_STATES

One question here.

Do you want this to be generally useful or is it just ARM-specific?

Rafael
