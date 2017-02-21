From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Feb 2017 17:21:33 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
References: <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221112720.ynehsryprhrhzjla@piout.net>
 <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
Message-ID: <20170221162133.jch6yzpotj4s7zob@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/2017 at 18:09:09 +0200, Andy Shevchenko wrote:
> On Tue, Feb 21, 2017 at 1:27 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > (adding Hans-Christian)
> >
> > On 21/02/2017 at 13:02:21 +0200, Andy Shevchenko wrote:
> >> Abusing platform data with pointers is also not welcome.
> >>
> >> > (in this case, avr32).
> >>
> >> It's dead de facto.
> >>
> >> When last time did you compile kernel for it? What was the version of kernel?
> >> Did it get successfully?
> >>
> >
> > v4.10-rc3 was building successfully but had some issues in the network
> > code.
> 
> Newer kernel doesn't link...
> 
> >> When are we going to remove avr32 support from kernel completely?
> 
> > Ask that to the avr32 maintainers. It still builds and is still booted
> > by some people. And that actually seems to be you as you reported a bug
> > we introduced in 4.3. I don't think we had any other report after that.
> 
> https://patchwork.kernel.org/patch/9505727/
> 
> After that I gave up on it. Next time I will escalate directly to
> Linus. It's a complete necrophilia. I spent already enough time to
> look at that code. It brings now more burden than supports someone
> somewhere.
> 

As said, it builds fine without networking. Maybe the first step is to
ask the avr32 maintainers. If you already did so, please feel free to
send a patch to remove the whole architecture.
The benefits for atmel will be: proper big endian support, removal of
platform data from all the drivers, better clocksource handling.

> > It can be frustrating at times to handle that platform but if it is
> > working for someone, I don't see why we would remove it.
> 
> How it's working if it's not linked?
> 

Come on, v4.10 has just been release and v4.9 was building just fine. Do
you really expect everybody to closely follow linux-next or update
overnight?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
