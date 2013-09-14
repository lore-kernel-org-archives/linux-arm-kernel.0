From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Sat, 14 Sep 2013 14:05:57 +0200
Subject: [PATCH 3/4] Add physical count arch timer support for
 clocksource in ARMv7.
In-Reply-To: <5232DB49.4050701@arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
 <5231EE43.5090900@arm.com>
 <CAK3cCBzr8_LTYarZDgPYZY7_-5Qco_Qw+ACi=c2uOrn7MqwkBg@mail.gmail.com>
 <5232DB49.4050701@arm.com>
Message-ID: <20130914120557.GB2746@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Fan,

On Fri, Sep 13, 2013 at 10:30:49AM +0100, Marc Zyngier wrote:
> On 13/09/13 09:49, cinifr wrote:
> > On 13 September 2013 00:39, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > I am   wondering   what is the principle between kernel and bootload?
> > What should be done in bootloader and what should be done in kernel?
> > As you said, If kernel boot from hyp,  Kernel can set  CNTVOFF to zero
> > directly, does we add the code to set CNTVOFF in kernel?  But, if
> > kernel boot from PL1 NS=0,  Does kernel  need to switch hyp mode to
> > set  CNTVOFF and return  PL1 NS=0 mode? Or,kernel dont care it because
> > kernel   believe bootloader have set CNTVOFF  before?
> 
> In an ideal world, the bootloader should set CNTVOFF to zero. The fact
> that the kernel does it too when booted in HYP mode is to preserve
> itself from from broken bootloaders.
> 
> CNTVOFF can only be setup from either HYP or Secure Monitor mode with
> SCR.NS == 1, so if you run your kernel in secure mode, it is always best
> to do it in the bootloader.

What would happen exactly if a kernel expects CNTVOFF to be set to 0,
and that your bootloader don't set it?

>From what you're saying, it's will be set by the kernel if it's booted
in hypervisor mode, but what if it's not?

The ARM documentation says that the CNTVOFF register will hold an
undefined value, how would that affect the kernel?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130914/6c9e137f/attachment.sig>
