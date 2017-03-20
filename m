From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Mar 2017 12:07:18 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
References: <20170306085842.yijkfpqi3adcedmm@pengutronix.de>
 <CAMuHMdV2_vbocY4wCzvYtPAaF+QEX_Y4g6qVu5EqEBf5AnFdaw@mail.gmail.com>
 <20170306093043.ay4dz3ehp3aakwxh@pengutronix.de>
 <CAMuHMdWQuvANNU14A7NQuzv6AFp04bq4DG_oc7w9h4wUrG+4aQ@mail.gmail.com>
 <20170306100220.droey65uq2ew3mzu@pengutronix.de>
 <CACRpkdYeFyr4yjQjDAUpPJwuD_NW2y=wXnzt1xSNoOX0SFCLmw@mail.gmail.com>
 <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
Message-ID: <20170320110718.e44s2gip36m75bqj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

On Mon, Mar 20, 2017 at 11:38:52AM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 20, 2017 at 11:31 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 20, 2017 at 10:56:14AM +0100, Geert Uytterhoeven wrote:
> >> Documentation/gpio/consumer.txt rightfully sates:
> >> | Note that gpio_get*_optional() functions (and their managed variants), unlike
> >> | the rest of gpiolib API, also return NULL when gpiolib support is disabled.
> >> | This is helpful to driver authors, since they do not need to special case
> >> | -ENOSYS return codes.  System integrators should however be careful to enable
> >> | gpiolib on systems that need it.
> >
> > I cannot find this paragraph in Documentation/gpio/consumer.txt:
> >
> >         $ git grep -e 'ENOSYS' v4.11-rc3 -- Documentation/gpio/
> >         <void>
> 
> It was added by commit 22c403676dbbb7c6 ("gpio: return NULL from
> gpiod_get_optional when GPIOLIB is disabled")

Ah, that's in next.

I still think this is wrong and I'm a bit disappointed that Linus merged
this patch (without saying so in the thread even) as I thought Linus and
I agreed on this being a bad idea.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
