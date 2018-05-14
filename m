From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 14 May 2018 13:18:30 +0800
Subject: [PATCH RESEND net-next v2 1/8] dt-bindings: net: dwmac-sun8i:
 Clean up clock delay chain descriptions
In-Reply-To: <CAGb2v66F_Ho2OZdrF3p6xe9mQ=zJZ_KjE9MnW1VmWs9jw65eEg@mail.gmail.com>
References: <20180513191425.9801-1-wens@csie.org>
 <20180513191425.9801-2-wens@csie.org> <20180513194919.GE12738@lunn.ch>
 <CAGb2v66nqWnioS1pwfWFtMZFZSWvf4SwXr_ExnnGvYsK9RU_LA@mail.gmail.com>
 <20180513200529.GF12738@lunn.ch>
 <CAGb2v64ACc1tQRhy4LhnvCC7VJ3nVM-wMbgUgzviGMWKPFsSuQ@mail.gmail.com>
 <20180513202938.GH12738@lunn.ch>
 <CAGb2v66F_Ho2OZdrF3p6xe9mQ=zJZ_KjE9MnW1VmWs9jw65eEg@mail.gmail.com>
Message-ID: <AC88E7D0-DDC9-4EB9-91EE-441C1C017BDB@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?5?14? GMT+08:00 ??12:59:22, Chen-Yu Tsai <wens@csie.org> ??:
>On Sun, May 13, 2018 at 1:29 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Sun, May 13, 2018 at 01:11:08PM -0700, Chen-Yu Tsai wrote:
>>> On Sun, May 13, 2018 at 1:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>> >> > Hi Chen-Yu
>>> >> >
>>> >> > Are these delays the MAC applies? Not the PHY. It would be good
>to
>>> >> > make it clear here these are MAC imposed delays.
>>> >>
>>> >> Yes these are applied on the MAC side. Being described in the
>device
>>> >> tree bindings for the MAC, I thought this was implied to be the
>case?
>>> >> Are there known exceptions?
>>> >
>>> > There is frequent confusion with this. Most of the time, the PHY
>does
>>> > the delay, not the MAC, based on the phy-mode. So the MAC doing it
>is
>>> > an exception in itself.
>>> >
>>> > Do you actually need these delays for the board you adding support
>>> > for? Does the PHY not support adding the needed delays? If you
>don't
>>> > need the delays, i would not even implement them.
>>>
>>> Yes this is already used on the Bananapi M3. This patch merely
>reformats
>>> the description and adds a note saying this only applies to RGMII
>mode.
>>
>> Yes, the current code is needed for the Bananapi M3. But you have
>> another patch which extends the code to support a smaller range. Do
>> you have a board which actually needs this? If not, i would not add
>> that new code.
>
>IIRC the delay on the PHY side is either 2ns or none. The delay on the
>MAC side here is an order smaller, likely fine tuning to cope with
>board
>design deficiencies.

And the weird thing is that the delay fails to work on some batches
of RTL8211E, notably many cases are shown on Pine A64+
board.

P.S. The delay is intended to be set via wires on PCB, other than
by software. Although Realtek provided some magic numbers
to Pine64, in order to fix the network problem due to PHY
delay failure.

>
>Currently no other board requires this, but this is already part of the
>binding. The new stuff limits the range for a specific SoC, simply
>because
>that is the range supported by the control register. Not implementing,
>i.e.
>supporting the whole range from the property, which might get
>truncated,
>doesn't make much sense to me.
>
>Regards
>ChenYu
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
