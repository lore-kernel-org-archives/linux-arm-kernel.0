From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 5 Nov 2015 20:00:27 -0600
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
In-Reply-To: <563C07C8.9060506@hurleysoftware.com>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com>
Message-ID: <563C09BB.9030706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Hurley wrote:
> Perhaps I wasn't clear enough in my previous comments regarding this
> approach; I see no benefit to re-using the pl011 earlycon definition.
> Just define a completely new earlycon for sbsa32 (and zte):
>
> EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);
>
> Example:
> 	earlycon=sbsa32,0x3ced1000

Sounds like six of one, half-dozen of another.  But I'm happy to modify 
my patch accordingly.  It will avoid the strcmp, but I'm not sure it 
will reduce the actual number of lines of code.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
