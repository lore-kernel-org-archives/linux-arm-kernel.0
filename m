From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 May 2018 17:12:42 +0100
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <1525882003.4199.55.camel@arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
 <1525882003.4199.55.camel@arm.com>
Message-ID: <20180509161120.ilnukvismwfb452g@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:06:43PM +0100, Pawel Moll wrote:
> On Wed, 2018-05-09 at 00:40 +0100, Kim Phillips wrote:
> > On Fri,  4 May 2018 11:41:17 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > [adding Pawel, arm-ccn driver author]
> 
> We had this discussion way too many times for my liking. As I said
> before - *I* will be fine with the debug messages in the CCN driver.

> > > The ARM CCN PMU driver uses dev_warn() to complain about parameters
> > in
> > > the user-provided perf_event_attr. This means that under normal
> > > operation (e.g. a single invocation of the perf tool), dmesg may be
> > > spammed with multiple messages.
> 
> Surely Mark, in his role as maintainer of drivers/perf/ (and a few
> other locations), meant to use much more technical and emotion-free
> subject, along the lines of "reduce a number of dmesg warnings at event
> init".

True. I'll reword the above to:

  The ARM CCN PMU driver uses dev_warn() to complain about parameters in
  the user-provided perf_event_attr. This means that under normal
  operation (e.g. a single invocation of the perf tool), a number of
  messages warnings may be logged to dmesg.

... with that, can I take your ack?

Thanks,
Mark.
