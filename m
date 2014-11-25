From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 25 Nov 2014 18:22:32 +0100
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <CAFEAcA-ikeiciAh4RXpKQQ_pY9FRePxR7nEBUEjcaaxB0ZAAtA@mail.gmail.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <5474B6BC.2060309@redhat.com>
 <CAFEAcA-ikeiciAh4RXpKQQ_pY9FRePxR7nEBUEjcaaxB0ZAAtA@mail.gmail.com>
Message-ID: <5474BAD8.7010307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/11/2014 18:13, Peter Maydell wrote:
> On 25 November 2014 at 17:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > So there is no register that says "this breakpoint has triggered" or
>> > "this watchpoint has triggered"?
> Nope. You take a debug exception; the syndrome register tells
> you if it was a bp or a wp, and if it was a wp the fault address
> register tells you the address being accessed (if it was a bp
> you know the program counter, obviously). The debugger is expected
> to be able to figure it out from there, if it cares.

That's already good enough---do the KVM_DEBUG_EXIT_* constants match the
syndrome register, or if not why?

Paolo
