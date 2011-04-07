From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 7 Apr 2011 09:29:57 +0200
Subject: [PATCHv5 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>
	<1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D9D67F5.8030703@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:56 AM, Stephen Boyd wrote:
> We want to allow machines to override the __delay() implementation
> at runtime so they can use a timer based __delay() routine. It's
> easier to do this using C, so let's write udelay and friends in C.
>
> We lose the #if 0 code, which according to Russell is used "to
> make the delay loop more stable and predictable on older CPUs"
> (seehttp://article.gmane.org/gmane.linux.kernel/888867  for more
> info). We shouldn't be too worried though, since we'll soon add
> functionality allowing a machine to set the __delay() loop
> themselves, thus allowing machines to resurrect the commented out
> code should they need it.
>
> Nicolas expressed concern that fixed lpj cmdlines will break due to
> compiler optimizations. That doesn't seem to be the case since
> before and after this patch I get the same lpj value when running
> my CPU at 19.2 MHz. That should be sufficiently slow enough to
> cover any machine running Linux.

Tested-by: Mattias Wallin <mattias.wallin@stericsson.com>

Yours,
Mattias Wallin
