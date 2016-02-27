From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 27 Feb 2016 15:53:41 +0800
Subject: [PATCH v7 RESEND 0/4] mailbox: hisilicon: add Hi6220 mailbox
 driver
In-Reply-To: <CABb+yY0_OzKmftb0HQKyfuE+2jgOfoRLHp-ok=Ux36sK8na6Ag@mail.gmail.com>
References: <1455544226-10094-1-git-send-email-leo.yan@linaro.org>
 <CABb+yY0_OzKmftb0HQKyfuE+2jgOfoRLHp-ok=Ux36sK8na6Ag@mail.gmail.com>
Message-ID: <56D15605.5040505@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo and Jassi,

On 26/02/2016 19:40, Jassi Brar wrote:
> On Mon, Feb 15, 2016 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
>> Hi6220 mailbox supports up to 32 channels. Each channel is unidirectional
>> with a maximum message size of 8 words. I/O is performed using register
>> access (there is no DMA) and the cell raises an interrupt when messages
>> are received.
>>
>> This patch series is to implement Hi6220 mailbox driver. It registers
>> two channels into framework for communication with MCU, one is tx channel
>> and another is rx channel. Now mailbox driver is used to send message to
>> MCU to control dynamic voltage and frequency scaling for CPU, GPU and DDR.
>>
>> Changes from v6:
>> * Fix to use lowercase for hexadecimal value in DT binding document
>>
>> Changes from v5:
>> * Refine to use mailbox three specifiers for client driver, so add xlate
>>   callback function in mailbox driver to support these specifiers
>> * Refine document for property "hi6220,mbox-tx-noirq"
>>
>> Changes from v4:
>> * According to Jassi's suggestion, using DT binding to register channels
>> * Change to use operating-points-v2 to register operating points
>>
>> Changes from v3:
>> * The patch series for enabling idle state for Hi6220 has reserved memory
>>   regions, so this series will not include it anymore
>> * Refined mailbox driver according to Jassi's suggestion;
>>   Removed kfifo from mailbox driver;
>>   Removed spinlock for ipc registers accessing, due every channel has its
>>   own dedicated bit in ipc register and readl/writel will introduce memory
>>   barrier, so don't need spinlock to protect ipc registers accessing
>> * After mailbox driver is ready, can use patch 4 to enable CPU's OPPs and
>>   stub clock driver; finally can enable CPUFreq driver for CPU frequency
>>   scaling
>>
>> Changes from v2:
>> * Get rid of unused memory regions from memory node in DT, and don't use
>>   reserved-memory node according to Mark and Leif's suggestion; Haojian also
>>   has updated UEFI for efi memory info
>>
>> Changes from v1:
>> * Correct lock usage for SMP scenario
>>
>> Changes from RFC:
>> * According to Jassi's review, totally remove the abstract common driver
>>   layer and only commit driver dedicated for Hi6220
>> * According to Paul Bolle's review, fix typo issue for Kconfig and remove
>>   unnecessary dependency with OF and fix minor for mailbox driver
>> * Refine a little for dts nodes
>>
>>
>> Leo Yan (4):
>>   dt-bindings: mailbox: Document Hi6220 mailbox driver
>>   mailbox: Hi6220: add mailbox driver
>>   arm64: dts: add mailbox node for Hi6220
>>   arm64: dts: add Hi6220's stub clock node
>>
>>  .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  |  74 ++++
>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  64 ++++
>>  drivers/mailbox/Kconfig                            |   8 +
>>  drivers/mailbox/Makefile                           |   2 +
>>  drivers/mailbox/hi6220-mailbox.c                   | 395 +++++++++++++++++++++
>>
> Applied 1 & 2 to mailbox-for-next.  Patch-3&4 should go via asoc tree.

Applied 3 and 4 to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

> 
> Thanks
> 
> .
> 
