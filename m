From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 13 May 2018 13:11:08 -0700
Subject: [PATCH RESEND net-next v2 1/8] dt-bindings: net: dwmac-sun8i:
 Clean up clock delay chain descriptions
In-Reply-To: <20180513200529.GF12738@lunn.ch>
References: <20180513191425.9801-1-wens@csie.org>
 <20180513191425.9801-2-wens@csie.org>
 <20180513194919.GE12738@lunn.ch>
 <CAGb2v66nqWnioS1pwfWFtMZFZSWvf4SwXr_ExnnGvYsK9RU_LA@mail.gmail.com>
 <20180513200529.GF12738@lunn.ch>
Message-ID: <CAGb2v64ACc1tQRhy4LhnvCC7VJ3nVM-wMbgUgzviGMWKPFsSuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2018 at 1:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > Hi Chen-Yu
>> >
>> > Are these delays the MAC applies? Not the PHY. It would be good to
>> > make it clear here these are MAC imposed delays.
>>
>> Yes these are applied on the MAC side. Being described in the device
>> tree bindings for the MAC, I thought this was implied to be the case?
>> Are there known exceptions?
>
> There is frequent confusion with this. Most of the time, the PHY does
> the delay, not the MAC, based on the phy-mode. So the MAC doing it is
> an exception in itself.
>
> Do you actually need these delays for the board you adding support
> for? Does the PHY not support adding the needed delays? If you don't
> need the delays, i would not even implement them.

Yes this is already used on the Bananapi M3. This patch merely reformats
the description and adds a note saying this only applies to RGMII mode.

ChenYu
