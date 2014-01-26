From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 25 Jan 2014 18:54:40 -0800
Subject: GPIO triggers kernel reboot
In-Reply-To: <52E3E031.6040709@denx.de>
References: <52E3E031.6040709@denx.de>
Message-ID: <52E478F0.60903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 25/01/2014 08:02, Heiko Schocher a ?crit :
> Hello all,
>
> is it possible to reboot current mainline kernel triggered from a
> GPIO in kernel space?
>
> If not, how can be done this, so that it has a chance to go into
> mainline?

Your GPIO could (should) be bound to a gpio-keys driver which will 
deliver key presses event; which you can ultimately bind to the action 
of triggering a system reboot.

Granted, this makes you cross a lot of layers, and requires user-space 
to implemnt the reboot policy, but what you are asking for is both a 
mechanism and policy mix, which is usually not accepted.

You are probably working with HW which won't change, but wiring a reset 
button to a system reset output is usually much simpler ;)

>
> Thanks for any suggestions
>
> bye,
> Heiko
