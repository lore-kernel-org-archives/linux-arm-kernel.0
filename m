From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 6 Oct 2011 19:25:53 +0200 (CEST)
Subject: [PATCH RESEND] ARM: smp_twd: Reconfigure clockevents after
	cpufreq change
In-Reply-To: <CAKnu2ModYp+F0kq6qVo9SQJ88GR_EwGNgH2WZXJrXUeR1xyzQw@mail.gmail.com>
References: <1315292775-4413-1-git-send-email-linus.walleij@stericsson.com>
	<CAKnu2ModYp+F0kq6qVo9SQJ88GR_EwGNgH2WZXJrXUeR1xyzQw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1110061922440.3240@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Oct 2011, Linus Walleij wrote:

> 2011/9/6 Linus Walleij <linus.walleij@stericsson.com>:
> 
> > From: Colin Cross <ccross@android.com>
> >
> > The localtimer's clock changes with the cpu clock. After a
> > cpufreq transition, update the clockevent's frequency and
> > reprogram the next clock event.
> 
> Thomas do you think you can have a look at this patch and ACK
> it if it looks OK to you? It's the use of clockevents_update_freq()
> function you added after we discussed this in Budapest.
> 
> Since it's likely the first user of that infrastructure we need
> to get it right.

The usage is correct.
 
> Here is the entire patch i Russells tracker:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2

The only thing what puzzles me is:

> +	if (!IS_ERR_OR_NULL(twd_clk))
> +		twd_timer_rate = clk_get_rate(twd_clk);
> +	else
> +		twd_calibrate_rate();

How is made sure that the cpu freq update thing is not called when
twd_clk is not available or am I missing something ?

Thanks,

	tglx
