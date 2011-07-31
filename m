From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 30 Jul 2011 22:33:05 -0700
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case of
	error interrupt
In-Reply-To: <CAKnu2Mp0Xs3ivj0Vd1=Euj1CyKsWpBLrf_L_jYWuOnoRMpxGGQ@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>
	<CAKnu2Mp0Xs3ivj0Vd1=Euj1CyKsWpBLrf_L_jYWuOnoRMpxGGQ@mail.gmail.com>
Message-ID: <CAOh2x=ntfuZ46nGVAGgEeYNPQwV677sT2Bks7Ve02LZqthHpQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/30/11, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/7/29 Viresh Kumar <viresh.kumar@st.com>:
> NAK.
>
> These snippets illustrate what is not good about this patch, you're making
> the driver fragile by removing checks for spurious IRQ.
>
> So for example if there is an error or TC IRQ on a channel that is not
> in use, what happens now?
>
> It used to result in IRQ_NONE, now all of a sudden we start handling
> spurious IRQs and claim IRQ_HANDLED with totally unpredictable
> results, whereas they would previously gather error metrics for
> spurious IRQs.
>

I got your point. Will resend this patch with better handling for
spurious interrupts.

--
viresh
