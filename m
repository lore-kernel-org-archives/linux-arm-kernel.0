From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 23 May 2018 12:17:09 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <CACRpkdbCsUBMcHg+xGOQCBmhoJsqh9VjK+4pjhG5Hf6Fjzwjww@mail.gmail.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
 <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
 <CACRpkdbCsUBMcHg+xGOQCBmhoJsqh9VjK+4pjhG5Hf6Fjzwjww@mail.gmail.com>
Message-ID: <3165bba5-31d4-2dd4-bdb3-851889595e2e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> If you take a look at
>> arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> which is Ultra96 board gpio-line-names are filled there for the whole PS
>> part. Definitely take a look and let know if you find out any issue there.
> 
> It looks good. I even managed to boot my Ultra96 board which
> was sent over as price in some competition (great hardware!)

Wonderful that you get hw available to be closer to issues.
Maybe it would be worth to give you some guidance what to do with PL and
how to add more stuff there especially in connection to GPIO.
We have pinctrl driver in vendor tree but my colleague needs to upstream
firmware interface first.


>> zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
>> coming to logic.
>>
>> I can't describe PL gpio pins because it can be whatever even I have
>> done that for one fixed hw design.
>>
>> Interesting part on that sha1 you shared is how "NC" pin is described.
>>
>> gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
>> is really just a pad on real board. And the rest of "" gpio names are
>> connected to PL.
> 
> How to handle anything routed to/from programmable logic is
> in a bit of mess right now, I understand this work isn't the
> easiest :/

I am happy to discuss this to find out a way how this can be handled.
There are several things together.

On arm64 how to disable/enable access for NS software.

Maybe also separate pins PS pins from PL pins. Right now all are
together and not sure if this is ideal in sense of DT overal for
example. Separate nodes would enable better flexibility. Also if you
look at partial reconfiguration you can just route just part of pins
which suggest list of gpios used there.

Thanks,
Michal
