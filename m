From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 26 Nov 2014 11:53:45 -0800
Subject: [PATCHv1 0/6] rtc: rtc-isl12057: fixes and alarm support
In-Reply-To: <87y4qxwykq.fsf@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
 <874mtlyflf.fsf@natisbad.org> <54762096.7040200@kleine-koenig.org>
 <87y4qxwykq.fsf@natisbad.org>
Message-ID: <20141126115345.a3ef26c9fef0c388cbb6e6ee@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Nov 2014 20:28:53 +0100 arno at natisbad.org (Arnaud Ebalard) wrote:

> Hi,
> 
> Uwe Kleine-K__nig <uwe@kleine-koenig.org> writes:
> 
> > On 11/26/2014 07:35 PM, Arnaud Ebalard wrote:
> >> I wonder if you could take a look at this series I sent providing fixes
> >> (patches #1-5) and alarm support (patch #6) for ISL12057 RTC Chip. As
> >> all people do for RTC patches - due to lack of feedback from maintainer
> >> - I am looking for someone to review the patches (Mark, patch 6 has a
> >> sticker w/ regmap-inside ;-)) and then push those upstream if they are
> >> ok (Jason, you handled that part for 70e123373c05: "rtc: Add support for
> >> Intersil ISL12057 I2C RTC chip" in 2013 for the same reason).
> >> 
> >> Note that I addressed previous comments and feedback received from Uwe
> >> and also spent time to do some soldering in order to support and test
> >> the last patch for both my use case (Alarm IRQ signal not routed to the
> >> SoC on ReadyNAS RN102, RN104 and RN2120) and the common case.
> >> 
> >> Do not hesitate to ask if you want me to resend!
> > akpm already applied the series, doesn't he?
> 
> I am not really familiar w/ -mm tree workflow. It was not clear to me
> whether it was sitting in -mm tree waiting for reviewed-by and
> acked-by.

-mm is a collection of several hundred trees (most of which are empty
at a particular time).  The workflow depends on which tree we're
talking about!

For RTC patches I attempt to review them myself but I'm by no means an
expert on RTC, so I'm careful to cc various people who I think might
help with review and test.  Often people do this.  Generally when they
don't, the patches are sufficiently obvious for me to proceed under my
own steam.  If something breaks (this is rare), the number of people
who are affected is usually quite small and they tend to be system
developers who can fix it up for us anyway.
