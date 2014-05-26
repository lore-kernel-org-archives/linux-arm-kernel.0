From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 May 2014 11:26:42 +0200
Subject: [PATCH] arm: Set hardirq tracing to on when idling
In-Reply-To: <1401045323-7116-1-git-send-email-minyard@acm.org>
References: <1401045323-7116-1-git-send-email-minyard@acm.org>
Message-ID: <4559339.apo3Fd10HK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 25 May 2014 14:15:23 minyard at acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The CPU will go to idle with interrupts off, but the interrupts
> will wake up the idle.  This was causing very long irqsoff trace
> values because, basically, the whole idle time was traces with
> irqs off, even though they weren't really off.  Rework the idle
> code to turn hardirq tracing to on befor calling idle.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  arch/arm/kernel/process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I'm not sure this is correct for all ARM boards, but it fixes the
> issue for the Vexpress board I have.  No more 4 second irqsoff
> times.

If this patch is correct for ARM, I wonder if it should be done
in architecture independent code instead. Do you see the same
thing on x86? If not, do you know what's different?

It seems like the right thing to do, I just don't understand
why nobody hit this before.

	Arnd
