From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 19 Sep 2014 09:56:31 -0700
Subject: [PATCH 1/3] watchdog: qcom: add support for KPSS WDT
In-Reply-To: <20140919162550.GI3749@joshc.qualcomm.com>
References: <cover.1411078425.git.joshc@codeaurora.org>
 <32d17907ad1dfdcafe4e76f33adc2ff22631cd28.1411078425.git.joshc@codeaurora.org>
 <541B97CD.60400@roeck-us.net>
 <20140919032416.GE3749@joshc.qualcomm.com>
 <541BA5F7.1030704@roeck-us.net>
 <20140919162550.GI3749@joshc.qualcomm.com>
Message-ID: <20140919165631.GA32457@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 11:25:50AM -0500, Josh Cartwright wrote:
> On Thu, Sep 18, 2014 at 08:41:43PM -0700, Guenter Roeck wrote:
> > On 09/18/2014 08:24 PM, Josh Cartwright wrote:
> > >On Thu, Sep 18, 2014 at 07:41:17PM -0700, Guenter Roeck wrote:
> > >>On 09/18/2014 03:26 PM, Josh Cartwright wrote:
> > >>>Add a driver for the watchdog timer block found in the Krait Processor
> > >>>Subsystem (KPSS) on the MSM8960, APQ8064, and IPQ8064.
> > >>>
> > >>>Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > >>
> > >>Hi Josh,
> > >>
> > >>comments inline.
> > >
> > >Thanks for taking a look!
> > >
> [..]
> > >>>+	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> > >>
> > >>That leaves you with no default timeout if timeout-sec is not set in devicetree,
> > >>which if I understand the code correctly might result in an immediate reset.
> > >>Is this really what you want to happen ?
> > >
> > >I think I'd like to handle timeout-sec being unspecified as an error at
> > >probe.  If someone explicitly sets timeout-sec = <0>, then they get what
> > >they ask for.  I'll take another look to see how to make this happen.
> > >
> > 
> > Hmm.. kind of unusual. Usual would be to initialize the timeout together
> > with min_timeout / max_timeout above and only force the user to specify
> > a value if the default timeout is not desirable. You don't really gain
> > anything by making timeout-sec mandatory.
> 
> Making timeout-sec mandatory makes it so I don't have to decide what a
> "sane default" is. :)
> 
Bad excuse ;-). You just force others to make the decision for you.

> It's even less clear about what a sane default is looking at the other
> watchdog drivers.  From the drivers I looked at, it ranges any where
> from 30s to 2mins.  Am I just to choose?  Why do these even differ
> between all of the drivers?
> 
Sanity is defined as the majority opinion, as expressed quite nicely in
"Everyone is insane but me".

Just pick something in between. If you don't want to make a decision, pick
30 seconds and blame it on me.

Maybe someone at some point finds a common ground. Until then it is per driver.

Thanks,
Guenter
