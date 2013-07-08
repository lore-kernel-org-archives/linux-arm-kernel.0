From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Jul 2013 14:31:03 +0800
Subject: [PATCH v3 4/6] ARM: dts: imx6q{dl}: fix the wrong RTS/CTS pad name
In-Reply-To: <20953.22066.706534.773272@ipc1.ka-ro>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>	<1373004752-21302-5-git-send-email-b32955@freescale.com>	<20130706050803.GC30164@S2101-09.ap.freescale.net>
 <20953.22066.706534.773272@ipc1.ka-ro>
Message-ID: <51DA5CA7.1050305@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?07? 19:51, Lothar Wa?mann ??:
> Hi,
>
> Shawn Guo writes:
>> On Fri, Jul 05, 2013 at 02:12:30PM +0800, Huang Shijie wrote:
>>> There is something wrong with the RTS/CTS pads:
>>>    The RTS pad is assigned with the CTS's value;
>>>    while the CTS pad is assigned with the RTS's value.
>>>
>> So basically, you are saying that select_input should be set up for CTS
>> rather than RTS.  It seems that the people who generated the macro got
>> the wrong input from developer.
>>
> programming 'select_input' only makes sense for inputs, not outputs.
> Since CTS is an output signal, select_input only makes sense for the
> RTS function of the pads.
Hi Lothar:

In our imx6 Soc, the CTS is used as a input signal, not as a output signal.

I checked two boards, one is imx6q ARM2 armidillo board, one is 
imx6-sabreauto board,
both the boards use the CTS as a input signal.



thanks
Huang Shijie
