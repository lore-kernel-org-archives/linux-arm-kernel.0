From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 01 Aug 2014 12:06:13 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <1406890899.2794.40.camel@linaro1.home>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
Message-ID: <1406891173.5747.63.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-01 at 12:01 +0100, Jon Medhurst (Tixy) wrote:
> > -->8
> > diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> > index 490f3dced749..f4c36e70166a 100644
> > --- a/arch/arm/common/bL_switcher.c
> > +++ b/arch/arm/common/bL_switcher.c
> > @@ -794,7 +794,7 @@ static int bL_switcher_hotplug_callback(struct 
> > notifier_block *nfb,
> >          return NOTIFY_DONE;
> >   }
> > 
> > -static bool no_bL_switcher;
> > +static bool no_bL_switcher = true;
> 
> This changes the default for everyone, which I guess is fair enough if
> there is a good reason, but I'm not sure there is.

I would vote for this change and argue that b.L switcher is "strange
enough" (ie. I know I've got 5 processors, so why do I see only 2?)
_not_ to have it enabled by default. I'd hope that a user looking for
this functionality will know how to turn it on.

Pawe?
