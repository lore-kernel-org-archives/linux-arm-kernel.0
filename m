From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 23 Feb 2015 08:00:06 +0100
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <CAL_JsqLENvqsG+vjK740Aw4yKYONwHB1b-B7mKvE_iAZ1JSdNw@mail.gmail.com>
References: <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
 <54E742F2.80506@hurleysoftware.com>
 <20150220143533.GA29908@odux.rfo.atmel.com>
 <CAL_JsqLENvqsG+vjK740Aw4yKYONwHB1b-B7mKvE_iAZ1JSdNw@mail.gmail.com>
Message-ID: <20150223070006.GD29908@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Feb 20, 2015 at 11:30:12AM -0600, Rob Herring wrote:
> On Fri, Feb 20, 2015 at 8:35 AM, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > On Fri, Feb 20, 2015 at 09:21:38AM -0500, Peter Hurley wrote:
> >> On 02/19/2015 12:38 PM, Pantelis Antoniou wrote:
> >> >
> >> >> On Feb 19, 2015, at 19:30 , Frank Rowand <frowand.list@gmail.com> wrote:
> >> >>
> >> >> On 2/19/2015 9:00 AM, Pantelis Antoniou wrote:
> >> >>> Hi Frank,
> 
> [...]
> 
> >> >>> This is one of those things that the kernel community doesn?t understand which makes people
> >> >>> who push product quite mad.
> >> >>>
> >> >>> Engineering a product is not only about meeting customer spec, in order to turn a profit
> >> >>> the whole endeavor must be engineered as well for manufacturability.
> >> >>>
> >> >>> Yes, you can always manually install files in the bootloader. For 1 board no problem.
> >> >>> For 10 doable. For 100 I guess you can hire an extra guy. For 1 million? Guess what,
> >> >>> instead of turning a profit you?re losing money if you only have a few cents of profit
> >> >>> per unit.
> >> >>
> >> >> I'm not installing physical components manually.  Why would I be installing software
> >> >> manually?  (rhetorical question)
> >> >>
> >> >
> >> > Because on high volume product runs the flash comes preprogrammed and is soldered as is.
> >> >
> >> > Having a single binary to flash to every revision of the board makes logistics considerably
> >> > easier.
> >> >
> >> > Having to boot and tweak the bootloader settings to select the correct dtb (even if it?s present
> >> > on the flash medium) takes time and is error-prone.
> >> >
> >> > Factory time == money, errors == money.
> >> >
> >> >>>
> >> >>> No knobs to tweak means no knobs to break. And a broken knob can have pretty bad consequences
> >> >>> for a few million units.
> >> >>
> >> >> And you produce a few million units before testing that the first one off the line works?
> >> >>
> >> >
> >> > The first one off the line works. The rest will get some burn in and functional testing if you?re
> >> > lucky. In many cases where the product is very cheap it might make financial sense to just ship
> >> > as is and deal with recalls, if you?re reasonably happy after a little bit of statistical sampling.
> >> >
> >> > Hardware is hard :)
> >>
> >> I'm failing to see how this series improves your manufacturing process at all.
> >>
> >> 1. Won't you have to provide the factory with different eeprom images for the
> >>    White and Black?  You _trust_ them to get that right, or more likely, you
> >>    have process control procedures in place so that you don't get 1 million Blacks
> >>    flashed with the White eeprom image.
> >>
> >> 2. The White and Black use different memory technology so it's not as if the
> >>    eMMC from the Black will end up on the White SMT line (or vice versa).
> >>
> >> 3  For that matter, why wouldn't you worry that all the microSD cards intended
> >>    for the White were accidentally assembled with the first 50,000 Blacks; at
> >>    that point you're losing a lot more than a few cents of profit. And that has
> >>    nothing to do with what image you provided.
> >>
> >
> > As you said, we can imagine many reasons to have a failure during the
> > production, having several DTB files will increase the risk.
> 
> Then package them as a single file. You can even use DT to do that.
> See u-boot FIT image.
> 
> Rob

It is acualyy what we did but we are not happy with this solution
because as said previously we rely on U-Boot and on dts/dtsi side we
have too many files.

Regards

Ludovic
