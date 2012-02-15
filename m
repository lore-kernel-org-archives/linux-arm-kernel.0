From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 15 Feb 2012 08:40:37 +0100
Subject: [PATCH 1/2] ARM: OMAP4: cminst: Add boot time __init function for
 cminst
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317CF3B2@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Wed, 15 Feb 2012 06:27:53 +0000")
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
 <1329233348-23356-2-git-send-email-hvaibhav@ti.com>
 <87bop1unln.fsf@macbook.be.48ers.dk>
 <79CD15C6BA57404B839C016229A409A8317CF3B2@DBDE01.ent.ti.com>
Message-ID: <87mx8ktuh6.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Hiremath, Vaibhav <hvaibhav@ti.com> writes:

Hi,

 Vaibhav> -	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 Vaibhav> +	BUG_ON(part >= max_cm_partitions ||
 Vaibhav> part == OMAP4430_INVALID_PRCM_PARTITION ||
 >> 
 >> How about dropping the OMAP4430_ prefix here as it's no longer 4430 specific?
 >> 
 Vaibhav> Peter,

 Vaibhav> You could be right here, from this patch perspective, this
 Vaibhav> change doesn't make sense.

 Vaibhav> But at the first place I am quite not sure, why this has been
 Vaibhav> named as OMAP4430_? Vs some macros are named as OMAP4_.

 Vaibhav> So first we need to understand why it has been named this way,
 Vaibhav> may be "Paul Walmsley" can comment on this. He is original
 Vaibhav> author of this file.

As I read it, it doesn't have anything to do with any specific hardware,
it's just to catch bugs when people forget to initialize the structure
field:

arch/arm/mach-omap2/prcm44xx.h:
/*
 * OMAP4 PRCM partition IDs
 *
 * The numbers and order are arbitrary, but 0 is reserved for the
 * 'invalid' partition in case someone forgets to add a
 * .prcm_partition field.
 */
#define OMAP4430_INVALID_PRCM_PARTITION         0

-- 
Bye, Peter Korsgaard
