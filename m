From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 17 Mar 2014 15:39:39 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <20140317204410.GA1118@arch.cereza>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140316070917.GA3094@arch.cereza>
 <CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>
 <20140317204410.GA1118@arch.cereza>
Message-ID: <CADHgK6tHngKVZS=jo=VYt3Nt3dhiEmiWr28iDy7q_uR9goBj=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2014 13:44, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Mar 17, Sebastian Capella wrote:
>> On 16 March 2014 00:09, Ezequiel Garcia
>> <ezequiel.garcia@free-electrons.com> wrote:
>> > On Mar 05, Sebastian Capella wrote:
>> > [..]
>> >> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> >> index 1f8fed9..83707702 100644
>> >> --- a/arch/arm/mm/Kconfig
>> >> +++ b/arch/arm/mm/Kconfig
>> >> @@ -611,6 +611,11 @@ config CPU_USE_DOMAINS
>> >>  config IO_36
>> >>       bool
>> >>
>> >> +config ARCH_HIBERNATION_POSSIBLE
...
>> > Is there any reason why CPU_FEROCEON is not listed here? FWIW, I've just built
>> > (but not really tested) a Kirkwood kernel with CONFIG_HIBERNATION=y.
...
> Sure, no problem. If you consider that build-test is enough, feel free to put
> CPU_FEROCEON on that list. We added suspend/resume to feroceon not long ago.
>> > And is there any reason to put this config in arch/arm/mm/Kconfig, instead of
>> > in arch/arm/Kconfig, below ARCH_SUSPEND_POSSIBLE?
...
> I guess my question wasn't clear. I mean to ask: Are there any other
> requirements on an ARM platform to support hibernation, other than
> suspend/resume support?
>
> If this is the *only* requirement, it seems to me we could make our
> ARCH_SUSPEND_POSSIBLE also select ARCH_HIBERNATION_POSSIBLE.

Thanks, I've added it like this in arch/arm/Kconfig.  I'm sure you
know, but this way also takes care of the CPU_FEROCEON in the default
list since SUSPEND_POSSIBLE already contains it.

config ARCH_HIBERNATION_POSSIBLE
        bool
        depends on MMU
        default y if ARCH_SUSPEND_POSSIBLE

Does this look ok?

Thanks!

Sebastian
