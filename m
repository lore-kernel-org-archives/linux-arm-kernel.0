From: geoff@infradead.org (Geoff Levand)
Date: Wed, 23 Jul 2014 17:10:07 -0700
Subject: Kexec on arm64
In-Reply-To: <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
Message-ID: <1406160607.4062.27.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Tue, 2014-07-22 at 15:14 +0530, Arun Chandran wrote:
> # kexec -e

Please use 'kexec -d -e' here to get debug output.

> kexec version: 1kvm: exiting hardware virtualization
> 4.07.17.12.17-gbStarting new kernel
> 6cccb4
>  Ump_spin_tanblaeb_lcpeu_d ite:127: oi dh:a n7d,l holding count: 0e
>  kernel NULL pointer dereference at virtual address 00000291
> smp_spin_Itnaibtlei_cpaul_diie:12z7:i nigd :c 3g,r oholding couunpt :s 0u

It is hard to read this, please send the various outputs to different
streams.

> I think some of the secondary CPUs are not behaving as expected;
> As of now I don't have any clues for this.

I guess the cpu-return-addr is not correct.  Try setting cpu-return-addr
to <0x0 0x1>.  This will spin secondaries in secondary_holding_pen.

-Geoff
