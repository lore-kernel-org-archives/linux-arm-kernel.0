From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 09 Nov 2013 13:34:31 +0100
Subject: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
In-Reply-To: <20131108060803.GF9828@verge.net.au>
References: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoRDo6_VYhaq9KkSCo2TnhmwW-vFK99HuBS=umrC1_fD_g@mail.gmail.com>
 <20131108060803.GF9828@verge.net.au>
Message-ID: <9547447.Oq0RhNMWv3@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Friday 08 November 2013 15:08:05 Simon Horman wrote:
> On Thu, Nov 07, 2013 at 03:04:57PM +0900, Magnus Damm wrote:
> > On Thu, Nov 7, 2013 at 8:54 AM, Laurent Pinchart wrote:
> > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
> > > been created to group all multiplatform-enabled SH-Mobile SoCs. The
> > > existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
> > > been converted yet.
> > > 
> > > This arrangement works fine for the arch/ code, but lots of drivers
> > > needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
> > > ARCH_SHMOBILE only. In order to avoid changing them, rename
> > > ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
> > > ARCH_SHMOBILE configuration symbol that is selected by both
> > > ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Thanks, this looks good to me.
> > 
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> This seems reasonable to me.
> I would pick it up now but it is marked as "RFC".
> Please let me know if you wish me to pick it up.

I've sent a non-RFC series, please pick that one up.

> > I have one semi-related question below:
> > > @@ -1619,7 +1621,7 @@ config HZ_FIXED
> > > 
> > >         default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
> > >         
> > >                 ARCH_S5PV210 || ARCH_EXYNOS4
> > >         
> > >         default AT91_TIMER_HZ if ARCH_AT91
> > > 
> > > -       default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
> > > +       default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE_LEGACY
> > > 
> > >         default 0
> > >  
> > >  choice
> > 
> > For the hunk above, it makes sense that we cannot HZ in the
> > multiplatform case, so I think your patch is right.
> > 
> > I do however wonder what's the plan with multiplatform and the HZ
> > value, how do we handle hardware platforms that use 32768 Hz as clock?
> > Historically those platforms work best with a
> > even-divide-by-a-power-of-two HZ value, so with a HZ=100 value things
> > may drift slowly...

-- 
Regards,

Laurent Pinchart
