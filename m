From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Aug 2018 23:58:44 +0100
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <20180816203515.GA7688@torres.zugschlus.de>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <20180816203515.GA7688@torres.zugschlus.de>
Message-ID: <20180816225844.GW30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 10:35:16PM +0200, Marc Haber wrote:
> On Mon, Jun 25, 2018 at 05:41:27PM +0100, Peter Robinson wrote:
> > So with that and the other fix there was no improvement, with those
> > and the BPF JIT disabled it works, I'm not sure if the two patches
> > have any effect with the JIT disabled though.
> 
> I can confirm the crash with the released 4.18.1 on Banana Pi, and I can
> also confirm that disabling BPF JIT makes the Banana Pi work again.,

Hi,

I'm afraid that the information in the crash dumps is insufficient
to be able to work very much out about these crashes.

We need a recipe (kernel configuration and what userspace is doing)
so that it's possible to recreate the crash, or we need responses
to requests for information - I requested the disassembly of
sk_filter_trim_cap and the BPF code dump via setting a sysctl back
in early July.  Without this, as I say, I don't see how this problem
can be progressed.

If the problem is at boot, one way to set the sysctl would be to
hack the kernel and explicitly initialise the sysctl to '2', or
boot with init=/bin/sh, then manually mount /proc, set the sysctl,
and then "exec /sbin/init" from that shell.  (Remember there's no
job control in that shell, so ^z, ^c, etc do not work.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
