From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 09:39:44 +0100
Subject: [PATCH v2 3/3] arm64/efi: efistub: don't abort if base of DRAM
 is occupied
In-Reply-To: <540F577A.4040709@redhat.com>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140814113204.GE24018@leverpostej>
 <20140820171057.GG29733@console-pimps.org>
 <20140820173528.GH21734@leverpostej> <540F577A.4040709@redhat.com>
Message-ID: <20140910083944.GA28488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 08:39:38PM +0100, Jon Masters wrote:
> On 08/20/2014 01:35 PM, Mark Rutland wrote:
> > On Wed, Aug 20, 2014 at 06:10:57PM +0100, Matt Fleming wrote:
> >> On Thu, 14 Aug, at 12:32:05PM, Mark Rutland wrote:
> >>> On Wed, Jul 30, 2014 at 11:59:04AM +0100, Ard Biesheuvel wrote:
> >>>> If we cannot relocate the kernel Image to its preferred offset of base of DRAM
> >>>> plus TEXT_OFFSET, instead relocate it to the lowest available 2 MB boundary plus
> >>>> TEXT_OFFSET. We may lose a bit of memory at the low end, but we can still
> >>>> proceed normally otherwise.
> >>>>
> >>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>> Acked-by: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>>
> >>> Acked-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> >>
> >> Ard, who's picking this up?
> > 
> > Will's already taken this into arm64/devel [1,2] with the intention of
> > waiting for v3.18 [3]. Per Leif's comment [4] that might have to be
> > bumped.
> 
> So what's the plan with this series? Waiting for 3.18? The problem is
> that this patch series needs to be pulled for any platform with an EFI
> firmware located at DRAM base (e.g. AMD Seattle) as was noted before.

Yes, it's queued for 3.18 and should be in linux-next too. This isn't a
regression, so you'll just have to sit tight.

Will
