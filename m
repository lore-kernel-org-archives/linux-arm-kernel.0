From: cinifr@gmail.com (cinifr)
Date: Sat, 28 Sep 2013 21:48:11 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 1/3] Add smp
 support for Allwinner A20(sunxi 7i).
In-Reply-To: <20130925184435.GH2954@lukather>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <20130923181707.GR2779@lukather>
 <CAK3cCBwLrnV7L9WzJ+1P_62PEjEEtgzVjFH8m6SZzWG1O+2vEw@mail.gmail.com>
 <20130925184435.GH2954@lukather>
Message-ID: <CAK3cCBwOpkk5ObeEm+by=RS6jSptPdGZM+fvpgGZpX9TPij5gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  Maxime,
    I have test it, but I found it does not work. If using
smp_prepare_cpus, the kernenl cannot find the secondary cpus because
that smp_prepare_cpus semms not be excuted before kernel is booting
secondary cpus. So I have to use early_initcall.

Fan.

On 26 September 2013 02:44, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Fan,
>
> On Wed, Sep 25, 2013 at 12:22:44AM +0800, cinifr wrote:
>> > You still haven't said why you don't want to use smp_init_cpus there.
>> I find that of_funcation liking of_find_matching_node and of_iomap can
>> not run well in smp_init_cpus. It cause kernel crash. So I have to use
>> early_initcall.
>
> Ah, right.
>
> Then, can't we use smp_prepare_cpus for this? it looks to be late enough
> so that we can use ioremap there.
>
> I don't want it to be an initcall. The code will be different on the
> A31, and we don't want it to be run on all the other machines whenever
> we boot a multiplatform kernel anyway.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
