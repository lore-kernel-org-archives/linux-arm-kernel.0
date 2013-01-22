From: jussi.kivilinna@mbnet.fi (Jussi Kivilinna)
Date: Tue, 22 Jan 2013 09:46:14 +0200
Subject: [PATCH] crypto: fix FTBFS with ARM SHA1-asm and THUMB2_KERNEL
In-Reply-To: <CAKGA1bkQ9e8gmSPz_4csJWjEOKj3ZVqSLijSTRWxgDSaZoYqCA@mail.gmail.com>
References: <1358787763-1226-1-git-send-email-matt@genesi-usa.com>
 <alpine.LFD.2.02.1301211739470.6300@xanadu.home>
 <CAKGA1bkQ9e8gmSPz_4csJWjEOKj3ZVqSLijSTRWxgDSaZoYqCA@mail.gmail.com>
Message-ID: <20130122094614.79031aq5ddrgr2zo@www.dalek.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Matt Sealey <matt@genesi-usa.com>:

> This question is to the implementor/committer (Dave McCullough), how
> exactly did you measure the benchmark and can we reproduce it on some
> other ARM box?
>
> If it's long and laborious and not so important to test the IPsec
> tunnel use-case, what would be the simplest possible benchmark to see
> if the C vs. assembly version is faster for a particular ARM device? I
> can get hold of pretty much any Cortex-A8 or Cortex-A9 that matters, I
> have access to a Chromebook for A15, and maybe an i.MX27 or i.MX35 and
> a couple Marvell boards (ARMv6) if I set my mind to it... that much
> testing implies we find a pretty concise benchmark though with a
> fairly common kernel version we can spread around (i.MX, OMAP and the
> Chromebook, I can handle, the rest I'm a little wary of bothering to
> spend too much time on). I think that could cover a good swath of
> not-ARMv5 use cases from lower speeds to quad core monsters.. but I
> might stick to i.MX to start with..

There is 'tcrypt' module in crypto/ for quick benchmarking. 'modprobe  
tcrypt mode=500 sec=1' tests AES in various cipher-modes, using  
different buffer sizes and outputs results to kernel log.

-Jussi
