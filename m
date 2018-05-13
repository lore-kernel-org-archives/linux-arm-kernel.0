From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 14 May 2018 04:10:58 +0800
Subject: [PATCH RESEND net-next v2 1/8] dt-bindings: net: dwmac-sun8i:
 Clean up clock delay chain descriptions
In-Reply-To: <20180513200529.GF12738@lunn.ch>
References: <20180513191425.9801-1-wens@csie.org>
 <20180513191425.9801-2-wens@csie.org> <20180513194919.GE12738@lunn.ch>
 <CAGb2v66nqWnioS1pwfWFtMZFZSWvf4SwXr_ExnnGvYsK9RU_LA@mail.gmail.com>
 <20180513200529.GF12738@lunn.ch>
Message-ID: <272E1914-029C-492C-B521-BC63D6A705D7@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?5?14? GMT+08:00 ??4:05:29, Andrew Lunn <andrew@lunn.ch> ??:
>> > Hi Chen-Yu
>> >
>> > Are these delays the MAC applies? Not the PHY. It would be good to
>> > make it clear here these are MAC imposed delays.
>> 
>> Yes these are applied on the MAC side. Being described in the device
>> tree bindings for the MAC, I thought this was implied to be the case?
>> Are there known exceptions?
>
>There is frequent confusion with this. Most of the time, the PHY does
>the delay, not the MAC, based on the phy-mode. So the MAC doing it is
>an exception in itself.
>
>Do you actually need these delays for the board you adding support
>for? Does the PHY not support adding the needed delays? If you don't
>need the delays, i would not even implement them.

They are needed if the rx/tx have not equal length.

For several boards if the delay is not present, the network
is unusable. (I have at least met this on Banana Pi M3, an
Allwinner A83T SBC w/ RTL8211E)

>
>    Andrew
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
