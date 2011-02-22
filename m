From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 22 Feb 2011 07:13:59 -0500
Subject: [PATCH v2 5/6] davinci: add spi devices support for
	da850/omap-l138/am18x evm
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BD48EB5@dbde02.ent.ti.com>
References: <1297257114-764-1-git-send-email-michael.williamson@criticallink.com>
	<1297257114-764-6-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BD48EB5@dbde02.ent.ti.com>
Message-ID: <4D63A887.6050301@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/22/2011 1:37 AM, Nori, Sekhar wrote:

> On Wed, Feb 09, 2011 at 18:41:53, Michael Williamson wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> This patch adds the on-board SPI flash device to the
>> DA850/OMAP-L138/AM18x EVM. It also registers the SPI flash
>> device to the MTD subsystem.
>>
>> Based on SPI flash device support for MityDSP-L138F platform.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> [michael.williamson at criticallink.com: moved da850_evm_spi1_pdata to devices-da8xx.c]
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> +static void __init da850evm_init_spi1(struct spi_board_info *info, unsigned len)
>> +{
>> +	int ret;
>> +
>> +	ret = spi_register_board_info(info, len);
>> +	if (ret)
>> +		pr_warning("failed to register board info : %d\n", ret);
>> +
>> +	da8xx_spi_pdata[1].num_chipselect = len;
>> +
>> +	ret = da8xx_register_spi(1);
>> +	if (ret)
>> +		pr_warning("failed to register spi 1 device : %d\n", ret);
>> +}
> 
> When reposting can you also modify this to print function name
> with the error message (so it is easy to find what exactly failed).
> 
> The same thing needs to be done with DA830 EVM.
> 
> Rest of the stuff looks good to me.
> 


Sure.

> Thanks,
> Sekhar
