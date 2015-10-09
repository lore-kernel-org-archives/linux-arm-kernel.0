From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Oct 2015 19:52:49 +0200 (CEST)
Subject: arm/arm64: GICv2 driver does not have irq_disable implemented
In-Reply-To: <CADaLND=spbEHLZXmqsVRDsPAyNKXJHnc=Yy6ujY0em74dB5CbA@mail.gmail.com>
References: <CADaLND=spbEHLZXmqsVRDsPAyNKXJHnc=Yy6ujY0em74dB5CbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1510091951250.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Oct 2015, Duc Dang wrote:
> Hi Thomas, Marc, Jason and All,
> 
> In APM ARM64 X-Gene Enet controller driver, we use disable_irq_nosync to
> disable interrupt before calling __napi_schedule to schedule packet handler
> to process the Tx/Rx packets.

Which is wrong to begin with. Disable the interrupt at the device
level not at the interrupt line level.
 
Thanks,

	tglx
