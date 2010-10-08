From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 18:48:26 +0900
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for
	S/PDIF PCM audio
In-Reply-To: <AANLkTinPXcjHcaM1puzz00Sfhob9Y-X4HGDDVGMTqhH5@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
	<AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
	<AANLkTin4skx+aiL2FXwWO1ekKqT2YWDd3SM1H5WnGkhC@mail.gmail.com>
	<00c401cb6520$9484ef90$bd8eceb0$%kim@samsung.com>
	<AANLkTikf4CAWm49Q_AfcfiQDBQUVcE_BC-a_4F7d8xOz@mail.gmail.com>
	<AANLkTinPXcjHcaM1puzz00Sfhob9Y-X4HGDDVGMTqhH5@mail.gmail.com>
Message-ID: <001401cb66cd$fc49b990$f4dd2cb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seungwhan Youn wrote:

> 
> On Thu, Oct 7, 2010 at 10:33 AM, Seungwhan Youn <claude.youn@gmail.com>
> wrote:
> > Dear Maintainers,
> >
> >>> >> plat-samsung would probably be fine for that also - create a file called
> >>> >> common-smdk or something.  Some other things have gone for a plat-
> smdk
> >>> >> style approach too, though I'm not sure how tasteful I find that
> >>> >> personally.
> >>> > Even though I would personally like to have EPLL control for a device
> >>> > in machine specific manner as part of its driver, I accept your opinion.
> >>> >
> >>> > Claude, let us create one arch/arm/plat-samsung/smdk.c to do common
> >>> > stuff for SMKDs like EPLL control. What do you think ?
> >>>
> >>> Actually if we add this file on plat-samsung, board-init will be
> >>> separated two-part, one is machine(board) specific and other is all
> >>> smdk specific. So, If it doesn't make confusion to other guys who
> >>> wants to add settings for their features on board-init, it looks good
> >>> to me. But I think that we also have to listen Mr. Ben Dooks and Mr.
> >>> Kukjin Kim's opinion about this before we get a conclusion.
> >>
> >> Hi all,
> >>
> >> I think, basically it'd better if could control clock stuff in each driver for it when
> need it such as clk_get, clk_enable and so on.
> >> Actually there is no policy/protection for EPLL usage in plat-samsung or plat-
> s5p now and need to sort out other similar case for it also....so in my opinion, right
> now to proceed with the current style is helpful to me and will consider it in the
> future.
> >>
> >
> > I wander to know that this is a last discussion, or more, and also
> > know about finial decision. Of course, if we didn't get reached to the
> > conclusion, we can talk more.
> >
> > Can you give me a hand to finish this? :-)
> >
> 
> Dear Mr. Mark and Mr. Jassi,
> 
> Now, I'm almost finished 2nd patch for submit except this audio clock
> setting. For now, I can only think that remove audio clock setting

Hmm...so, maybe its working has problem...right?

> from this machine code, and add audio clock settings in arch later(may
> be after arch/arm/plat-samsung get EPLL policy as Mr. Kukjin said).
> 
I think, firstly put the clock stuff in the driver like your patch, and then if required, to move is better later.

> Is this okay?
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
