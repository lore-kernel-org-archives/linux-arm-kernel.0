From: inki.dae@samsung.com (Inki Dae)
Date: Sun, 6 Apr 2014 18:38:03 +0900
Subject: [PATCH v2 1/7] drm/exynos: add super device support
In-Reply-To: <20140406084729.GO7528@n2100.arm.linux.org.uk>
References: <1396355882-17010-1-git-send-email-inki.dae@samsung.com>
 <1396355882-17010-2-git-send-email-inki.dae@samsung.com>
 <533EB9C6.80302@samsung.com>
 <CAAQKjZPbzb+qvJA5y+Kco9BRv4j3iVatM_0bd+ugyuVZUbfFFg@mail.gmail.com>
 <53403E42.1010403@gmail.com>
 <20140405182423.GL7528@n2100.arm.linux.org.uk>
 <53404BF3.2010409@gmail.com>
 <CAAQKjZMSkN-ACOGKD2OecsZ6YQyafiR5F36_XnBwYC-wZj8NPA@mail.gmail.com>
 <20140406084729.GO7528@n2100.arm.linux.org.uk>
Message-ID: <CAAQKjZOAPx6oofJaeOWKzMFTzUZnHMwm1BnJ4jXqnBQ4NEpXmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2014-04-06 17:47 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Apr 06, 2014 at 01:21:24PM +0900, Inki Dae wrote:
>> As you may know, there is exynos chip that has two display
>> controllers. So it is possible to compose display pipe lines at same
>> time like below,
>>
>> fimd0-----bridges..------Panel
>> fimd1-----maybe bridges..-----CPU Panel
>>
>> How we can care such pipelines without component? Of course, it would
>> be possible somehow but I'm not sure there could be better and more
>> generic way than super device.
>>
>> And super device will make existing dtb broken but this time it might
>> be good opportunity to more generic way before more users use existing
>> dt.
>
> There has been a discussion ongoing about how to best represent display
> (and capture) stuff in DT using graphs, which you may wish to consider

Right, there was my wrong comments. Actually, I had made a discussion
about it. For this, you can refer to below link,
http://www.spinics.net/lists/dri-devel/msg55555.html

My intension there was that let's use super device approach to resolve
the probe order issue of drm drivers for embedded system, and the
graphs to compose their display pipelines. And for this, we need
generic common structure to handle various bridge devices that could
be controlled by crtc and encoder/connector drivers.

I'd be happy to get your opinions about it.

> looking at.  That discussion never reached any kind of conclusion before
> the merge window, but it does need to reach a conclusion for the next
> window.

Yes. I still think the super device approach is a best solution, and I
think the only problem here is backward compatibility.  I have a feel
that we might resolve that issue easier then we think. I think all we
have to do for it is to implement some codes for backward
compatibility on top of super device approach.

This way, we could have a better design for the future drm drivers
without being tied to the backward compatibility.

Thanks,
Inki Dae

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
