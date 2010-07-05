From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 5 Jul 2010 14:31:36 +0300
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C31B527.8060401@stericsson.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
Message-ID: <20100705113136.GB32178@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 12:34:15PM +0200, Per Fransson wrote:
> But the identity mapping is only set up for user space part. It needs to  
> be set up around the code which turns off the MMU for the case when  
> there is no delay at all. And it would still be nice to not corrupt the  
> page table of the crashing context.

Yeah, with the current version, user-space mappings of the crashing
process are gone.

If they are really needed, then maybe we could do similar than x86
and set up temporary page tables and do the identity mapping there?
This way the crashing process' page tables would remain untouched.

Regards,
MW
