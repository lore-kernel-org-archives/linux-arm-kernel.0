From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 14:05:38 -0000
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm
	cpu	hotplug
In-Reply-To: <20101130115148.GB31054@n2100.arm.linux.org.uk>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>	<20101129104149.GA10703@n2100.arm.linux.org.uk>	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>	<20101129192407.GA20761@n2100.arm.linux.org.uk>	<AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>	<20101130110331.GA31054@n2100.arm.linux.org.uk>
	<20101130115148.GB31054@n2100.arm.linux.org.uk>
Message-ID: <004701cb9097$ab173f40$0145bdc0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> On Tue, Nov 30, 2010 at 11:03:31AM +0000, Russell King - ARM Linux wrote:
> > I see no point to what is being proposed in this thread.  It's _soo_
> > little code that the platforms have to implement that it really is
> > not worth the effort.

[...]

> Note also that most implementations of this get it wrong.  Realview
> assumes ARMv6 MPcore layout of the auxcontrol register, which is
> cut'n'pasted into s5pv310 (ARMv7) and Tegra (ARMv7) without thinking.
> The only implementation which has put some thought into it is the
> UX500 one, which is extremely simple.
> 
> So, out of the four existing implementations, at least two need fixing
> to be different, and I'll bet that they do have some way to power down
> the offlined CPUs for greater power savings.

I have patches that fix this for RealView and Versatile Express, I posted
them to the list in the past (note that these are now out of date):

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-September/026160.html

I have a newer version here:

git://linux-arm.org/linux-2.6-wd.git cpu-hotplug

but it relies on the Versatile Express multi-tile patches that I'm posting at
the moment. If the hotplug APIs aren't about to change fundamentally, then
I'll repost these patches once the multi-tile stuff is accepted.

Will
