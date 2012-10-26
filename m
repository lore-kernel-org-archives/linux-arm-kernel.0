From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 26 Oct 2012 14:18:35 +0530
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpokEXAGD-nUF6u8tugvF2ffJx3HLLd+Zgc2+6GB9hxnT6Q@mail.gmail.com>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
 <CAKohpokEXAGD-nUF6u8tugvF2ffJx3HLLd+Zgc2+6GB9hxnT6Q@mail.gmail.com>
Message-ID: <1351241315.7077.16.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-26 at 14:25 +0530, Viresh Kumar wrote:
> Hi Vinod,
> 
> On 16 October 2012 09:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > dw_dmac driver already supports device tree but it used to have its platform
> > data passed the non-DT way.
> >
> > This patch does following changes:
> > - pass platform data via DT, non-DT way still takes precedence if both are used.
> > - create generic filter routine
> > - Earlier slave information was made available by slave specific filter routines
> >   in chan->private field. Now, this information would be passed from within dmac
> >   DT node. Slave drivers would now be required to pass bus_id (a string) as
> >   parameter to this generic filter(), which would be compared against the slave
> >   data passed from DT, by the generic filter routine.
> > - Update binding document
> 
> I can see that you applied these patches and they are present in
> linux-next. But i feel
> the order of patches is bad.
Yes looks like I forgot to sort the mbox series :(

since all patches were applied nicely, and they seem fairly independent
of each other it should cause issue. Let me know if you wnat me to redo
my -next.

-- 
Vinod Koul
Intel Corp.
