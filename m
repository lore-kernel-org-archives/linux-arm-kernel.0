From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Mon, 2 Jan 2017 14:31:31 +0100
Subject: [PATCH v7 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn1ocTSvdPWnZ-+DwMfJj45cXXEDc1+=B5d3zCy2Pw+0-A@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-3-git-send-email-cedric.madianga@gmail.com>
 <20161223090019.a3jkhpb3abgjqi55@pengutronix.de>
 <CAOAejn3sc1F8T_rbSTr6-wBNncNwObeK+c6=_Q0BMahDdHXxQA@mail.gmail.com>
 <20161228212139.adkixdgvmtj2ukjs@pengutronix.de>
 <CAOAejn1ocTSvdPWnZ-+DwMfJj45cXXEDc1+=B5d3zCy2Pw+0-A@mail.gmail.com>
Message-ID: <CAOAejn3cxJdXd4i2OQk_fUiZwzUd7-U7Fi-haHUsvWg4xu_uzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

>> Is it possible to make it more obvious by doing:
>>
>>         status = read_from_status_register() & read_from_interrupt_enable_register();
>>
>> at a single place?
Contrary to what I said previously I have to keep possible_status
variable as for one irq enabled we allow several events.
For example, ITBUFEN allows to generate an irq for RXNE and for TXE events.
So, using status = read_from_status_register() &
read_from_interrupt_enable_register(); is not possible.

Best regards,

Cedric
