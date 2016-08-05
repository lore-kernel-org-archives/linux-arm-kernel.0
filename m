From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 5 Aug 2016 19:04:53 -0400
Subject: [PATCH 2/4] irqchip: irq-mvebu-pic: new driver for Marvell Armada
 7K/8K PIC
In-Reply-To: <CAP=VYLqoubxSMcJJLSqfGUPVfyggMYwpS1aVRmWri+AQvgHt5g@mail.gmail.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAP=VYLqoubxSMcJJLSqfGUPVfyggMYwpS1aVRmWri+AQvgHt5g@mail.gmail.com>
Message-ID: <CAP=VYLqpECVBSaY+iPJp0n3rDX8-YHf4cQk_+da6p8uF6NoDOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 7:00 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index fa33c50..a6f90c5 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -246,6 +246,9 @@ config MVEBU_ODMI
>>         bool
>>         select GENERIC_MSI_IRQ_DOMAIN
>>
>> +config MVEBU_PIC
>> +       bool
>
> Please switch to a builtin registration call, and remove module.h and
> all the MODULE_<xyz> references since this is a bool and not a
> tristate Kconfig.

I overlooked that someone else beat me to making the bool/tristate
comment -- oh well, that is a good thing that it is on other people's
minds too now.  Apologies for the duplicated feedback.

Paul.
