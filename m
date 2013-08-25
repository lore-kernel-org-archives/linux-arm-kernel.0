From: agraf@suse.de (Alexander Graf)
Date: Sun, 25 Aug 2013 16:27:14 +0100
Subject: [PATCH 2/3] KVM: ARM: Get rid of KVM_HPAGE_ defines
In-Reply-To: <CAFEAcA9jcSby0JTZnEBW5Gwfn0SN770E0nSW3CSiOev16=kp5g@mail.gmail.com>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
 <1376058613-26400-1-git-send-email-christoffer.dall@linaro.org>
 <20130825140529.GT8218@redhat.com>
 <CAFEAcA9-hcGHYAKTP4xty1pB-bs=EgATrxKQhCOQ3YZOOpM4wg@mail.gmail.com>
 <20130825144847.GV8218@redhat.com>
 <CAFEAcA9jcSby0JTZnEBW5Gwfn0SN770E0nSW3CSiOev16=kp5g@mail.gmail.com>
Message-ID: <2A584690-A736-4DFA-B455-ABBD15298618@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25.08.2013, at 16:18, Peter Maydell wrote:

> On 25 August 2013 15:48, Gleb Natapov <gleb@redhat.com> wrote:
>> On Sun, Aug 25, 2013 at 03:29:17PM +0100, Peter Maydell wrote:
>>> Smiley noted, but this is pretty unlikely since it's not possible
>>> to lie to the guest about which mode it's in, so you can't make
>>> a guest think it's in Hyp mode.
>>> 
>> I suspected this, but forgot most that I read about Hyp mode by now.
>> Need to refresh my memory ASAP. Is it impossible even with a lot of
>> emulation? Can guest detect that it is not in a Hyp mode without
>> trapping into hypervisor?
> 
> Yes. The current mode is in the the low bits of the CPSR, which
> is readable without causing a trap. This is just the most obvious
> roadblock; I bet there are more. If you really had to run Hyp mode
> code in a VM you probably have to do it by having it all emulated
> via TCG.

Or in an in-kernel instruction emulator that we have lying around anyways. For kvm-in-kvm that should be good enough, as we only need to execute a few instructions in HYP mode.


Alex
