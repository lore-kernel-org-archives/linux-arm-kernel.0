From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 20:02:52 +0100
Subject: [PATCH 3/5] arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
In-Reply-To: <CAFEAcA-k3sUjF--+Q7kn3y7i5gkFQd3+WT1EWGEDyYv4=77z2Q@mail.gmail.com>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-4-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA8ysq5UD4WcfuJqSUV=E8zJR259=8v5S9q1o5aVJpPJQQ@mail.gmail.com>
 <20141202144728.GH545@cbox>
 <CAFEAcA-k3sUjF--+Q7kn3y7i5gkFQd3+WT1EWGEDyYv4=77z2Q@mail.gmail.com>
Message-ID: <20141202190252.GK545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 03:39:05PM +0000, Peter Maydell wrote:
> On 2 December 2014 at 14:47, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Thu, Nov 27, 2014 at 10:53:50PM +0000, Peter Maydell wrote:
> >> On 27 November 2014 at 18:40, Christoffer Dall
> >> <christoffer.dall@linaro.org> wrote:
> >> >  Possible features:
> >> >         - KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
> >> >           Depends on KVM_CAP_ARM_PSCI.  If not set, the CPU will be powered on
> >>
> >> Do you have to use the same set of feature flags for second and
> >> subsequent VCPU_INIT calls, or can they be different each time?
> >>
> > That's a good question.  Do you have any opinion on the matter?
> 
> QEMU always will, so I'd be happy if we said it has to be the same
> set of flags each time. I guess I'd go for "say they have to match";
> we can always relax later if we need to.
> 
> > It seems weird to change the target of a Vcpu from some core to another
> > core, but there is not reason why you shouldn't be able to set a vCpU to
> > be powered off when run, just because it wasn't earlier on, is
> > there?
> 
> We need an API for get/set of PSCI power state for migration
> anyhow, so it's not inherently required to be able to flip
> this bit on reset.
> 
Actually I think the current migration patches rely on being able to
call the init ioctl to turn off a vcpu, but I guess you could use the
KVM_SET_MP_STATE for that.

Alex, any thoughts?

-Christoffer
