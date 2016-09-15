From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 12:02:55 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160915101741.GA21567@kroah.com>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <CAL_JsqJtDs-DrPDN4=9ET=EdEDTKxP-gRDkMziimQAz4LG457A@mail.gmail.com>
 <20160915101741.GA21567@kroah.com>
Message-ID: <1473937375.10230.52.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-15 at 12:17 +0200, Greg KH wrote:
> This
> > is the first I've heard of timesync having a binding. I can't
> imagine
> > why it needs one.
> 
> Ah, I'll let Bryan answer that one :)

It's possible we could drop the binding. It was needed to describe the
register location of the MMIO architectural register on MSM8994. I have
this binding ATM the describe fact that get_cycles() on MSM8994 returns
a free-running counter, clocked by refclk and that refclk is provided
to each processor that want to do FrameTime - i.e. the clock driving
get_cycles() comes from PMIC and drives the relevant PLLs on the
downstream processors clocking their respective TMR blocks.

static const struct of_device_id arch_timer_of_match[] = {
????????{ .compatible???= "google,greybus-frame-time-counter", },
????????{},
};

I'm not aware of a corresponding kernel API that describes the
frequency get_cycles() operates at but if there is one then there's no
need for this binding.
