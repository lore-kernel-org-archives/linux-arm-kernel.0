From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 12 Mar 2015 09:57:53 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <5500EA26.7090007@codeaurora.org>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum>
 <20150306192813.GG10717@pengutronix.de> <54FA02B7.8090703@codeaurora.org>
 <1425895136.3152.22.camel@pengutronix.de> <54FDEEFE.1060803@codeaurora.org>
 <20150309210735.14952.91257@quantum> <20150309215803.GD7525@pengutronix.de>
 <54FE215D.7090804@codeaurora.org> <20150309233416.GF7525@pengutronix.de>
 <5500EA26.7090007@codeaurora.org>
Message-ID: <1426150673.14455.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Mittwoch, den 11.03.2015, 18:21 -0700 schrieb Stephen Boyd:
[...]
> Why does Philipp like 110Hz the most? Where is the desire for that rate
> coming from?
> 
> > And the lower
> > abs(1 / 110 - 1 / r) the better. 
> 
> Similarly, where is this requirement coming from? Some datasheet? Or is
> it just some arbitrary decision we've made that may not hold true for
> all consumers?

In my panel example the datasheet usually documents the typical pixel
clock and vertical and horizontal timings that exactly result in the
nominal panel refresh rate, currently most often 60 Hz.

In this use case, the driver doesn't want the pixel clock to stay below
a hard frequency limit, but to get as close as possible to the target
frequency, either above or below, so the relative error to the nominal
panel refresh rate stays as small as possible. Thus for a fictional
target rate of 110 Hz, I'd like to minimize abs((round_rate / 110) - 1).

regards
Philipp
