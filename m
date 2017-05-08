From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 08 May 2017 09:01:33 +0200
Subject: [PATCH 2/2] reset: Add a Gemini reset controller
In-Reply-To: <CACRpkdaRkWY7qF43-XxOPu5h0cR3_w3ydHs3Ln-Oay+bzw4JWA@mail.gmail.com>
References: <20170424192802.27430-1-linus.walleij@linaro.org>
 <1493109822.2394.15.camel@pengutronix.de>
 <CACRpkdaRkWY7qF43-XxOPu5h0cR3_w3ydHs3Ln-Oay+bzw4JWA@mail.gmail.com>
Message-ID: <1494226893.3029.21.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, 2017-05-07 at 21:23 +0200, Linus Walleij wrote:
> On Tue, Apr 25, 2017 at 10:43 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > [Me]
> >> +/*
> >> + * Cortina Gemini Reset controller driver
> >> + * Copyright (c) 2017 Linus Walleij <linus.walleij@linaro.org>
> >
> > No license statement, choice or oversight?
> 
> Choice. I'm one of those guys who think that the top-level COPYING file
> in the kernel is by far enough of legalese. If you want, I can put in a license
> of course.

Yes, please do. The implicit statement made by the Signed-off-by tag
refers to the "license indicated in the file", unfortunately.

[...]
> >> +     ret = devm_reset_controller_register(&pdev->dev, &gr->rcdev);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     dev_info(dev, "registered Gemini reset controller\n");
> >
> > This is a bit verbose. I'd remove it and shorten the last part to:
> >
> >         return devm_reset_controller_register(&pdev->dev, &gr->rcdev);
> 
> It's always this thing whether to be in the camp that like drivers to announce
> themselves or not, but I can do as you suggest if it's a strong preference.
> 
> The reason I want it is: deselect the driver from Kconfig, something stops
> working. Compare the dmesg: they both look the same. You don't immediately
> see that something is missing.
> 
> So some people think that it is time to go around in /sys, and then what
> if it is a boot regression, like the system can't mount root without the
> reset controller. (Yeah I know, the thing mounting root should select the
> reset controller then, OK another bug we would have seen with this...)
> 
> And then all of a sudden there is a lot of debug time spent looking for this
> fact that would be spotted in no time if the was a dev_info() about the
> driver being probed.
> 
> But if you insist, I will remove it.

I don't insist.
I am in the camp of people who don't particularly like to see driver
announcements, but that preference only extends to machines I use.

regards
Philipp
