From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 23 Oct 2017 16:49:07 +0200
Subject: [PATCH] KVM: arm/arm64: Allow usercopy to vcpu->arch.ctxt and
 arm64 debug
In-Reply-To: <d2a7dcec-060b-6279-1c1d-a18b3eedb394@redhat.com>
References: <20171020232525.7387-1-pbonzini@redhat.com>
 <20171021184545.2497-1-christoffer.dall@linaro.org>
 <CAGXu5jKJ2jPz2540ZLCwmcdVZxrgnhVPHs0uumiJm2o0ZgpVag@mail.gmail.com>
 <20171022074418.GA3805@cbox> <d2a7dcec-060b-6279-1c1d-a18b3eedb394@redhat.com>
Message-ID: <CAMJs5B-VhREFk4qH+5we7JFtkx6CsKF+xN8mFg+2zSyc-DARYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 4:14 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 22/10/2017 09:44, Christoffer Dall wrote:
>> However, I think it's much clearer if I
>> rewrite these to use get_user() and put_user().  v2 incoming.
>
> I'd actually prefer if you all do a trivial conversion to
> kvm_init_usercopy to begin with.  In fact, we could just change the
> default from "0, 0" to "0, sizeof (kvm_arch_vcpu)" in kvm_init.  Any
> other change can be applied after the patches are merged to Linus's
> tree, especially with KVM Forum and the merge window both coming soon.
>
In that case, expect no further action from me on this one until the
patches have landed and I can resend my patch, unless you specifically
tell me otherwise.

Thanks,
-Christoffer
