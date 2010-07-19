From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Mon, 19 Jul 2010 18:41:03 +0530
Subject: [PATCH 1/2] ARM: move SPEAr to use common mult/shift calculation
	code
In-Reply-To: <1275067996-17233-1-git-send-email-linus.walleij@stericsson.com>
References: <1275067996-17233-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTinS5zMWdoxBczgpQmYWMgWI77Jwkyfz6LtMH8yK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Viresh, Linus

On Fri, May 28, 2010 at 11:03 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> Since the infrastructure for determining shift/mult values from a
> clock rate and a minimum programmable rate is now in the kernel,
> lets remove this custom code.
>
> Cc: Viresh KUMAR <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Viresh: I cannot test this change, but I have compiled it against
> spear600_defconfig. You'd have to test it and Acked-by: it before
> I do anything else with it. Try to think about what a minimum range
> would be for the generic SPEAr platform...

I have applied the patch and tested the same, it works fine on spear platforms.
The timer on spear platforms is 16 bit only (say with min. functional
freq as 187500 HZ.).
With these values the resolution of the timer is not much so what
should be the good value
of SPEAR_MIN_RANGE.

Tested-by: Shiraz Hashim <shiraz.hashim@st.com>

-- 
regards
Shiraz Hashim
