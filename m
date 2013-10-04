From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 04 Oct 2013 22:40:43 +1300
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B7E90.30000@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org> <5241489D.4000709@yahoo.com.au>
 <524B7E90.30000@wwwdotorg.org>
Message-ID: <524E8D1B.2050909@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:01 PM, Stephen Warren wrote:
>>> On 09/21/2013 03:18 AM, Craig McGeachie wrote:
>>>>    * Restore the flow of control that re-reads the base pending register
>>>>      after handling any interrupt. The current version handles all
>>>>      interrupts found in a GPU pending register before re-reading the
>>>>      base pending register. In the original Broadcom assembly code, there
>>>>      appear to be defect tracking numbers next to code inserted to create
>>>>      this behaviour.
>
> BTW, you mentioned "restore" above; while your patch did align the
> upstream Linux driver more closely with the sample code in the PDF, I'm
> not sure that any Linux port actually previously followed that example,
> did it? I'm nit-picking about the semantics of the word "restore" here:-)

When you refer to other ports, are you referring to the likes of 
omap2/tegra/u300?

Cheers,
Craig.
