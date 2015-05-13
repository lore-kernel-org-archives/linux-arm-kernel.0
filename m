From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 10:40:56 +0100
Subject: [PATCH 09/12] arm64: psci: factor invocation code to drivers
In-Reply-To: <1431085004-32743-10-git-send-email-mark.rutland@arm.com>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-10-git-send-email-mark.rutland@arm.com>
Message-ID: <20150513094056.GA24434@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +int __init psci_dt_init(void);
> +
> +#ifdef CONFIG_ACPI
> +int __init psci_acpi_init(void);
> +bool __init acpi_psci_present(void);
> +bool __init acpi_psci_use_hvc(void);
> +#else
> +static inline int psci_acpi_init(void) { return 0; }
> +#endif

I've just realised this could result in a build failure with
CONFIG_ARM_PSCI_FW isn't selected. I've wrapped psci_dt_init in an ifdef
and tightened the checks for psci_acpi_init.

That's all pushed out to a branch [1] on kernel.org.

Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git psci/unification
