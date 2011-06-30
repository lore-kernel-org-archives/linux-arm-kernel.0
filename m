From: claude.youn@gmail.com (Seungwhan Youn)
Date: Thu, 30 Jun 2011 16:28:47 +0900
Subject: [PATCH v2 3/3] ARM: EXYNOS4: Add EPLL clock operations
In-Reply-To: <BANLkTi=aGo3WPaftzBxR=Jy6oHAzt+Yhbw@mail.gmail.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
	<1308655463-8787-4-git-send-email-ch.naveen@samsung.com>
	<BANLkTim_0yj8hSefv5BUg5Z1vLh5SWhqjA@mail.gmail.com>
	<BANLkTim2pK5qKwQ5fmJxRHmNHCU=oJtf3A@mail.gmail.com>
	<BANLkTi=aGo3WPaftzBxR=Jy6oHAzt+Yhbw@mail.gmail.com>
Message-ID: <BANLkTinzY57NCviNmerwpa_GZL8jmXr_rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So far i was not lucky in finding out a generic way of deriving the
> epll_div values.
> And it doesn't seem to
> 1. Save lines of code or
> 2. Consolidate the PLL code.
>
> Any suggestions for a simpler implementation are welcome.

No, I mean that 'epll_div' values are _not_always_correct_ on Samsung
SoC platform. It depends on board setting. That 'epll_div' values only
works fine when FINpll is 24MHz, as you know these're from reference
values on User Manual, and board maker can change FINpll freq. with
OM[0] pin setting, XXTI and XusbXTI.
So. if you want to make consolidate the PLL code, you should make a
general formula to calculate that epll_div values on the fly OR move
'epll_div' values table into somewhere machine specific file, not into
platform file 'arch/arm/plat-s5p/clock.c'.

        claude
