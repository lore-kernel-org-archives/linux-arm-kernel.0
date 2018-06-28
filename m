From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Thu, 28 Jun 2018 13:58:53 +0200
Subject: question about arm64 exception handling
Message-ID: <5B34CD7D.5090002@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I am looking at some issues we are seeing on a custom arm platform and I 
had some questions regarding exception handling and hope you can help me 
with that.

The platform has 4 cortex a53 cores running 4.1.51 kernel. On the 
platform upon accessing our wifi devices over PCIe, we observe two issue 
intermittently.

1) synchronous external abort
2) NMI watchdog

With the latter I notice el1_irq in the exception stack trace. Is that 
due to the NMI watchdog or is this caused by another issue like our 
crappy hardware ;-) ?

Regarding the SEA I noticed stuff has been added for that in 4.13. Is is 
worth backporting that to obtain more info about that?

Regards,
Arend
