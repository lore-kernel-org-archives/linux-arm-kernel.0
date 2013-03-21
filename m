From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Thu, 21 Mar 2013 13:14:23 +0100
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <1363866553-15054-6-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-6-git-send-email-linus.walleij@stericsson.com>
Message-ID: <514AF99F.7040100@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 12:49 PM, Linus WALLEIJ wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> We are trying to decompose and decentralize the code in
> the DB8500 PRCMU out into subdrivers. The CPUidle code is
> calling down into the PRCMU driver basically just to access
> these registers, so let's remap them locally in the CPUidle
> driver and move the code there, simply. Besides, the PRCMU
> code was poking around in the GIC which is the responsibility
> of the machine.
>
> Cc: Daniel Lezcano<daniel.lezcano@linaro.org>
> Cc: Rickard Andersson<rickard.andersson@stericsson.com>
> Cc: Samuel Ortiz<sameo@linux.intel.com>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
> Sam, I'm requesting an ACK for taking this through the
> ARM SoC tree.
> ---
This functionality will be used by the platform suspend operation also 
which I am currently working on. So I would prefer if you can move it to 
a separate file instead so it can be used by suspend as well. I 
recommend to have it the same way we have it in our internal track i.e. 
a file called pm.c in the machine.

BR
Rickard
