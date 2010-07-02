From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Fri, 2 Jul 2010 14:48:36 +0200
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
Message-ID: <4C2DE024.8060308@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a question regarding these patches. It seems to me that the kexec 
will be done with the MMU left on for the ARMv7 case. Looking at the 
code in the cpu_arm926_reset() routine in arch/arm/mm/proc-arm926.S this 
is not the case there. Instead, the MMU is turned off and the last 
instruction that is fetched using the virtual address mapping is a jump 
to a physical address.

Shouldn't this be handled as consistently as possible for the different 
ARM sub-archs?

Regards,
Per Fransson
