From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Dec 2014 18:33:14 +0100
Subject: [PATCH 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
In-Reply-To: <1418404441-5518-6-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com>
 <1418404441-5518-6-git-send-email-svarbanov@mm-sol.com>
Message-ID: <1671186.DiHNtkP1SP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 December 2014 19:14:01 Stanimir Varbanov wrote:
> +config ARCH_APQ8084
> +       bool "Enable support for APQ8084"
> +       select HAVE_ARM_ARCH_TIMER
> +       select PCI
> +       select PCI_DOMAINS
> +       select PCI_MSI
> +

I would prefer not to see 'select PCI' here. Also the driver is written
to work without PCI_MSI, so I'd be much happier with just

config ARCH_APQ8084
	bool "Enable support for APQ8084"
	select HAVE_ARM_ARCH_TIMER
	select PCI_DOMAINS if PCI

but you could even drop the last line if it's possible that some machines
enable only one host bridge.

	Arnd
