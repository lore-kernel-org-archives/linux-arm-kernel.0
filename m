From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Jul 2013 16:54:36 +0800
Subject: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
In-Reply-To: <20130708075004.GR24642@n2100.arm.linux.org.uk>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
 <1373004752-21302-5-git-send-email-b32955@freescale.com>
 <20130706050803.GC30164@S2101-09.ap.freescale.net>
 <20953.22066.706534.773272@ipc1.ka-ro>
 <20130708075004.GR24642@n2100.arm.linux
Message-ID: <51DA7E4C.4050507@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?08? 15:50, Russell King - ARM Linux ??:
> On Sun, Jul 07, 2013 at 01:51:14PM +0200, Lothar Wa?mann wrote:
>> Hi,
>>
>> Shawn Guo writes:
>>> On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
>>>> There is something wrong with the RTS/CTS pads:
>>>>    The RTS pad is assigned with the CTS's value;
>>>>    while the CTS pad is assigned with the RTS's value.
>>>>
>>> So basically, you are saying that select_input should be set up for CTS
>>> rather than RTS.  It seems that the people who generated the macro got
>>> the wrong input from developer.
>>>
>> programming 'select_input' only makes sense for inputs, not outputs.
>> Since CTS is an output signal, select_input only makes sense for the
>> RTS function of the pads.
> Note: If you are a DTE, then RTS is an output, CTS is an input.  If you
> are a DCE, then RTS is an input and CTS is an output (normally on a
> standard UART, you just swap the wiring for RTS and CTS but really that's
> all that is going on.)  So swapping them in software should be acceptable
> too, provided you're not having to disable any auto flow control facilities.
>
thanks for explanation.


Huang Shijie
