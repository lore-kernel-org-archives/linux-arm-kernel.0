From: geoff@infradead.org (Geoff Levand)
Date: Wed, 23 Jul 2014 17:38:07 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
Message-ID: <1406162287.4062.39.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, 2014-07-22 at 18:55 +0530, Arun Chandran wrote:

> I tried the same dtb with UP configuration. For UP kernel to compile
> did the below modifications

I'll test and fixup the kexec UP build in the next few days.

...

> With the default target configuration "kexec -e" failed to execute
> in UP scenario also.
> 
> But I had some luck when I did the same steps with L3 cache
> disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
> it has an L3 cache. Luckily I was able to disable it in u-boot.
> 
> With the L3 cache disabled configuration I am able to
> do "kexec -e". Please see the log attached.

All memory management for the main cpu is done by the arch code.  Kexec
and cpu hot plug only work with the secondary cpus, so the problem would
be in the arch memory code, either in setup_restart() for shutdown, or
in the startup code.

I guess setup_restart() is not doing something it needs to do for your
platform.

-Geoff
