From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 14 Jul 2012 20:31:55 +0200
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <CACxGe6tXvz+rt2yrHHaD=j94-=JQEh06sHW0FWGiHb2=9GS2pA@mail.gmail.com>
References: <5000175E.4070702@gmail.com>
 <CACxGe6tXvz+rt2yrHHaD=j94-=JQEh06sHW0FWGiHb2=9GS2pA@mail.gmail.com>
Message-ID: <20120714183155.GP592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

On Fri, Jul 13, 2012 at 01:36:59PM -0600, Grant Likely wrote:
> On Fri, Jul 13, 2012 at 6:41 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 07/13/2012 07:32 AM, y at pengutronix.de wrote:
> >> this series' goal is to make struct of_device_id.data const.
> >> Conceptually a driver must not modify the data contained there so making
> >> it const is the right thing.
> >>
> >> This change might introduce warnings because drivers don't use const to
> >> access the data pointed to by of_device_id.data. In most cases the fix
> >> is to add some consts.
> >>
> >> This series (apart from adding this const in patch 10) fixes all drivers
> >> covered by all arm defconfigs (based on v3.5-rc6).
> >>
> >
> > What about other arches?
> 
> This whole series is of questionable value to me.  While I agree that
> .data should be const, I don't think changing it has is measurably
> better than what we have now.  Particularly when the series isn't
> complete for all users.  And "building all defconfigs" is not the
> right way to look for affected users.
As it's not really bad if a user isn't fixed (it only introduces a
compiler warning) I think not being 100% sure to have fixed all of them
is OK. I plan to check the defconfigs and an allyes build on powerpc and
look over the patch that Arnd sent. IMHO this is enough to go on.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
