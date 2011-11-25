From: conqrx@gmail.com (=?ISO-8859-1?B?TW9sbuFyIEfhYm9y?=)
Date: Fri, 25 Nov 2011 12:34:20 +0100
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
In-Reply-To: <201111231751.49580.arnd@arndb.de>
References: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
 <201111231751.49580.arnd@arndb.de>
Message-ID: <CAK-0apapjShBdamRPK+-dmyqUT5VL197gzRBS0vjX73LoyA8Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I hope I'm not discouraging you too much

Absolutely not, in fact, thank you for the really useful insight and
suggestions, much appreciated.


2011/11/23 Arnd Bergmann <arnd@arndb.de>:
> On Friday 18 November 2011, Moln?r G?bor wrote:
>> im working on a project wich aims at porting the 2.6.38 kernel to an
>> arm11 mpcore based board.
>>
>> ...
>>
>> Im only a beginner, and im sorry for the low quality of the question,
>> i appreciate any help. Even comments on how 'accomplishable' this
>> project is. Also, the board is not a realview board, but it might not
>> be an issue at this stage.
>
> Hi Moln?r,
>
> I hope I'm not discouraging you too much, but from a high-level perspective
> this sounds like a rather pointless goal, mostly because 2.6.38 is
> rather old now and doing a port for that version would end up looking
> very different from how we are doing things for new kernel releases.
>
> Now if you were thinking about doing a port for mainline Linux (currently
> that means targetting developing on 3.2-rc and targetting 3.3 or 3.4),
> things would look much brighter.
>
> The most important question is what hardware "platform" this port is for,
> not so much the CPU core. The only two platform we support in Linux with
> an ARM11 MPCore are cns3xxx and realview. You already mentioned that you
> don't target realview. If your board is instead based on a Cavium Networks
> SOC, things should be fairly easy and you only need to add a new machine
> description in arch/arm/mach-cns3xxx. If you are working with an SOC
> from a different family that is already supported by Linux, you have
> to add support for the specific SOC, and the work involved in that
> depends a lot on the particular SOC.
>
> For any other SOC that has no support whatsoever in Linux, I would suggest
> getting the latest Linux kernel from git (3.2-rc2) and looking at the
> highbank, prima2, picoxcell and zynq platforms in there. The code you
> need to write should look similar to any of these, rather than the realview
> platform, which is a fairly unusual one. In case of a new SOC platform,
> you should be prepared to also write device drivers for any vendor
> specific component that you want to support, e.g. network, mmc, audio,
> so I would recommend first researching how many of the components on
> the board already have drivers in Linux.
>
> ? ? ? ?Arnd
>
