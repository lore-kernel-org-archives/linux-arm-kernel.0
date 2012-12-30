From: zhanzhenbo@gmail.com (steve.zhan)
Date: Sun, 30 Dec 2012 23:39:43 +0800
Subject: [PATCH] hwspinlock/core: Add testing capabilities
In-Reply-To: <20121230151722.GB16890@WorkStation.localnet>
References: <CAKvkGKfc5jw+_ABgB8nrX37B7zHCoA5Ld0Gs5O-EDFD-Gk0OKg@mail.gmail.com>
 <20121230112018.GA14042@WorkStation.localnet>
 <CAKvkGKep9Fgib=iwCE4RnBWrfsMkJu4CcpNxUDqnkyHpkjohuA@mail.gmail.com>
 <20121230142710.GA16250@WorkStation.localnet>
 <CAKvkGKcHfJZ++B+sq2NUZT=EDW7C+Zd3zxsOjY1MV2YA9ecE7A@mail.gmail.com>
 <20121230151722.GB16890@WorkStation.localnet>
Message-ID: <CAKvkGKffWP+oqxU3rbzVFuSedtOQ3eC9U+=c402fPWEMLaYWiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Ido,
          I see.  But this is system init call order error,  something
driver interface have called before module driver init have ready,  if this
situation is exsist, we can' t release the bank pointer if only some lock
have register failed, for example, omap_hwspinlock
"reg_fail:
        pm_runtime_disable(&pdev->dev);
        kfree(bank);
"

So, because this is not problem.


Yes, this test function is good patch, i have use it for test ours hardware.

Steve.


2012/12/30 Ido Yariv <ido@wizery.com>

> That's actually not what I was concerned about. If
> hwspin_lock_register_single returns 0, anyone could potentially request
> and acquire that lock. If we then call hwspin_lock_tests it could
> potentially fail since the lock might already be acquired and the first
> call to trylock will not succeed.
>
> Since there's no real advantage in testing the locks after registering
> them, I suggest we keep the current implementation.
>



-- 
Steve Zhan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121230/b56d6281/attachment-0001.html>
