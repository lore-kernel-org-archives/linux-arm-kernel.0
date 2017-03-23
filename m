From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 23 Mar 2017 08:55:19 -0700
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
References: <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
Message-ID: <20170323155519.GB9460@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 12:11:06PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Mar 23, 2017 at 11:20:39AM +0100, Geert Uytterhoeven wrote:
> > But having the error breaks setups where the GPIO is optional and does
> > not exist.
> 
> so the right way forward is to check harder in the situation where
> -ENOSYS was returned before to determine if there is really no GPIO to
> be used. "Oh, there are hints that there is no GPIO (GPIOLIB=n), so lets
> assume there isn't." is wrong.
> 
> Can we please properly fix the problem instead of papering over it?

I think I once already said what would need to _attempt_ to fix it
"properly". You would need to implement custom parsing of ACPI tables in
GPIOLIB (what if they disable ACPI by mistake?), do the same for OF,
call board's manufacturer hotline to ensure that they indeed did not
forget to describe GPIOs, etc, etc.

Or you could trust that person responsible for selecting kernel
configuration has a clue, and if GPIOLIB is disabled it was disabled for
a reason.

-- 
Dmitry
