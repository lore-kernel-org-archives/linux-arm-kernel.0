From: rcrewe@plxtech.com (Richard Crewe)
Date: Fri, 21 Aug 2009 16:07:34 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
Message-ID: <4A8EB836.3000406@plxtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Section A2.9.3 of the ARM architecture ref. manual seems to imply that 
ldrex/strex instruction pairs won't work correctly if they are nested 
due to pre-emption.

Should a strex instruction be added to the low-level interrupt handler 
or should all ldrex/strex instruction pairs be protected from 
pre-emption by disabling interrupts?

I have a suspicion that this may only cause problems on SMP systems.

-- 
Rich
