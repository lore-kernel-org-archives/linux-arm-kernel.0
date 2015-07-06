From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 6 Jul 2015 19:41:25 +0200
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559AB62C.9000503@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <559A7425.4050506@redhat.com> <559AA02A.6060703@linaro.org>
 <559AA552.3010400@redhat.com> <559AB62C.9000503@linaro.org>
Message-ID: <559ABDC5.3060200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/2015 19:09, Eric Auger wrote:
>> > The good thing is that this helps a bit forming a lock hierarchy across
>> > the subsystems, for example irq bypass mutex outside vfio_platform_irq
>> > spinlock, because you cannot have a spinlock inside the mutex.  I think
>> > that all of your six callbacks are fine.
> arghh, no that's wrong then. I have plenty of them in the KVM/arm vgic
> part :-(

I checked and it's right...

/me rereads

AAAARGH.  You cannot have a mutex inside a spinlock.  What you're doing
is fine.

Paolo
