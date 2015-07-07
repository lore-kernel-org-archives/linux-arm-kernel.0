From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 07 Jul 2015 09:10:36 +0200
Subject: [RFC v2 3/6] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <559ABDC5.3060200@redhat.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436184692-20927-4-git-send-email-eric.auger@linaro.org>
 <559A7425.4050506@redhat.com> <559AA02A.6060703@linaro.org>
 <559AA552.3010400@redhat.com> <559AB62C.9000503@linaro.org>
 <559ABDC5.3060200@redhat.com>
Message-ID: <559B7B6C.3060900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2015 07:41 PM, Paolo Bonzini wrote:
> 
> 
> On 06/07/2015 19:09, Eric Auger wrote:
>>>> The good thing is that this helps a bit forming a lock hierarchy across
>>>> the subsystems, for example irq bypass mutex outside vfio_platform_irq
>>>> spinlock, because you cannot have a spinlock inside the mutex.  I think
>>>> that all of your six callbacks are fine.
>> arghh, no that's wrong then. I have plenty of them in the KVM/arm vgic
>> part :-(
> 
> I checked and it's right...
> 
> /me rereads
> 
> AAAARGH.  You cannot have a mutex inside a spinlock.  What you're doing
> is fine.
Sweated up (+ heat wave in France). Was about to read again the
"concurrency and race conditions" chapter of the linux driver bible.
Might be worth anyway ;-)

Many thanks for the review

Eric
> 
> Paolo
> 
