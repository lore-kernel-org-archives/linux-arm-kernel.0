From: geoff@infradead.org (Geoff Levand)
Date: Fri, 25 Jul 2014 17:18:21 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke> <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
Message-ID: <1406333901.4062.69.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Fri, 2014-07-25 at 17:18 +0530, Arun Chandran wrote:
> I got this working. As 'Mark Rutland' pointed in another mail that
> it could be problem with flushing the cache; I did a read of
> 1GB data from start of RAM to a volatile var. I assume that
> this will clear and invalidate all that in cache (L1=32K, L2=256 K, L3=8M)

I wasn't flushing out all the data used by relocate_new_kernel.  I added
a routine that should flush all the pages in the kimage list out to PoC.
Please try a UP build with L3 enabled.

Next week I'll check that my smp secondary shutdown code is doing the
correct thing.

-Geoff
