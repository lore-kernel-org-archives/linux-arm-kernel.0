From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 15:28:21 +0530
Subject: [PATCH] ARM: davinci: da850-evm: fix read access to SPI flash
In-Reply-To: <m237gh2ozw.fsf@baylibre.com>
References: <20170117125742.9536-1-fparent@baylibre.com>
 <m237gh2ozw.fsf@baylibre.com>
Message-ID: <b349792e-0465-acac-5fe9-e9b4ae666ce7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 January 2017 05:55 AM, Kevin Hilman wrote:
> Fabien Parent <fparent@baylibre.com> writes:
> 
>> Read access to the SPI flash are broken on da850-evm, i.e. the data
>> read is not what is actually programmed on the flash.
>> According to the datasheet for the M25P64 part present on the da850-evm,
>> if the SPI frequency is higher than 20MHz then the READ command is not
>> usable anymore and only the FAST_READ command can be used to read data.
>>
>> This commit specifies in the DTS that we should use FAST_READ command
>> instead of the READ command.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> 
> Tested on da850-evm on top of v4.10-rc3.  This gets the DT boot
> functionatliy in line with the legacy (board-file) boot.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Applied with Kevin's Tested-by and also marked for stable. Sending pull
request for v4.10-rc shortly.

Thanks,
Sekhar
