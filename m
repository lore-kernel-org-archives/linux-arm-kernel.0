From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 21 Oct 2013 15:51:25 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <52658C49.80400@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>	<20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org>
Message-ID: <5265AFED.1040503@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2013 01:19 PM, Stephen Warren wrote:
> On 10/21/2013 09:54 AM, Thierry Reding wrote:
>> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> ...
>>> I wonder if DT is solving the problem at the right level of
>>> abstraction? The kernel still needs to be aware of all the
>>> nitty-gritty details of how each board is hooked up different,
>>> and have explicit code to deal the union of all the different
>>> board designs.
>>>
>>> For example, if some boards have a SW-controlled regulator for a
>>> device but others don't, the kernel still needs to have driver
>>> code to actively control that regulator, /plus/ the regulator
>>> subsystem needs to be able to substitute a dummy regulator if
>>> it's optional or simply missing from the DT.
>>>
>>> Another example: MMC drivers need to support some boards
>>> detecting SD card presence or write-protect via arbitrary GPIOs,
>>> and others via dedicated logic in the MMC controller.
>>>
>>> In general, the kernel still needs a complete driver to every
>>> last device on every strange board, and needs to support every
>>> strange way some random board hooks all the devices together.
>>
>> I have some difficulty understanding what you think should've been
>> moved out of the kernel. There's only so much you can put into data
>> structures and at some point you need to start writing device
>> specific code for the peripherals that you want to drive.
>
> My point was that (part of) the intent of adding DT support to the
> kernel was to get rid of all the board-specific code/churn in the
> kernel. That's not really possible, since DT is just representing the
> data about the HW (e.g. which GPIO/IRQ numbers) and not the behaviour.
> In order to really remove signifcant board-specific code from the
> kernel, you need to move behaviour out of the kernel too, i.e. hide it
> behind some kind of firmware or virtualization interface, and hence
> have simpler drivers that don't know all the details.
>

In my opinion, not being able to describe behavior (or what people refer
to as "describe how the hardware is used") is a severe limitation of
devicetree usage in Linux. That is not a devicetree limitation per se,
though, it is simply a matter of choice (or, in some cases, the ability
of those arguing for new bindings to sell those bindings as "hardware
description").

Guenter
