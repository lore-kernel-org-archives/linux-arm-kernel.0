From: adrian.wenl@gmail.com (Lei Wen)
Date: Tue, 7 Jun 2011 20:27:07 +0800
Subject: [PATCH 1/2] MTD: pxa3xx_nand: fix nand detection issue
In-Reply-To: <1307445395.11104.78.camel@localhost>
References: <1307440867-18993-1-git-send-email-leiwen@marvell.com>
	<1307445395.11104.78.camel@localhost>
Message-ID: <BANLkTin7yd3YL9sPAV+4YfDzQqSe5=NBFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Tue, Jun 7, 2011 at 7:16 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Tue, 2011-06-07 at 03:01 -0700, Lei Wen wrote:
>> When keep_config is set, the detection would goes different routine.
>> That the driver would read out the setting which is set previously
>> by bootloader. While most bootloader keep the irq mask as off, and
>> current driver need all irq default open, keep_config behavior would
>> lead to no irq at all.
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> Tested-by: Daniel Mack <zonque@gmail.com>
>> Cc: stable at kernel.org
>
> When the regression was introduced? Commit id?

This regression should be introduced by below commit:

commit f8155a404db95656f1519b28fdb96cb68f8b2364
Author: Lei Wen <leiwen@marvell.com>
Date:   Mon Feb 28 10:32:11 2011 +0800

    mtd: pxa3xx_nand: rework irq logic

So its should be:
Cc: stable at kernel.org [2.6.38+]

Best regards,
Lei
