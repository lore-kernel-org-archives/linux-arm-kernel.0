From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 11:04:41 +0100
Subject: [PATCH v10 04/18] KVM: arm/arm64: Introduce
 kvm_arch_vcpu_run_pid_change
In-Reply-To: <87d0xltnrk.fsf@linaro.org>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-5-git-send-email-Dave.Martin@arm.com>
 <87muwqtp8z.fsf@linaro.org>
 <20180523144026.GM13470@e103592.cambridge.arm.com>
 <20180524081110.GI55598@C02W217FHV2R.local>
 <87d0xltnrk.fsf@linaro.org>
Message-ID: <20180524100441.GS13470@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 10:18:39AM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@arm.com> writes:
> 
> > On Wed, May 23, 2018 at 03:40:26PM +0100, Dave Martin wrote:
> >> On Wed, May 23, 2018 at 03:34:20PM +0100, Alex Benn?e wrote:
> >> >
> >> > Dave Martin <Dave.Martin@arm.com> writes:

[...]

> >> > > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> >> > > index cca7e06..72143cf 100644
> >> > > --- a/virt/kvm/Kconfig
> >> > > +++ b/virt/kvm/Kconfig
> >> > > @@ -54,3 +54,6 @@ config HAVE_KVM_IRQ_BYPASS
> >> > >
> >> > >  config HAVE_KVM_VCPU_ASYNC_IOCTL
> >> > >         bool
> >> > > +
> >> > > +config HAVE_KVM_VCPU_RUN_PID_CHANGE
> >> > > +       bool
> >> >
> >> > This almost threw me as I thought you might be able to enable this and
> >> > break the build, but apparently not:
> >> >
> >> > Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> >>
> >> Without a "help", the option seems non-interactive and cannot be true
> >> unless something selects it.  It seems a bit weird to me too, but the
> >> idiom appears widely used...
> >>
> > Indeed, I've copied this idiom from other things before and nobody has
> > complained, so I think it works (without any further deep insights into
> > the inner workings of Kconfig).
> 
> It's fine. My main worry was breaking bisection with the normal "make
> olddefconfig" approach. I tested it and found it to be fine and I don't
> think we need to worry about people adding the symbol to .config
> manually - they get to keep both pieces ;-)

I wasted a fair amount of time at some point in the past trying to work
out why I couldn't set one of these options by
echo CONFIG_FOO=y >>.config ...

That was fun ;)

Cheers
---Dave
