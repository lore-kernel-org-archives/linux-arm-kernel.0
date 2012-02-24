From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Feb 2012 18:27:12 +0000
Subject: [PATCH] gic : check if there are pending interrupts
In-Reply-To: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
References: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120224182712.GI22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 02:45:48PM +0100, Daniel Lezcano wrote:
> The following patch checks if there are pending interrupts on the gic.
> 
> This function is needed for example for the ux500 cpuidle driver.
> When the A9 cores and the gic are decoupled from the PRCMU, the idle
> routine has to check if an interrupt is pending on the gic before entering
> in retention mode.

So what happens if an interrupt becomes pending after you've checked it
but before you've gone into retention mode?  This basically sounds like
one big racy idea to me.

Hardware which allows you to go into retention mode with interrupts
pending which should prevent it (or at least cause it to re-awake) just
sounds like a massive fail to me.
