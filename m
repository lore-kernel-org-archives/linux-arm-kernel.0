From: ido@wizery.com (Ido Yariv)
Date: Sun, 30 Dec 2012 17:17:22 +0200
Subject: [PATCH] hwspinlock/core: Add testing capabilities
In-Reply-To: <CAKvkGKcHfJZ++B+sq2NUZT=EDW7C+Zd3zxsOjY1MV2YA9ecE7A@mail.gmail.com>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
 <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
 <20121230142710.GA16250@WorkStation.localnet>
 <CAKvkGKcHfJZ++B+sq2NUZT=EDW7C+Zd3zxsOjY1MV2YA9ecE7A@mail.gmail.com>
Message-ID: <20121230151722.GB16890@WorkStation.localnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Sun, Dec 30, 2012 at 10:56:53PM +0800, steve.zhan wrote:
> Thanks, Ido.
> 
>       I think if hwspinlock mudule probe register have not return 0 Or
> executed over,  we can assume that system can not do acquire the
> 
> lock, that must be later than hardware module register..

That's actually not what I was concerned about. If
hwspin_lock_register_single returns 0, anyone could potentially request
and acquire that lock. If we then call hwspin_lock_tests it could
potentially fail since the lock might already be acquired and the first
call to trylock will not succeed.

Since there's no real advantage in testing the locks after registering
them, I suggest we keep the current implementation.

Thanks,
Ido.
