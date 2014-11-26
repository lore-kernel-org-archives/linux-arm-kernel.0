From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 26 Nov 2014 13:13:25 +0000
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <5474BAD8.7010307@redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <5474B6BC.2060309@redhat.com>
 <CAFEAcA-ikeiciAh4RXpKQQ_pY9FRePxR7nEBUEjcaaxB0ZAAtA@mail.gmail.com>
 <5474BAD8.7010307@redhat.com>
Message-ID: <87vbm2ksui.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/11/2014 18:13, Peter Maydell wrote:
>> On 25 November 2014 at 17:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> > So there is no register that says "this breakpoint has triggered" or
>>> > "this watchpoint has triggered"?
>> Nope. You take a debug exception; the syndrome register tells
>> you if it was a bp or a wp, and if it was a wp the fault address
>> register tells you the address being accessed (if it was a bp
>> you know the program counter, obviously). The debugger is expected
>> to be able to figure it out from there, if it cares.
>
> That's already good enough---do the KVM_DEBUG_EXIT_* constants match the
> syndrome register, or if not why?

No they don't. I did consider it at the time but I was wary of pulling
too much over into the uapi headers wholesale. If your happy to do that
I'll include the change in my next version.

I could also rationalise the exit handlers as they all pretty much do
the same thing (save for the exit/syndrome related info). Again I was
keeping things nicely separated in case any particular exception needed
excessive special case handling.

Would you like those changes?

>
> Paolo

-- 
Alex Benn?e
