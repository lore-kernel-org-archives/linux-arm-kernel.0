From: satish.patel@ti.com (Satish Patel)
Date: Thu, 6 Feb 2014 09:16:24 +0530
Subject: [PATCH v2 3/5] char: ti-usim: Add driver for USIM module on AM43xx
In-Reply-To: <52F0E8EC.8030900@ti.com>
References: <1390192434-19386-1-git-send-email-satish.patel@ti.com>
 <1390192434-19386-4-git-send-email-satish.patel@ti.com>
 <52F0E8EC.8030900@ti.com>
Message-ID: <52F30590.1020802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/4/2014 6:49 PM, Roger Quadros wrote:
> Hi Satish,
> 
> On 01/20/2014 06:33 AM, Satish Patel wrote:
>> TI-USIM driver is a platform driver that provides a character
>> driver interface to user applications.
>>
>> It allows user applications to call IOCTL's to
>> perform smart card operations.
>>
>> Driver currently supports
>> - ATR
>> - T=0 & T=1 protocol
>> - clock stop mode
>> - smart card clock configuration
>> - Tx/Rx application data units (APDU) to smart card
>> - Interface to PHY using DT & phy interface
>>
>> Validation is done with ACOS3 smart cards
>>
>> Signed-off-by: Satish Patel <satish.patel@ti.com>
>> ---
>>  .../devicetree/bindings/ti-usim/ti-usim.txt        |   31 +
>>  drivers/char/Kconfig                               |    7 +
>>  drivers/char/Makefile                              |    1 +
>>  drivers/char/ti-usim-hw.h                          |  863 +++++++++
>>  drivers/char/ti-usim.c                             | 1859 ++++++++++++++++++++
> 
> ti-usim.c is a very large driver that does everything but looks like limited to TI hardware.
> How about splitting it into generic stuff and hw specific glue logic so that most of the generic stuff
> could be used by different hardware types.
> 
Two things over here
- First interface between user application and smartcard controller
driver. There is already an open source f/w in user space called "pcsc"
exists for this.

- Second communication between smartcard controller and smartcard phy. I
have introduce lite interface called sc_phy which covers generic stuff
between controller and phy.


>>  include/linux/ti-usim.h                            |   98 +
>>  6 files changed, 2859 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/ti-usim/ti-usim.txt
>>  create mode 100644 drivers/char/ti-usim-hw.h
>>  create mode 100644 drivers/char/ti-usim.c
>>  create mode 100644 include/linux/ti-usim.h
>>
> 
> cheers,
> -roger
> 
