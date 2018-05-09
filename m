From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 09 May 2018 17:06:43 +0100
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
Message-ID: <1525882003.4199.55.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-09 at 00:40 +0100, Kim Phillips wrote:
> On Fri,  4 May 2018 11:41:17 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> [adding Pawel, arm-ccn driver author]

We had this discussion way too many times for my liking. As I said
before - *I* will be fine with the debug messages in the CCN driver.
Now, if there ever turns out to be other user of this thing and gets
into problems with event configuration, I'd hope that he/she can count
on support from the knowledgable people here... (just checked and both
RHEL 7.5 and Ubuntu 16.04.3 kernels on AArch64 come with
CONFIG_DYNAMIC_DEBUG=y, so it's a matter of explaining what has to be
enabled where; sadly this information did not find its way into the
commit description)

> > The ARM CCN PMU driver uses dev_warn() to complain about parameters
> in
> > the user-provided perf_event_attr. This means that under normal
> > operation (e.g. a single invocation of the perf tool), dmesg may be
> > spammed with multiple messages.

Surely Mark, in his role as maintainer of drivers/perf/ (and a few
other locations), meant to use much more technical and emotion-free
subject, along the lines of "reduce a number of dmesg warnings at event
init".

Regards

Pawe?
