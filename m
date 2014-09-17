From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Wed, 17 Sep 2014 02:31:14 +0100
Subject: [PATCH v4 05/18] ARM64 / ACPI: Introduce sleep-arm.c
In-Reply-To: <20140912154903.GE5532@arm.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-6-git-send-email-hanjun.guo@linaro.org>
 <20140912145102.GB5532@arm.com>
 <20140912151850.GB9234@xora-haswell.xora.org.uk>
 <20140912154903.GE5532@arm.com>
Message-ID: <20140917013114.GB31214@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 04:49:03PM +0100, Catalin Marinas wrote:

> Now, for x86, do we need acpi_sleep_init() when CONFIG_ACPI_SLEEP is
> off? If not, we could simply add a dummy acpi_sleep_init() function when
> !ACPI_SLEEP and don't enable the config option for arm64.

The !ACPI_SLEEP case still uses the ACPI code for powering the system 
down. I'd recommend adding a new CONFIG_ACPI_POWER_OFF option, wrapping 
the remaining code in sleep.c and disabling that on ARM.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
