From: fkan@apm.com (Feng Kan)
Date: Tue, 29 Jul 2014 20:26:34 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
Message-ID: <CAL85gmAjcnh77CfuRiHsiD8SdJFsQfm=+kM-AuvxVb_gKMiOyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> But I had some luck when I did the same steps with L3 cache
> disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
> it has an L3 cache. Luckily I was able to disable it in u-boot.
>
> With the L3 cache disabled configuration I am able to
> do "kexec -e". Please see the log attached.
>
> Feng,
> I doubt kernel is unaware of the presence of L3 cache, this subsequently
> makes "kexec -e" to fail.
Yes, L3 is turned on prior to entering Linux. It is used when Linux
enable cache in
the MMU.

>
> Do you have any idea how to make the kernel to take control of L3 cache?
We don't have this code. Using address 0 to get back to spin address would
require you to disable cache prior to jump.


>
> --Arun
