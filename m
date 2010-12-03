From: vitalywool@gmail.com (Vitaly Wool)
Date: Fri, 3 Dec 2010 12:47:14 +0100
Subject: [PATCH] pl011: added clock management feature
In-Reply-To: <20101109224012.GA21992@kroah.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
Message-ID: <AANLkTikUmq7qeFb+0XPpmzcvp5q_Z4SMjBaAgNZaCRqV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 11:40 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
>> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
>>
>> This patch allows to control the pl011 clock using set_termios
>> callback. Any positive baudrate passed enables clock, otherwise
>> disables. This saves a lot of power on submicron designs since
>> we can clock off and disable unused UARTs.
>
> That's nice, but it seems like an overload of what people traditionally
> think of when it comes to baud rates. ?Why not just power down ports
> that are not open instead?

I like the idea as well and this is definitely gonna help conserving
the power for Bluetooth UARTs.

But using baud rate 0 is something I don't like. Why don't you stop
the clocks if RTS is cleared? This would have allowed the line
discipline driver to implicitly control the UART clock and there will
be no risk of losing data, as well as no non-standard behavior
involved. In fact, you'll be transparent to the upper layers in this
case.

~Vitaly
