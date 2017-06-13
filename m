From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 13 Jun 2017 18:55:23 +0100
Subject: [PATCH 03/12] coresight: Extend the PIDR mask to cover relevant
 bits in PIDR2
In-Reply-To: <20170613175336.GC6392@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-4-git-send-email-suzuki.poulose@arm.com>
 <20170613175336.GC6392@xps15>
Message-ID: <e6c64a07-1354-b513-349e-242380f5fb59@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/17 18:53, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:42PM +0100, Suzuki K Poulose wrote:
>> As per coresight standards, PIDR2 register has the following format :
>>
>>  [2-0]	- JEP106_bits6to4
>>  [3]	- JEDEC, designer ID is specified by JEDEC.
>>
>> However some of the drivers only use mask of 0x3 for the PIDR2 leaving
>> bits [3-2] unchecked, which could potentially match the component for
>> a different device altogether. This patch fixes the mask and the
>> corresponding id bits for the existing devices.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> I have not touched the TPIU ids for Ux500 (see commit: 4339b699),
>> as I don't have a platform to fix/correct the ids.
>> ---
>>  drivers/hwtracing/coresight/coresight-funnel.c          | 4 ++--
>>  drivers/hwtracing/coresight/coresight-replicator-qcom.c | 4 ++--
>>  drivers/hwtracing/coresight/coresight-stm.c             | 8 ++++----
>>  drivers/hwtracing/coresight/coresight-tmc.c             | 4 ++--
>>  drivers/hwtracing/coresight/coresight-tpiu.c            | 4 ++--
>
> Any reason for not adding ETMv3 to the list?  From what I see in the
> documentation bit [2-0] need to 0b011 and the JEDEC bit is always 1.

I don't have a platform to test it easily. Hence the exclusion. Same for
etbv10.


Suzuki
