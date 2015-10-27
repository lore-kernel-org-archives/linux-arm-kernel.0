From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 27 Oct 2015 23:53:29 +0100
Subject: [PATCH] rtc: ds1307: Fix alarm programming for mcp794xx
In-Reply-To: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
References: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
Message-ID: <20151027225329.GK22331@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/2015 at 09:29:57 +0300, Tero Kristo wrote :
> mcp794xx alarm registers must be written in BCD format. However, the
> alarm programming logic neglected this by adding one to the value
> after bin2bcd conversion has been already done, writing bad values
> to month register in case the alarm being set is in October. In this
> case, the alarm month value becomes 0x0a instead of the expected 0x10.
> 
> Fix by moving the +1 addition within the bin2bcd call also.
> 
> Fixes: 1d1945d261a2 ("drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips")
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
