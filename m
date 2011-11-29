From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Tue, 29 Nov 2011 20:29:38 +0530
Subject: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
In-Reply-To: <1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
 <87pqh3qvkt.fsf@ti.com> <1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
Message-ID: <a480ee86d60a9db484d3baa0faf2477f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

> -----Original Message-----
> From: Vishwanath Sripathy [mailto:vishwanath.bs at ti.com]
> Sent: Tuesday, November 29, 2011 4:53 PM
> To: Kevin Hilman
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
> support via hwmod mux
>
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman at ti.com]
> > Sent: Tuesday, November 08, 2011 6:28 AM
> > To: Vishwanath BS
> > Cc: linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> > Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
> > support via hwmod mux
> >
> > Hi Vishwa,
> >
> > Vishwanath BS <vishwanath.bs@ti.com> writes:
> >
> > > The folowing patch series provides IO Daisychain feature via
> omap
> > hwmod mux
> > > framework.
> >
> > The series looks OK at first glance, but needs a refresh against
> > current
> > mainline.
> OK.
> >
> > Can you refresh this against Tony's 'fixes' branch and re-test.
> >
> > I tested this on OMAP3430/n900 and noticed that it no longer hit
> off
> > mode from idle.
> >
> > IOW, If I enable UART timeouts and then enable off mode, I don't
> > actually ever hit off during idle.  However, if I do a
> > suspend/resume I
> > see it hits off mode, then subsequent attempts to hit off during
> > idle work.
> >
> > Can you investigate this?
> OK. Let me check that.
I rebased these patches against latest Tony's fixes branch and tested it
on OMAP3430 SDP. I see that Core enters off mode in idle path after
setting UART timeout w/o having to suspend the system.

Is there anything else I need to do to see the issue mentioned by you?

Regards
Vishwa
>
> Regards
> Vishwa
> >
> > Kevin
