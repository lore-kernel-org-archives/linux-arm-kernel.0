From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 17 Feb 2017 01:34:27 +0100
Subject: [PATCH 04/11] ARM64: Prepare Actions Semi S900
In-Reply-To: <6175161.4SuqJTY84p@wuerfel>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-5-afaerber@suse.de> <6175161.4SuqJTY84p@wuerfel>
Message-ID: <07efabbe-1c1f-40ea-339e-1c09dbbfce30@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.02.2017 um 14:43 schrieb Arnd Bergmann:
> On Wednesday, February 15, 2017 5:55:21 PM CET Andreas F?rber wrote:
>>
>> +config ARCH_OWL
>> +       bool "Actions Semi S900 SoC Family"
>> +       help
>> +         This enables support for the Actions Semiconductor S900 SoC family.
>> +
>>
> 
> There seem to be a couple of other SoCs in the same family, so
> maybe use a more generic name than S900 in the one-line
> Kconfig description.

Good point. I only tested with `make oldconfig`, so using "Owl" should
tidy the sort order in `make menuconfig` while at it. (I believe there
were more inconsistent examples, such as Armada 3700 vs. MVEBU...)

Note that I have not come across any explanation for "OWL" as an
acronym, so I'm guessing it's the bird and therefore capitalizing it.

Apart from S900, actions-semi.com shows V series S900VR and S700 as well
as GT series GT7 Cortex-A53 based SoCs. My guess[*] is these could all
be handled as ARCH_OWL, adding further differentiation below if
necessary; but Bubblegum-96 seemed the only available arm64 board for
testing so far, so any comments from Actions will be appreciated.

[*] The S500 vendor device tree was actually using ATM series models for
various nodes, so I'm inferring that the product series are closely
enough related.

However, if you would prefer ARCH_ACTIONS I wouldn't mind either - we
just need to keep it consistent across arm and arm64.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
