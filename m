From: tommy.lin.1101@gmail.com (=?Big5?B?qkynu6Tl?=)
Date: Tue, 12 Jul 2011 14:57:38 +0800
Subject: [PATCH 1/2] arch: arm: Correct the dependency of HAVE_ARM_TWD
In-Reply-To: <20110708091713.GF2414@n2100.arm.linux.org.uk>
References: <1310104763-12948-1-git-send-email-tommy.lin@caviumnetworks.com>
	<20110708091014.GA15142@oksana.dev.rtsoft.ru>
	<20110708091713.GF2414@n2100.arm.linux.org.uk>
Message-ID: <CAB8eogcYUSYPBS9UAv29MqnTLdUrbYt+y=yLmzG0r92kz-PUXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/8 Russell King - ARM Linux <linux@arm.linux.org.uk>
>
> On Fri, Jul 08, 2011 at 01:10:14PM +0400, Anton Vorontsov wrote:
> > On Fri, Jul 08, 2011 at 01:59:23PM +0800, Tommy Lin wrote:
> > Russell,
> >
> > As the patch is needed for CNS3xxx Watchdog support, I'd like to take
> > it via CNS3xxx tree, if you're OK with that.
>
> No.
>
> TWD is only useful if SMP is enabled, otherwise the contained code
> won't be called.  Without SMP you'll find that the timer rate will
> be zero.
>
> So actually your problems are bigger than just this dependency.
I think LOCAL_TIMERS is the one that useful if SMP is enabled. The zero
timer rate issue still able to limited by LOCAL_TIMERS.
MPCore watchdog is rely on HAVE_ARM_TWD, but not related to SMP
at least in the current source. I have test the watchdog part without enable
SMP and watchdog works well except wrong reload value that can be fixed
by another patch.

--
Best Regards,
Tommy Lin
