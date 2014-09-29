From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Sep 2014 15:25:43 +0200
Subject: [PATCH] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <54295711.9010901@gmail.com>
References: <54280AA7.1090401@gmail.com> <20140928164337.GB15315@lukather>
 <54295711.9010901@gmail.com>
Message-ID: <20140929132543.GC4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 01:56:49PM +0100, Iain Paton wrote:
> On 28/09/14 17:43, Maxime Ripard wrote:
> > On Sun, Sep 28, 2014 at 02:18:31PM +0100, Iain Paton wrote:
> 
> >> +
> >> +		i2c0: i2c at 01c2ac00 {
> >> +			pinctrl-names = "default";
> >> +			pinctrl-0 = <&i2c0_pins_a>;
> >> +			status = "okay";
> >> +
> >> +			axp209: pmic at 34 {
> >> +				compatible = "x-powers,axp209";
> >> +				reg = <0x34>;
> >> +				interrupt-parent = <&nmi_intc>;
> >> +				interrupts = <0 8>;
> >> +
> >> +				interrupt-controller;
> >> +				#interrupt-cells = <1>;
> > 
> > It would be greate if you could add the regulators used on the board
> > here.
> > 
> > You might want to hold off a bit until the merge window is out, since
> > some patches useful for this are still pending, or based your patch on
> > top of linux-next
> 
> I'll take a bash at it, although as there seems to be no binding doc 
> for the driver and I can't find any other board that has axp209 
> regulators defined I may need a bit of help to get this right.

Hmmm, that's odd. I was 100% sure it had one, but now that you mention
it, I can't find it either.

I should find where that patch went, and merge it then...

> What additional patches are we talking about?  The following:
> regulator: axp20x: Use parent device as regulator configuration device
> i2c: mv64xxx: continue probe when clock-frequency is missing
> or are there others I'd need to pick out of linux-next?

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288901.html

> linux-next 20140926 doesn't build for me:
> 
>    LD      init/built-in.o
> kernel/built-in.o: In function `cputime_adjust':
> :(.text+0x25588): undefined reference to `__bad_cmpxchg'
> :(.text+0x255f8): undefined reference to `__bad_cmpxchg'
> /data/linux/source/linux-next-org/Makefile:956: recipe for target 'vmlinux' failed
> 
> I suppose as a result of https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/kernel/sched/cputime.c?id=eb1b4af0a64ac7bb0ee36f579c1c7cefcbc3ac2c
> 
> having reverted that one, the resulting kernel doesn't want to talk 
> to my SD card.  Both your tree and 3.16 work fine though.

Leave it out then. If you have no way to test it, it's going to be
very bug prone, and we can always add it later.

The SD card issue is more troublesome. We'll have to look into it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/1498a8f5/attachment.sig>
