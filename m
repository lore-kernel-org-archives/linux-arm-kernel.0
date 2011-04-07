From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 7 Apr 2011 09:30:15 +0200
Subject: [PATCHv5 2/3] ARM: Allow machines to override __delay()
In-Reply-To: <1302047800-26720-3-git-send-email-sboyd@codeaurora.org>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>
	<1302047800-26720-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D9D6807.40800@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:56 AM, Stephen Boyd wrote:
> Some machines want to implement their own __delay() routine based
> on fixed rate timers. Expose functionality to set the __delay()
> routine at runtime. This should allow two machines with different
> __delay() routines to happily co-exist within the same kernel
> with minimal overhead.
>
> Russell expressed concern that using a timer based __delay()
> would cause problems when an iomapped device isn't mapped in
> prior to a delay call being made (see
> http://article.gmane.org/gmane.linux.ports.arm.kernel/78543  for
> more info). We can sidestep that issue with this approach since
> the __delay() routine_should_  only be pointed to a timer based
> delay once the timer has been properly mapped. Up until that
> point __delay() and udelay() will use delay_loop() which is
> always safe to call.
>
> This patch is inspired by x86's delay.c
>

Tested-by: Mattias Wallin <mattias.wallin@stericsson.com>

Yours,
Mattias Wallin
