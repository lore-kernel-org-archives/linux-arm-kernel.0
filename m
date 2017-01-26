From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 11:03:47 +0100
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <20170119174144.hiw7lmvdh2tzxtd7@lukather>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
 <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
 <20170116163124.c5gusyd3j3goivnf@lukather>
 <87a535d3-1170-c388-ce7d-4921e69f4cab@arm.com>
 <20170119174144.hiw7lmvdh2tzxtd7@lukather>
Message-ID: <CACRpkdbTaekF=VYP6-tjotTSYgVFtayM7A=eSu_=JGWEiZpczQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 6:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> That's not true anymore. And while it's true that it reduces the
> amount of maintainance on the kernel side and more on the DT side. And
> from what you're constantly saying, the thing we can't plan on fixing
> / upgrading is the DT, while the kernel is easy to change.
>
> Which means that if we ever want to fix a non-upgradable DT, the only
> way to do that would be to add quirks fixing it in the kernel
> itself. Adding more maintainance burden to the kernel.

This is a good argument to not put groups and functions into the
DT at all. If the following propositions hold:

- Functions and group definitions will contain bugs

- Those bugs will need to be fixed by changing the buggy
  definitions

- It is hard to change the DTB, it is easy to change the zImage

Then by logical deduction the definitions should be in the kernel
to minimize maintenance burden.

There is a pattern amongst firmware people that they think that
they always get the group and function definitions right on first
try. As long as there are humans involved in the process, this
stance is provedly wrong, just use git log and you will see how
much of such bugs we fix, even in drivers and DTSes produced
by the vendors themselves.

Yours,
Linus Walleij
