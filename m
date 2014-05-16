From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 01:07:18 -0400
Subject: [PATCH v6 00/15] enable HiP04 SoC
In-Reply-To: <53748972.8040603@arm.com>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <14229972.j5k474Mq5Q@wuerfel>
 <CAD6h2NSpH0zxpek4KnUMT-p_DFnGZVaxP+x_0hsn1S8O6C7X6g@mail.gmail.com>
 <53748972.8040603@arm.com>
Message-ID: <20140516050718.GZ27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

On Thu, May 15, 2014 at 10:31:30AM +0100, Marc Zyngier wrote:
> On 15/05/14 10:20, Haojian Zhuang wrote:
> > On 15 May 2014 02:37, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Sunday 11 May 2014 16:05:56 Haojian Zhuang wrote:
> >>> Changelog:
> >>> v6:
> >>>   * Split HiP04 enabling patch into patches on document, mcpm & hiP04.
> >>>   * Move reset operation in HiP04 MCPM implementation.
> >>>   * Remove ARCH_MULTI_V7_NONLPAE & ARCH_MULTI_V7_LPAE according to olof's
> >>>     comment.
> >>
> >> The latest version looks good to me, at least if all the remaining
> >> comments for the mcpm implementation have been addressed.
> >>
> >> I would suggest to split the series into two, and submit all the gic
> >> related changes through Russell's patch tracker but have a pull
> >> request for the platform changes.
> >>
> >> As far as I can tell, there are no compile-time dependencies between
> >> the two, so we don't get a broken build during bisection, but
> >> of course the platform will only be usable if both parts are merged.
> >>
> >>         Arnd
> > 
> > Hi Arnd,
> > 
> > Thanks. I'll submit gic patches into Russell's patch tracker.
> 
> Please hold on on the GIC stuff, I still have comments on the main
> changes (I should have sent them earlier), and the KVM stuff is still
> quite wrong.

I've just started assisting Thomas with review / wrangling patches for
drivers/irqchip. If you could Cc me on the next revision, I'd appreciate
it.

thx,

Jason.
