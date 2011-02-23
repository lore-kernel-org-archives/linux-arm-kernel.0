From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 23 Feb 2011 15:35:07 +0530
Subject: [PATCH 0/3] OMAP2+ hwmod fixes
In-Reply-To: <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
	<4D5BCC10.2060301@ti.com>
	<6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com>
	<4D5E85EA.70605@ti.com>
	<alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
	<e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com>
	<alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com>
Message-ID: <19850e063c924a8a30c69ac02621a659@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Wednesday, February 23, 2011 12:40 AM
> To: Rajendra Nayak; Cousson, Benoit
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
>
> Hi Rajendra
>
> On Tue, 22 Feb 2011, Rajendra Nayak wrote:
>
> > The original behavior of the iterators, to terminate upon
> > encountering an error, seems fine to me. The only problem
> > I faced was that they fail silently and go undetected, unless
> > their user catches the return value and WARN's, which I found
> > was not the case with most users, mainly those of
> > omap_hwmod_for_each_by_class.
> > I was thinking of keeping the behaviour of these iterators
> > same for now and add WARN's in these iterators itself upon
> > an error, so its seen even if the user fails to catch it.
>
> What's your opinion on adding the pr_err() or WARN() into the code that
> the iterator calls for each hwmod?  That code should know why something
> fails, so it should be able to provide a more detailed error message.
Of
> course, it is not as general a solution...

I agree, if the callback functions are written with proper errors
or WARN's, they are the right place where most of the details'
exist. So maybe we don't need these in the iterator's after all.

Regards,
Rajendra

>
>
> - Paul
