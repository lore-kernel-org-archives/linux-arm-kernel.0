From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Apr 2011 23:08:55 +0100
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on
	the basis of the memory size.
In-Reply-To: <4D9E2D1C.7070102@ahsoftware.de>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
	<4D9CF5B3.9020007@ahsoftware.de>
	<toa078-0do.ln1@chipmunk.wormnet.eu>
	<4D9E2D1C.7070102@ahsoftware.de>
Message-ID: <20110407220855.GD17049@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2011 at 11:31:08PM +0200, Alexander Holler wrote:
> Am 07.04.2011 10:55, schrieb Alexander Clouter:
>> In gmane.linux.kernel Alexander Holler<holler@ahsoftware.de>  wrote:
>>>
>>> Sorry, I don't feel the need to waste my time prodcuing patches to get
>>> them called "abominations". Which means my willingness to post further
>>> patches just got below zero.
>>>
>> In a posting from Nico before you got offended it was explained to you
>> *why* it was a Bad Idea(tm) and that that sort of thing simply does not
>> work.  As a game, is it really a situation with *zero* probability of
>> occuring that someone might produce a kirkwood/Sheeva flavoured board
>> with only 128MB RAM?
>>
>> As well as a willingness to 'produce' patches (which to be frank
>> *anyone* can do[1])...the hard part is producing *good* patches.  To
>> produce good patches you need to read and understand the wisdom you get
>> back from the mailing lists you post to.  If you do not understand the
>> reasoning, ask.
>>
>> This is why you see [PATCHv${BIGNUM}] so often in a number of mailing
>> lists.  If you are not willing to accept *everyone*, including yourself,
>> writes crap code...well the value of your patches falls below zero.
>
> Requiring a machine ID and the needed stuff to handle that for a board  
> which just is using two GPIOs different than another board is why the  
> ARM tree exploded.

You can not be any more wrong than that.

The reason the ARM tree exploded is because of the compartmentalized
sub-community structure, where the vast majority of (eg) OMAP development
is done independently of the (eg) Samsung development.

Consequently, there's no attempt to consolidate code between the SoCs,
even for basic stuff like 32-bit up-counting timers.  We've ended up with
_nine_ implementations of clocksources all doing the same thing in that
respect.

That's got precisely zilch to do with machine IDs, and your attempt to
blame the bloat on machine IDs just shows how misinformed you are.
