From: Grzegorz.Sygieda@tieto.com (Grzegorz.Sygieda at tieto.com)
Date: Wed, 10 Nov 2010 09:54:18 +0200
Subject: [PATCH] pl011: added clock management feature
In-Reply-To: <20101110000152.GA8993@n2100.arm.linux.org.uk>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
	<20101109224012.GA21992@kroah.com>
	<20101110000152.GA8993@n2100.arm.linux.org.uk>
Message-ID: <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D88A@EXMB01.eu.tieto.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On Tue, Nov 09, 2010 at 02:40:12PM -0800, Greg KH wrote:
>> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
>> > From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
>> > 
>> > This patch allows to control the pl011 clock using set_termios 
>> > callback. Any positive baudrate passed enables clock, otherwise 
>> > disables. This saves a lot of power on submicron designs since we 
>> > can clock off and disable unused UARTs.
>> 
>> That's nice, but it seems like an overload of what people 
>> traditionally think of when it comes to baud rates.  Why not just 
>> power down ports that are not open instead?
>
>We already do.  My question to Linus (in a previous message) is why this isn't sufficient.

The main goal was to disable/enable clock while port open. This is usefull for scenario, where some higher level driver wants to control the power consumption (using set_termios). In the same time a user-space app (eg. hciattach) is still bounded to the specific /dev/tty* device associated with particular uart. From user POV device is always open, and app does not have to respawn, and we can save power.

I hope it's clear explanation. 
