From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 26 Apr 2016 21:25:13 +0300
Subject: [PATCH] ARM: dts: at91: VInCo: fix phy reset gpio flag
In-Reply-To: <1461666272-10107-1-git-send-email-nicolas.ferre@atmel.com>
References: <570BF481.9070903@cogentembedded.com>
 <1461666272-10107-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <571FB289.40807@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/26/2016 01:24 PM, Nicolas Ferre wrote:

> Fix gpio active flag for the phy reset-gpios property. The line is
> active low instead of active high.
> Actually, this flags was never used by the macb driver.
>
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi,
>
> Thanks for having reported this bug to me.

    And thank you for beating me to it and doing the patch. I'm still busy 
with other stuff. :-(

> I hope that we will be able to move forward for changing the phy
> reset code in the macb driver.

    I meant to delete it entirely.

> I plan to queue this patch through arm-soc for 4.7.

    Hm, that way we get that board broken if my phylib/macb patches get merged 
before your patch. Perhaps it would be better to merge this patch thru DaveM's 
tree (before my patches) to keep the kernel bisectable?

> Thanks, best regards,
>    Nicolas

MBR, Sergei
