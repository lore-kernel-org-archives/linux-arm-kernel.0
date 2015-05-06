From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 May 2015 14:13:49 +0200
Subject: Fwd: Re: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink
 DNS-327L
In-Reply-To: <4e7e91562aac6a260885bf2d12174060@mail.ncrmnt.org>
References: <b6534b962d2cf9d21cb72d43f19a6574@mail.ncrmnt.org>
 <552A6209.9040903@gmail.com>
 <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
 <20150412145857.GA14038@lunn.ch>
 <b172d775afa24cea69a9490f531c6b37@mail.ncrmnt.org>
 <20150412194735.GA27921@lunn.ch> <552BCFAA.2020109@free-electrons.com>
 <1ec8906f00468ca5a9fa227f8c83fe69@mail.ncrmnt.org>
 <55351569.7000307@free-electrons.com>
 <d28764ea5d0d5f4c2e5d3e9ca1d7217a@mail.ncrmnt.org>
 <55351898.60604@free-electrons.com>
 <4e7e91562aac6a260885bf2d12174060@mail.ncrmnt.org>
Message-ID: <554A057D.3050007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,


> 
> Sorry for the long delay with testing, but here come the results.
> I've rebased everything to 4.1-rc1
> 
> 1. WFI + DeepIdle => freeze after approx:
>    * 1 hours and 30 minutes, first test
>    * 3 hours and 40 minutes, second test
> 2. WFI only (DeepIdle disabled via sysfs) => Still alive after 13 hours 
> and counting

Thanks for testing it. So, to sum-up, WFI+DeepIdle makes the board freeze
after a few hours in 4.1-rc1 and 4.0 for sure. Are you aware of any version
that did not freeze? It would help to know if it was a regression or not.

Andrew Lunn did not report any issue on his 370RD however I will test
it also on an other Armada 370 base board (a Mirabox) using the .config
you already sent.

But what I expect is either a hardware issue, or a hardware configuration
issue in U-Boot. We still rely a lot on the bootloader and I fear that
we have some implicit assumptions.

By the way do you have access on the bootloader sources or at least could
you give us the U-boot version used?

Thanks,

Gregory



> 
> The proper patchset will follow as soon as I figure out what change 
> broke
> dns320l-daemon (The utility that speaks to weltrend mcu on ttyS1)
> It was working on 3.18.6, on 3.19 and up - it writes data to the port 
> (and mcu acks it),
> but can't read any responses.
> 
> Same thing happens to the python (pyserial inside) implementation of the 
> fan-daemon:
> https://github.com/martignlo/DNS-320L
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
