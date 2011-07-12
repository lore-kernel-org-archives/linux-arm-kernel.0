From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jul 2011 08:34:01 +0100
Subject: [PATCH 1/2] arch: arm: Correct the dependency of HAVE_ARM_TWD
In-Reply-To: <CAB8eogcYUSYPBS9UAv29MqnTLdUrbYt+y=yLmzG0r92kz-PUXA@mail.gmail.com>
References: <1310104763-12948-1-git-send-email-tommy.lin@caviumnetworks.com>
	<20110708091014.GA15142@oksana.dev.rtsoft.ru>
	<20110708091713.GF2414@n2100.arm.linux.org.uk>
	<CAB8eogcYUSYPBS9UAv29MqnTLdUrbYt+y=yLmzG0r92kz-PUXA@mail.gmail.com>
Message-ID: <20110712073401.GB23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 02:57:38PM +0800, ??? wrote:
> 2011/7/8 Russell King - ARM Linux <linux@arm.linux.org.uk>
> >
> > On Fri, Jul 08, 2011 at 01:10:14PM +0400, Anton Vorontsov wrote:
> > > On Fri, Jul 08, 2011 at 01:59:23PM +0800, Tommy Lin wrote:
> > > Russell,
> > >
> > > As the patch is needed for CNS3xxx Watchdog support, I'd like to take
> > > it via CNS3xxx tree, if you're OK with that.
> >
> > No.
> >
> > TWD is only useful if SMP is enabled, otherwise the contained code
> > won't be called.  Without SMP you'll find that the timer rate will
> > be zero.
> >
> > So actually your problems are bigger than just this dependency.
>
> I think LOCAL_TIMERS is the one that useful if SMP is enabled. The zero
> timer rate issue still able to limited by LOCAL_TIMERS.

No.  I could repeat everything I've said about the initialization but
there's no point.  I'm not dropping the SMP dependency of SMP_TWD.
