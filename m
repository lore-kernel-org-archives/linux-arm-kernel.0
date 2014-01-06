From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon, 6 Jan 2014 19:13:27 +0100
Subject: [PATCH 6/6] at91: dt: sam9261: Added DM9000 in the device tree
In-Reply-To: <1460399.vQDGWoVpz2@wuerfel>
References: <1388507534-10570-1-git-send-email-jjhiblot@traphandler.com>
 <4526077.qASk8HSHKP@wuerfel>
 <CACh+v5PptkrXERAqBUOv-DSaRDQ5NzJAc919Ne3iN9iVszRP+A@mail.gmail.com>
 <1460399.vQDGWoVpz2@wuerfel>
Message-ID: <CACh+v5Mt=bnfnZpux1veEtiOpc1M_yryuy=bDvMOOJf5RT6WxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

sorry for the delay. I'll rework the driver to include some ideas
proposed by you and Boris. Boris proposed to have several timing
decoders (a generic one, one for NAND and so on). I plan to use the
compatibility name to select the decoder.and use the DT representation
you proposed last : one top "simple-bus" and one sub-node "atmel,smc"
per chip-select with one (or more) sub-device per chip-select.

Jean-Jacques




2014/1/2 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 02 January 2014 20:31:00 Jean-Jacques Hiblot wrote:
>> > If each bus interface has a fixed range of registers, you can actually
>> > collapse the upper two nodes again and just have one device per
>> > chipselect.
>> This is indeed the case, but I'd rather keep the top node to highlight
>> the fact that all the devices are physically tied to the same bus.
>
> How about using a top-level "simple-bus" node with the complex ranges
> property but making the driver match the sub-devices with the smaller
> register range then?
>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
