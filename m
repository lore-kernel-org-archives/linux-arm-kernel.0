From: pbrobinson@gmail.com (Peter Robinson)
Date: Fri, 17 Aug 2018 13:25:44 +0100
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <20180816225844.GW30658@n2100.armlinux.org.uk>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <20180816203515.GA7688@torres.zugschlus.de>
 <20180816225844.GW30658@n2100.armlinux.org.uk>
Message-ID: <CALeDE9Pm7nsqDFL0m0ZsNdnEti6YAbEPhtfbNMPe=UZCUyyHMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 11:58 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Aug 16, 2018 at 10:35:16PM +0200, Marc Haber wrote:
>> On Mon, Jun 25, 2018 at 05:41:27PM +0100, Peter Robinson wrote:
>> > So with that and the other fix there was no improvement, with those
>> > and the BPF JIT disabled it works, I'm not sure if the two patches
>> > have any effect with the JIT disabled though.
>>
>> I can confirm the crash with the released 4.18.1 on Banana Pi, and I can
>> also confirm that disabling BPF JIT makes the Banana Pi work again.,
>
> Hi,
>
> I'm afraid that the information in the crash dumps is insufficient
> to be able to work very much out about these crashes.
>
> We need a recipe (kernel configuration and what userspace is doing)
> so that it's possible to recreate the crash, or we need responses
> to requests for information - I requested the disassembly of
> sk_filter_trim_cap and the BPF code dump via setting a sysctl back
> in early July.  Without this, as I say, I don't see how this problem
> can be progressed.

I can provide a kernel config [1] but I've not had enough time to sit
down and get the rest of the stuff and debug it due to a combination
of travel and other priorities.

> If the problem is at boot, one way to set the sysctl would be to
> hack the kernel and explicitly initialise the sysctl to '2', or
> boot with init=/bin/sh, then manually mount /proc, set the sysctl,
> and then "exec /sbin/init" from that shell.  (Remember there's no
> job control in that shell, so ^z, ^c, etc do not work.)

It starts to happen in the early kernel boot long before we get to any
userspace across a number of ARMv7 devices (RPi2/3, BeagleBone and
AllWinner H3 based devices at least).

[1] https://pbrobinson.fedorapeople.org/kernel-armv7hl.config
