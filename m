From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 18 Jul 2014 11:21:03 +0200
Subject: [PATCH 1/5] arm: dts: omap3-gta04: Add missing nodes to fully
 describe gta04 board
In-Reply-To: <CAGhQ9VwTXdCHe693PBtaVsv28-heEHY3=qbnn+mdgk3ea3u7qQ@mail.gmail.com>
References: <1405369228-27197-1-git-send-email-marek@goldelico.com>
 <1405369228-27197-2-git-send-email-marek@goldelico.com>
 <CAGhQ9Vx1gm9=vda9dUVYR25JK4VSUe9Qk5_xc_bo9ZPLFCtExA@mail.gmail.com>
 <0C2AB07A-C515-4D5E-A823-DDF7C871515A@goldelico.com>
 <CAGhQ9VwTXdCHe693PBtaVsv28-heEHY3=qbnn+mdgk3ea3u7qQ@mail.gmail.com>
Message-ID: <CABxcv==sj5ZZ_f1gqgREFDNoiVv71k3rjQLPq6CpZbB-643Z4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek and Dr. H. Nikolaus,

On Fri, Jul 18, 2014 at 8:55 AM, Joachim Eastwood <manabian@gmail.com> wrote:
> On 16 July 2014 09:17, Dr. H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Am 15.07.2014 um 14:45 schrieb Joachim Eastwood:
>>
>>> Hi Marek,
>>>
>>> You seem to add some DT nodes for hw that doesn't have drivers in
>>> mainline. I think you should leave those out until the driver itself
>>> is upstream and the bindings for it is documented.
>> is there some policy for only having nodes for existing drivers in DT files?
>

I strongly agree with Joachim on this regard.

>> If I understand the device tree concept correctly, it should not describe drivers
>> (and hence nothing about the state of them being mainlined), but it should statically
>> describe the given hardware in a way that kernel and drivers can read it (or ignore).
>> And even other kernels can use it (because they run on the same hardware).
>>

Yes, it should describe hardware but that description should be
previously agreed and properly documented as was mentioned before.

>> So unless there is an important reason not to have "currently unused" nodes
>> in the DT source/binary (loading time is IMHO neglectable), I would ask that we
>> can keep with the complete DT instead of splitting it up artificially and getting back
>> to the same status (because the hardware does not change over time).
>

I understand your motivation since it will allow you to not have to
maintain a patch-set for your downstream DTS changes but I would like
to ask you the opposite question. What's the benefit for the kernel
community to keep in a mainline DTS a bunch of device nodes with DT
bindings that have not been neither discussed nor documented?

Developers doing a board bring-up usually use the DTS in mainline as a
reference for their boards and having non-documented/agreed DT binding
on the upstream DTS will only bring confusion and frustration to them
IMHO.

We already have some issues with Device Trees (bindings that broke
backward compatibility, drivers implementing custom DT binding instead
of using standard ones, bindings that don't really reflect the actual
H/W, etc), please don't make this even more complicated to developers.

Thanks a lot and best regards,
Javier
