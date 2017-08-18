From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 Aug 2017 22:34:11 -0700
Subject: [PATCH v4 0/3] Add support for Broadcom iProc mailbox controller
In-Reply-To: <75e8060f-7e9e-8e7c-2eee-a5c9321f3d3f@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <75e8060f-7e9e-8e7c-2eee-a5c9321f3d3f@broadcom.com>
Message-ID: <e0b8a198-a734-e412-e364-0897f094b78d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/16/2017 12:08 PM, Jonathan Richardson wrote:
> Pinging maintainer. Jassi, have you had a chance to look at this yet? Thanks.

Jassi did provide some feedback, should we expect a v5 at some point? Thanks

> 
> On 17-01-26 12:37 PM, Jonathan Richardson wrote:
>> This patch set contains mailbox support for Broadcom iProc based SoC's. The
>> mailbox controller handles all communication with a Cortex-M0 MCU processor that
>> provides support for power, clock, and reset management. The mailbox controller
>> for Cygnus is enabled in DT.
>>
>> Changes from v3:
>>  - DT changes merged into one commit.
>>
>> Changes from v2:
>>  - Fixed binding to remove leading 0 (Rob's comment). Also added more detail as
>>    suggested by Jassi.
>>  - Added changelog to dt binding and enable dts commits.
>>  - Changed year in copyright in bcm_iproc_mailbox.h.
>>  - Changes to bcm-cygnus.dtsi were prematurely merged into the mainline after
>>    Rob acked the DT changes but Jassi suggested changes to the mailbox driver.
>>    The result was that the mailbox controller node and changes to the crmu gpio
>>    driver to enable interrupt handling were incorrectly added to the dtsi. A
>>    commit is included in this patchset to revert those changes. Enabling
>>    interrupt handling in the the crmu gpio driver will be introduced when the
>>    interrupt controller driver is added to provide mailbox interrupt support.
>>
>> Jonathan Richardson (3):
>>   dt-bindings: Document Broadcom iProc mailbox controller driver
>>   mailbox: Add iProc mailbox controller driver
>>   ARM: dts: Enable Broadcom iProc mailbox controller
>>
>>  .../bindings/mailbox/brcm,iproc-mailbox.txt        |  18 ++
>>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   8 +-
>>  drivers/mailbox/Kconfig                            |  10 ++
>>  drivers/mailbox/Makefile                           |   2 +
>>  drivers/mailbox/bcm-iproc-mailbox.c                | 199 +++++++++++++++++++++
>>  include/linux/mailbox/bcm_iproc_mailbox.h          |  32 ++++
>>  6 files changed, 262 insertions(+), 7 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
>>  create mode 100644 drivers/mailbox/bcm-iproc-mailbox.c
>>  create mode 100644 include/linux/mailbox/bcm_iproc_mailbox.h
>>
> 

-- 
Florian
