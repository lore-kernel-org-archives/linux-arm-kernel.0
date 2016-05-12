From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 12 May 2016 18:03:00 +0200
Subject: [PATCH 0/4] add minimal bcm2835-sdram driver
In-Reply-To: <527736177.22944.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
 <1861597197.20753.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
 <B30D094A-1E5A-4777-8F2A-C3D53AF89044@martin.sperl.org>
 <527736177.22944.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
Message-ID: <9C676BB7-E96C-4526-B0FD-2D441C1200CC@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 12.05.2016, at 17:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi,
> 
>> Martin Sperl <kernel@martin.sperl.org> hat am 12. Mai 2016 um 17:28
>> geschrieben:
>> 
>> 
>> 
>>> On 12.05.2016, at 16:50, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>> 
>>> Hi Martin,
>>> 
>>>> kernel at martin.sperl.org hat am 12. Mai 2016 um 14:38 geschrieben:
>>>> 
>>>> 
>>>> From: Martin Sperl <kernel@martin.sperl.org>
>>>> 
>>>> As the sdram clock is a critical clock to the system
>>>> the minimal bcm2835-sdram driver claims (and enables)
>>>> this clock and also exposes the corresponding sdram
>>>> registers via debugfs.
>>> 
>>> sounds like this driver should fix an clock handling issue. Unfortunately
>>> this
>>> isn't a solution in case the driver is disabled.
>> Unfortunately there is no way around this - the driver has
>> to be enabled so that the sdram clock or the parent pll,
>> which typically is plld_core, never gets disabled.
>> 
>> The only other option would be marking the clock as critical
>> for those legacy drivers.
> 
> i would prefer this option. Since this would be more a fix we could get this
> faster in, it's more clear why we are doing that and less to review.
> 
> Did i miss a drawback?

We had long discussions already on that - and HAND_OFF did not make
it into the kernel either.

I had hoped that this was simple enough.

Martin
