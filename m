From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Oct 2015 20:37:57 +0100
Subject: [PATCH 3/3] hwrng: st: Use real-world device timings for timeout
In-Reply-To: <1444142640-14721-3-git-send-email-lee.jones@linaro.org>
References: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
 <1444142640-14721-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20151006193757.GY21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 03:44:00PM +0100, Lee Jones wrote:
> Samples are documented to be available every 0.667us, so in theory
> the 8 sample deep FIFO should take 5.336us to fill.  However, during
> thorough testing, it became apparent that filling the FIFO actually
> takes closer to 12us.

Is that measured?

> +/*
> + * Samples are documented to be available every 0.667us, so in theory
> + * the 8 sample deep FIFO should take 5.336us to fill.  However, during
> + * thorough testing, it became apparent that filling the FIFO actually
> + * takes closer to 12us.
> + */
> +#define ST_RNG_FILL_FIFO_TIMEOUT	12

I hope you're not using such a precise figure with udelay().  udelay()
is not guaranteed to give exactly (or even at least) the delay you
request.  It's defined to give an approximate delay.

Many people have a problem understanding that, so I won't explain why
it is that way, just accept that it is and move on... it's not going
to magically get "fixed" because someone has just learnt about this. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
