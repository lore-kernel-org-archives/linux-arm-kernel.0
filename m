From: nico@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 09:56:59 -0400 (EDT)
Subject: [PATCH] ARM: locks: remove opencoded #16 for ticket shift
In-Reply-To: <1373894879-30559-1-git-send-email-will.deacon@arm.com>
References: <1373894879-30559-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1307170952580.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jul 2013, Will Deacon wrote:

> The ticket width of our spinlocks is defined by TICKET_SHIFT, so remove
> the opencoded #16 from the trylock implementation.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

This is pointless.

>  		"	ldrex	%0, [%3]\n"
>  		"	mov	%2, #0\n"
> -		"	subs	%1, %0, %0, ror #16\n"

Any value other than 16 would break that code.  You'd rather ensure it 
never gets defined to anything else.


Nicolas
