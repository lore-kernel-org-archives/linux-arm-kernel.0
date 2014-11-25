From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 25 Nov 2014 17:13:04 +0000
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <5474B6BC.2060309@redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <5474B6BC.2060309@redhat.com>
Message-ID: <CAFEAcA-ikeiciAh4RXpKQQ_pY9FRePxR7nEBUEjcaaxB0ZAAtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2014 at 17:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
> So there is no register that says "this breakpoint has triggered" or
> "this watchpoint has triggered"?

Nope. You take a debug exception; the syndrome register tells
you if it was a bp or a wp, and if it was a wp the fault address
register tells you the address being accessed (if it was a bp
you know the program counter, obviously). The debugger is expected
to be able to figure it out from there, if it cares.

-- PMM
