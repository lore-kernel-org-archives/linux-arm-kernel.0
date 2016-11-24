From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 24 Nov 2016 10:49:23 +0100
Subject: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
In-Reply-To: <8737ihmctr.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
 <28082657.RK5ubAe11Q@wuerfel> <8737ihmctr.fsf@free-electrons.com>
Message-ID: <CAPv3WKddPHgpRU2_tVoDF=5Z-nqfFPxjgJ-+z9o-1tR2=fFvAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

2016-11-24 10:44 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi Arnd,
>
>  On jeu., nov. 24 2016, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Thursday, November 24, 2016 10:22:31 AM CET Gregory CLEMENT wrote:
>>>
>>> I don't have an option for mmc in general, but using child node do not
>>> fit at all the xenon controller.
>>>
>>> For this controller each slot has its own set of register, so there is
>>> no common ressource to share so no advantage to use it. Using child node
>>> in our case will just make the code more complex for no benefit.
>>
>> If every slot has its own registers, what is it that makes up the
>> 'controller'? It sounds to me that you just have to adjust the terminology
>> and talk about multiple controllers then, with one slot per controller.
>>
>
> I agree and actually there were some words about in at the begining of
> the binding:
>
> "A single Xenon IP can support multiple slots.
> Each slot acts as an independent SDHC. It owns independent resources, such
> as register sets clock and PHY.
> Each slot should have an independent device tree node."
>
> All the confusion came from the fact that we still need to identify a
> slot ID. For an obscure reason the hardware can't guess the slot ID from
> the address register."
>

How about to avoid confusion, by simply renaming this number to
port-id/xenon-id or anything else but slot? I guess this may allow to
avoid some misunderstandings.

Best regards,
Marcin
