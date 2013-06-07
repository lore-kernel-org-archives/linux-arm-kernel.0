From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 07 Jun 2013 19:20:42 +0100
Subject: [PATCH] ARM: mpu: Ensure that MPU depends on CPU_V7
In-Reply-To: <20130607181126.GA11232@pengutronix.de>
References: <1370625473-21628-1-git-send-email-jonathan.austin@arm.com>
 <20130607181126.GA11232@pengutronix.de>
Message-ID: <51B2247A.1040504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/13 19:11, Uwe Kleine-K?nig wrote:
> On Fri, Jun 07, 2013 at 06:17:53PM +0100, Jonathan Austin wrote:
>> The support for the MPU is currently implemented only for R-class
>> (PMSAv7/R). Since the merge of V7M support in to the kernel it is possible
>> to select MPU support on V7M.
>>
>> This patch ensures that until MPU support for M-class processors is
>> implemented, the MPU can only be selected with R-class CPUs
>>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>> Cc: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
>> ---
>>
>> This patch is necessary now that Russell has merged the V7M work in to his
>> devel-stable branch.
>>
>> I don't have any immediate plans to implement MPU support for M-class, so this
>> patch is important to ensure we don't break building of V7M platforms.
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> I didn't check, but that might affect other nommu configs for pre-v7
> cpu's, too. (I think there is support for an at91 in the tree?!)
>

Thanks Uwe,

You're right - I just checked and without this patch we cause issues 
with at91x40_defconfig. This patch *does* fix that too.

I've added your acked-by and this time I've got the '?' :)

Jonny
