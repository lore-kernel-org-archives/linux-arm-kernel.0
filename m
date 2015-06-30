From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Jun 2015 10:04:44 +0100
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <CAL5wTH4wBF5e8T4Tqy1aWWAgVsM9Z-yv5mu2YrTZCg2pyW5Pog@mail.gmail.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>
 <20150629100304.GB18931@leverpostej>
 <CAL5wTH4wBF5e8T4Tqy1aWWAgVsM9Z-yv5mu2YrTZCg2pyW5Pog@mail.gmail.com>
Message-ID: <20150630090443.GA3550@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 08:46:28AM +0100, Dirk M?ller wrote:
> Hi Mark,
> 
> > I've seen issues with prior FW versions where the ethernet controller
> > was erroneously left active after ExitBootServices(), and would DMA
> > braodcast packets over the kernel. That resulted in similar failures to
> > what you're reporting.
> >
> > Can you reproduce the issue with all ethernet cables unplugged?
> 
> not with ethernet cables unplugged, but I did ifdown on all interfaces
> and was able to trigger the issue just fine. Please note it is 100%
> reproducible in one sequence each and every time, which imho makes it
> unlikely to be a DMA scatter issue.

I see; agreed.

> > You can also try enabling CONFIG_MEMTEST (and pass memtest on the
> > command line) at boot time, which may happen to catch DMA in the act.
> 
> Did not try this.

Given the above it sounds like it wouldn't help anyway ;)

Sorry for the noise!

Mark.
