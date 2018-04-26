From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Apr 2018 12:05:56 +0100
Subject: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
In-Reply-To: <20180425233121.13270-8-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-8-jeremy.linton@arm.com>
Message-ID: <c3306746-aacd-5ed8-95d6-a3186ec2089f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Call ACPI cache parsing routines from base cacheinfo code if ACPI
> is enable. Also stub out cache_setup_acpi() so that individual
> architectures can enable ACPI topology parsing.
> 

[...]

> +#ifndef CONFIG_ACPI
> +static inline int acpi_find_last_cache_level(unsigned int cpu)
> +{
> +	/* ACPI kernels should be built with PPTT support */

This sounds incorrect for x86. But I understand why you have it there.
Does it makes sense to change above to .. ?

#if !defined(CONFIG_ACPI) || (defined(CONFIG_ACPI) && !(CONFIG_ACPI_PPTT))

-- 
Regards,
Sudeep
