From: dhdang@apm.com (Duc Dang)
Date: Fri, 9 Oct 2015 13:45:47 -0700
Subject: arm/arm64: GICv2 driver does not have irq_disable implemented
In-Reply-To: <alpine.DEB.2.11.1510091951250.6097@nanos>
References: <CADaLND=spbEHLZXmqsVRDsPAyNKXJHnc=Yy6ujY0em74dB5CbA@mail.gmail.com>
 <alpine.DEB.2.11.1510091951250.6097@nanos>
Message-ID: <CADaLNDmgWnOAugY20nXWz_-2m-KPKnARMWeYMDTuPdRe8SA8sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 10:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 9 Oct 2015, Duc Dang wrote:
>> Hi Thomas, Marc, Jason and All,
>>
>> In APM ARM64 X-Gene Enet controller driver, we use disable_irq_nosync to
>> disable interrupt before calling __napi_schedule to schedule packet handler
>> to process the Tx/Rx packets.
>
> Which is wrong to begin with. Disable the interrupt at the device
> level not at the interrupt line level.
>
Hi Thomas,

We could not disable the interrupt at Enet controller level due to the
controller limitation. As you said, using  disable_irq_nosync is wrong
but it looks like that the only option that we have.

Do you have any suggestion about different approach that we could try?

> Thanks,
>
>         tglx

Regards,
Duc Dang.
