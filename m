From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Sep 2011 10:56:17 +0300
Subject: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
In-Reply-To: <4E686B71.2060107@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-7-git-send-email-b-cousson@ti.com>
	<CAK=WgbYX50R_MCgwdzywgrAEDJkmDSmeSSCuuqst5UBYk_sYow@mail.gmail.com>
	<4E686B71.2060107@ti.com>
Message-ID: <CAK=WgbYgatyLWqmrZnUfSGxCkZsRiJ3sbQwmenxyiJ6JBw5vJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Thu, Sep 8, 2011 at 10:14 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hehe, I'm not the one who wrote that driver :-)
>
> This is not wrong for the current HW. The point is do we want to anticipate
> potential HW evolution that might never happen on that IP?

I originally really thought we can ignore those cases (hence the 0
base id ;), and personally I still think the scenario is a bit
fictional, and wouldn't even mind just having omap_hwspinlock_probe()
return an error if it is unexpectedly probed with a second device.

But if fixing this entirely only means doing a small change, then it's
surely nicer.

> This is no different than the multiple GPIO controllers we have today.
> Since we cannot rely on the DT nodes order, I added an explicit "id"
> attribute to provide that information to the driver. And then the baseid is
> "id * #gpios".

That would work if #hwspinlock is a fixed number, but a "baseid"
attribute would allow supporting devices with different #hwspinlocks
per device. Since I am not aware of any real hardware that does this
kind of blasphemy, I can't say if the latter is really necessary :) If
you prefer the former, I'm entirely fine with it.

Thanks,
Ohad.
