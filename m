From: wellsk40@gmail.com (Kevin Wells)
Date: Tue, 17 Aug 2010 17:34:44 -0700
Subject: [PATCH] input/touch: Introduce the LPC32xx touchscreen controller
	driver (v2)
In-Reply-To: <4C69B708.3020008@bluewatersys.com>
References: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
	<1281993661-21097-2-git-send-email-wellsk40@gmail.com>
	<4C69B708.3020008@bluewatersys.com>
Message-ID: <AANLkTi=P-y_xB6RSYN7Oyeb2paSLAFc=Nxu19bWHxE53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

Thanks for taking the time to review this.

>> +
>> + ? ? /*
>> + ? ? ?* Set sample rate to about 240Hz per X/Y pair. A single measurement
>> + ? ? ?* consists of 4 pairs which gives about a 60Hz sample rate based on
>> + ? ? ?* a stable 32768Hz clock source. Values are in clocks.
>> + ? ? ?* Rate is (32768 / (RTR + XCONV + RTR + YCONV + DXP + TTR + UTR) / 4
>> + ? ? ?*/
>
> Is the clock source internal, or at least always 32.768kHz? If not,
> should the timing be controlled via some platform data so that this
> driver is compatible with other board setups?
>

The clock source for this is internal and locked in the driver and clock control
handler at 32768Hz.

As much as I want to argue not using platform data :), I can't think of one good
reason not to use it for this (the keyscanner driver has it). I
probably should of
used it from the start.
