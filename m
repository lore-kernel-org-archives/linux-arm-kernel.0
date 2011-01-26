From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 26 Jan 2011 13:25:42 +0530
Subject: [PATCH 1/5] ARM: gic: Add hooks for architecture specific
	extensions
In-Reply-To: <AANLkTikVixQTGMMsh2uteEoV_xRgizAqkZ0Kf7Ggejya@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com><1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com><AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com><AANLkTi=umZYcb2MozjjLhjjRD305t8iKw2jNr3Ke=9H7@mail.gmail.com><d33cd73f8207d4b92d02eb4bd2629590@mail.gmail.com><AANLkTi=-JYqKW0abCZKDzVjM0DkYF+LMOXDa1R+HrJ2i@mail.gmail.com><ef807d5fb389a19b2bd046f5fc6d203b@mail.gmail.com>
	<AANLkTikVixQTGMMsh2uteEoV_xRgizAqkZ0Kf7Ggejya@mail.gmail.com>
Message-ID: <c190a51b336e6b61951231bd875a44dd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: ccross at google.com [mailto:ccross at google.com] On Behalf Of
> Colin Cross
> Sent: Wednesday, January 26, 2011 1:23 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; catalin.marinas at arm.com;
> linux at arm.linux.org.uk; linus.ml.walleij at gmail.com; Russell King
> Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture
> specific extensions
>
> On Tue, Jan 25, 2011 at 11:31 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: ccross at google.com [mailto:ccross at google.com] On Behalf Of
> >> Colin Cross
> >> Sent: Wednesday, January 26, 2011 12:54 PM
> >> To: Santosh Shilimkar
> >> Cc: linux-arm-kernel at lists.infradead.org; linux-
> >> omap at vger.kernel.org; catalin.marinas at arm.com;
> >> linux at arm.linux.org.uk; linus.ml.walleij at gmail.com; Russell King
> >> Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture
> >> specific extensions
> >>
> > [....]
> >
> >> >>
> >> > Great.
> >> > Can I fold below changes in my patch and add you ack and
> tested-
> >> by?
> >>
> >> Sure
> >
> > After reading your initial comment, you mentioned you need to have
> > 'gic_set_type' as well. Is this still true. If yes then we need to
> > have arch_extn call for that as well.
>
> You are right, I missed adding the extension for gic_set_type.  My
> testing doesn't cover that case right now, because I don't have any
> drivers updated to linux-next that use a wake source that is
> compatible with Tegra's lowest power suspend mode, and that is the
> only time the extension to gic_set_type is necessary.
>
Ok.
So I will go ahead and add an extension for the same so that we have
most of the usecases covered.

Regards,
Santosh
