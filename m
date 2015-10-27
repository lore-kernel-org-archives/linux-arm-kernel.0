From: brijeshkumar.singh@amd.com (Brijesh Singh)
Date: Tue, 27 Oct 2015 15:01:59 -0500
Subject: [PATCH v3] EDAC: Add ARM64 EDAC
In-Reply-To: <20151027190832.GN19782@codeaurora.org>
References: <1445966985-5777-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151027190832.GN19782@codeaurora.org>
Message-ID: <562FD837.50505@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Steve.

On 10/27/2015 02:08 PM, Stephen Boyd wrote:
>> +config EDAC_CORTEX_ARM64
>> +	tristate "ARM Cortex A57/A53"
>> +	depends on EDAC_MM_EDAC && ARM64
>> +	default n
> 
> n is the default so this can be removed.
> 
noted

>> +	.driver = {
>> +		.name = DRV_NAME,
>> +		.owner = THIS_MODULE,
> 
> This line can be removed. THIS_MODULE is assigned by
> platform_driver_register().
noted. 

> 
>> +		.of_match_table = cortex_arm64_edac_of_match,
>> +	},
>> +};
>> +
>> +static int __init cortex_arm64_edac_init(void)
>> +{
>> +	return platform_driver_register(&cortex_arm64_edac_driver);
>> +}
>> +module_init(cortex_arm64_edac_init);
>> +
>> +static void __exit cortex_arm64_edac_exit(void)
>> +{
>> +	platform_driver_unregister(&cortex_arm64_edac_driver);
>> +}
>> +module_exit(cortex_arm64_edac_exit);
> 
> This can be module_platform_driver(cortex_arm64_edac_driver) now.
> 
noted.

-Brijesh
