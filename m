From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 23 Oct 2015 08:10:30 -0700
Subject: [PATCH v2 4/5] drivers: firmware: psci: add extended stateid
 power_state support
In-Reply-To: <20151023113618.GA29008@red-moon>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <3982126.UybqODJKJo@wuerfel> <20151023104457.GA9309@red-moon>
 <7012327.dvizHt4W5S@wuerfel> <20151023113618.GA29008@red-moon>
Message-ID: <CAMAWPa-_H3ea65ZpkCjYHGXt5k76Li5b01eAhpRjVVJoYUXp_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 4:36 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Oct 23, 2015 at 12:55:34PM +0200, Arnd Bergmann wrote:
>> On Friday 23 October 2015 11:44:58 Lorenzo Pieralisi wrote:
>> >
>> > Problem with Qemu emulation is that it does not emulate the PSCI 1.0
>> > specs correctly (it does not even consider PSCI 1.0 functions proper PSCI
>> > calls), I tested it and I think we should update Qemu as we
>> > did with KVM kernel code instead of working around it by dodging the
>> > problem in the PSCI implementation by adding code that checks the
>> > PSCI version before issuing the PSCI calls through the respective
>> > conduit.
>> >
>> > Thoughts appreciated.
>>
>> I think we really cannot break existing qemu installations, but need
>> a way to detect whether we are dealing with a broken qemu (and warn
>> about that) or with a working PSCI implementation.
>>
>> Fixing qemu is of course a good idea, but it's not sufficient.
>
> I will patch the PSCI back-end in the kernel to issue PSCI_FEATURES calls
> only if the PSCI version detected is 1.0, therefore solving the issue, it
> is not necessary according to the specs, but that's belt and braces
> and sorts this niggle out.
>
> I will send a patch shortly to be applied on top of arm-soc drivers/psci.

Thanks!

In parallel, since you understandn better what qemu is/isn't doing,
can you ping the qemu folks about this bug?

Thanks,

Kevin
