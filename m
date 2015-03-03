From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 03 Mar 2015 12:06:40 +0100
Subject: [PATCH 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <8761ai73j1.fsf@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA9oWeYGYcGtf8So6VrYLMXjWr4FiZ2tS+jBnDtv87jAKw@mail.gmail.com>
 <8761ai73j1.fsf@linaro.org>
Message-ID: <54F595C0.5060004@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/03/2015 11:56, Alex Benn?e wrote:
> > > This adds the saving and restore of the current Multi-Processing state
> > > of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
> > > potential states for x86 we only use two for ARM. Either the process is
> > > running or not.
> >
> > By this you mean "is the CPU in the PSCI powered down state or not",
> > right?
> 
> From the vcpu's perspective it is either running or not. However it is
> the same mechanism that is used when PSCI_0_2_FN_CPU_OFF is passed the
> VM, internally setting vcpu->arch.paused.

I suggest that you define a new MP_STATE constant for this.  HALTED in
x86 and s390 is the state an ARM processor enters when you execute wfi.
 Right now this is not migrated on ARM if I remember correctly, but
perhaps you'll want to add it in the future.

Paolo
