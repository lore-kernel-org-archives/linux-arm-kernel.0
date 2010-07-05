From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 5 Jul 2010 11:28:35 +0300
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C2DE024.8060308@stericsson.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
Message-ID: <20100705082835.GA32178@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 02, 2010 at 02:48:36PM +0200, Per Fransson wrote:
>
> I have a question regarding these patches. It seems to me that the kexec  
> will be done with the MMU left on for the ARMv7 case. Looking at the  
> code in the cpu_arm926_reset() routine in arch/arm/mm/proc-arm926.S this  
> is not the case there. Instead, the MMU is turned off and the last  
> instruction that is fetched using the virtual address mapping is a jump  
> to a physical address.

This seems to be the case for both ARMv6 and ARMv7. I don't know
why the MMU is not switched off there. Anyway, I've been testing
this on ARMv7 and at least for panic kernel it works even when MMU
is left on (didn't check but maybe the decompressor disables that
before jumping to the kernel).

> Shouldn't this be handled as consistently as possible for the different  
> ARM sub-archs?

Yes, I guess. I'm still wondering why this hasn't been fixed already?

Regards,
MW
