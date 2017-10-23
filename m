From: keescook@chromium.org (Kees Cook)
Date: Mon, 23 Oct 2017 12:40:58 -0700
Subject: [PATCH] KVM: arm/arm64: Allow usercopy to vcpu->arch.ctxt and
 arm64 debug
In-Reply-To: <d2a7dcec-060b-6279-1c1d-a18b3eedb394@redhat.com>
References: <20171020232525.7387-1-pbonzini@redhat.com>
 <20171021184545.2497-1-christoffer.dall@linaro.org>
 <CAGXu5jKJ2jPz2540ZLCwmcdVZxrgnhVPHs0uumiJm2o0ZgpVag@mail.gmail.com>
 <20171022074418.GA3805@cbox> <d2a7dcec-060b-6279-1c1d-a18b3eedb394@redhat.com>
Message-ID: <CAGXu5jKoLP8jN4ZtRQnFpy6RWK1JJTa7eBuA2p9huBfh11bWvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 7:14 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> I'll send a v2 myself later this week.

Okay, which patches would you like me to carry in the usercopy
whitelisting tree for the coming merge window?

-Kees

-- 
Kees Cook
Pixel Security
