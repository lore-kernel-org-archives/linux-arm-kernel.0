From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 07 Nov 2011 12:36:44 +0100
Subject: PLEASE FIX: lack of trailing , on structure initializers
In-Reply-To: <20111105164855.GG12913@n2100.arm.linux.org.uk>
References: <20111105164855.GG12913@n2100.arm.linux.org.uk>
Message-ID: <4EB7C2CC.40106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2011 05:48 PM, Russell King - ARM Linux :
> The lack of trailing ','s on initializers is causing me quite an amount
> of grief while trying to prepare the set of patches for arch_reset.
> It's really annoying to add a new initializer at the end of a structure,
> not notice the lack of trailing ',' on the last entry, and then end up
> having to rework the patches because of that.  E.g.:
> 
> arch/arm/mach-orion5x/mv2120-setup.c:238: error: request for member ?restart? in something not a structure or union
> 
> caused by the lack of trailing comma for the .fixup initializer on the
> preceding line.
> 
> We have around 778 of these in arch/arm, and it's about time that number
> started to be reduced.  This will cause a lot of conflicts, so the
> earlier it can be done in the cycle (and merged into each platform tree)
> the less (hopefully) it'll conflict with other work that goes through
> the appropriate maintainer tree.

Hi Russell,

We have a dozen of those missing trailing ',' in mach-at91.
But as you mentioned in your other email, we may need to wait for
another change in the concerned files to fix this. Am I right?

So we keep this in mind...

Best regards,
-- 
Nicolas Ferre
