From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 15 Apr 2011 20:14:19 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <4DA86CA8.7090104@atmel.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA85B49.60209@vollmann.ch> <4DA86CA8.7090104@atmel.com>
Message-ID: <4DA88AFB.7020806@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/11 18:04, Nicolas Ferre wrote:
> Le 15/04/2011 16:50, Detlef Vollmann :
>> On 04/15/11 15:06, Russell King - ARM Linux wrote:
>>> This is work in progress.
>> Thanks, very useful.
>
> [..]
>
>>> Another question is whether we should allow multiple SRAM pools or not -
>>> this code does allow multiple pools, but so far we only have one pool
>>> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
>>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
>> Having the option to partition the SRAM is probably useful.
>> What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
>> of SRAM, and you might want to combine them into a single pool.
>
> In fact on at91sam9g20 (and some other at91) you can use the mirroring
> of the SRAM until next bank... so you end up with a single pool.
>
> Base @ sram1 base - sram0 size
> size = sram 0 size + sram 1 size
Can you provide details?
I couldn't find anything in the documentation about this.

   Detlef
