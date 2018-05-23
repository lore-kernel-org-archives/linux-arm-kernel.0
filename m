From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 May 2018 11:42:14 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
 <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
Message-ID: <CACRpkdbCsUBMcHg+xGOQCBmhoJsqh9VjK+4pjhG5Hf6Fjzwjww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 4:19 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 2.5.2018 15:56, Linus Walleij wrote:

>> Would it be possible that I apply the patch, and somehow also
>> establish some understanding with all users of the Xilinx
>> platform that whatever legacy applications are out there
>> must start to migrate towards using the character device so
>> this reliance on the numberspace doesn't stick around forever?
>
> When someone contacts me for asking guidance for gpio I am telling them
> not to use legacy sysfs interface and use libgpiod.

Awesome, thanks for your support :)

> Last one was a week
> ago in connection to Ultra96 and libmraa.
>
> But even chardev is not supported there now.
> https://github.com/intel-iot-devkit/mraa/issues/713

Hm I hope this happens soon. Manavanninan is doing a great
job in switching this over, I just have to accept that the pace
isn't always what it should be in all upstream projects, and
deal with an imperfect world.

> If you take a look at
> arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> which is Ultra96 board gpio-line-names are filled there for the whole PS
> part. Definitely take a look and let know if you find out any issue there.

It looks good. I even managed to boot my Ultra96 board which
was sent over as price in some competition (great hardware!)

> zynq/zynqmp gpio controller contains PS pins (hard part) and PL pins
> coming to logic.
>
> I can't describe PL gpio pins because it can be whatever even I have
> done that for one fixed hw design.
>
> Interesting part on that sha1 you shared is how "NC" pin is described.
>
> gpio pin 35 I have on zcu100 as "" but it should be maybe TP_PAD which
> is really just a pad on real board. And the rest of "" gpio names are
> connected to PL.

How to handle anything routed to/from programmable logic is
in a bit of mess right now, I understand this work isn't the
easiest :/

Let's go for this patch and try to improve the situation gradually
moving forward.

Yours,
Linus Walleij
