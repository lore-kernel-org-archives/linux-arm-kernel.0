From: oferh@marvell.com (Ofer Heifetz)
Date: Thu, 4 Feb 2016 03:22:04 +0000
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
 <CAPv3WKdh8D8GYMabALQQW-Z7L+=XhkZw2cXdYpcQ8tF0Rjckag@mail.gmail.com>
 <20160203230224.5ea52f65@free-electrons.com>
 <CAPv3WKe6=705iEtsuo0cUtugofiFa_Zt9xydRsgOV+mZ18H-3Q@mail.gmail.com>
Message-ID: <d18a261fae544e27b12a56bebf4a7006@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

I think it is a partial fix since once QA started to use this patch and found that /proc/interrupts prints serial interrupt string multiple times which is clobbering the print.

/Ofer


-----Original Message-----
From: Marcin Wojtas [mailto:mw at semihalf.com] 
Sent: Thursday, February 04, 2016 12:23 AM
To: Thomas Petazzoni; Ofer Heifetz
Cc: Gregory CLEMENT; Jason Cooper; Andrew Lunn; Sebastian Hesselbarth; arm at kernel.org; Catalin Marinas; Will Deacon; Jonathan Corbet; Mark Rutland; devicetree at vger.kernel.org; linux-ide at vger.kernel.org; Greg Kroah-Hartman; Omri Itach; linux-kernel at vger.kernel.org; Nadav Haklai; Hans de Goede; Lior Amsalem; linux-serial at vger.kernel.org; Jiri Slaby; Tejun Heo; Wilson Ding; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH v2 03/12] serial: mvebu-uart: initial support for Armada-3700 serial port

I'm sorry, indeed, I was the one to overlook - there was a lot going on in a thread and I missed it.

Ofer, as you found out that IRQF_SHARED help booting ubuntu - do you think it's a hack or fix?

Best regards,
Marcin

2016-02-03 23:02 GMT+01:00 Thomas Petazzoni
<thomas.petazzoni@free-electrons.com>:
> Dear Marcin Wojtas,
>
> On Wed, 3 Feb 2016 22:41:15 +0100, Marcin Wojtas wrote:
>> Hi Gregory,
>>
>> > +       port->irq        = irq->start;
>> > +       port->irqflags   = 0;
>>
>> Same request as for v1, which you must have overlooked:
>> port->irqflags = IRQF_SHARED;
>
> Gregory didn't overlook this comment you made on v1, he even replied 
> to it. Please check Gregory's reply to your review.
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering 
> http://free-electrons.com
