From: ido@wizery.com (Ido Yariv)
Date: Sun, 30 Dec 2012 16:27:10 +0200
Subject: [PATCH] hwspinlock/core: Add testing capabilities
In-Reply-To: <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
 <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
Message-ID: <20121230142710.GA16250@WorkStation.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Sun, Dec 30, 2012 at 10:13:08PM +0800, steve.zhan wrote:
> Hi,
> ?? Acked-by: Steve zhan zhanzhenbo at gmail.com
> ?
> ?? "I'd rather not test the spinlocks after they are registering as they
> might already be in use by then."
> 
> ??? Why? I think user must use it after hwspin_lock_register have retured
> sucess.

Once the spinlocks are registered anyone can request and acquire these.
The tests could then interfere with any users of the hwspinlock layer,
or simply fail (because the spinlocks might already be acquired).

Thanks,
Ido.
