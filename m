From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 12 Jun 2013 02:15:45 +0200
Subject: [PATCH 3/6] ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled
 platforms
In-Reply-To: <CAOesGMgjnt+T1OEFy15J0-zkHwHyeo3XLyzTGqmozq-t0nm=GQ@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <20130611074552.GK6688@quad.lixom.net>
 <CAOesGMgjnt+T1OEFy15J0-zkHwHyeo3XLyzTGqmozq-t0nm=GQ@mail.gmail.com>
Message-ID: <1904605.joOAnPJ6dR@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tuesday 11 of June 2013 01:21:59 Olof Johansson wrote:
> On Tue, Jun 11, 2013 at 12:45 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, Jun 10, 2013 at 06:13:10PM +0200, Linus Walleij wrote:
> >> On Mon, Jun 10, 2013 at 4:45 PM, Tomasz Figa <t.figa@samsung.com> 
wrote:
> >> > On Friday 17 of May 2013 18:24:29 Tomasz Figa wrote:
> >> >> This patch makes legacy code on suspend/resume path being executed
> >> >> conditionally, on non-DT platforms only, to fix suspend/resume of
> >> >> DT-enabled systems, for which the code is inappropriate.
> >> >> 
> >> >> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> >> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> >> ---
> >> >> 
> >> >>  arch/arm/plat-samsung/pm.c | 17 ++++++++++++-----
> >> >>  1 file changed, 12 insertions(+), 5 deletions(-)
> >> > 
> >> > It seems like this patch did not make it into 3.10-rc5, while rest
> >> > of patches did, which ended up with suspend/resume still being
> >> > broken.
> >> > 
> >> > What should we do in this case?
> >> 
> >> I did not apply this patch to the pinctrl tree because it begins
> >> with ARM: but it appears I promised to carry it anyway...
> >> 
> >> I need an ACK from the ARM SoC people to do that though,
> >> or you can take it through ARM SoC fixes directly.
> >> 
> >> I would just ask Olof/Arnd to apply it directly as a separate
> >> patch.
> > 
> > It makes sense to take this through arm-soc since it's no longer
> > dependent on anything else.
> > 
> > Applied to fixes. 

Thanks.

> > Please do follow through with the promised cleanups
> > at some point, Tomasz. :-)

Yeah, just managed to reserve some time for it, so stay tuned ;) .

> 
> Btw, I had to add an include of <linux/of.h> or else all non-DT builds
> broke...

Sorry, I must have missed it.

I guess it's the right time to set up some autobuild framework to check 
all patches with several most interesting configs. I guess some git hooks 
would be enough...

Best regards,
Tomasz

> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
