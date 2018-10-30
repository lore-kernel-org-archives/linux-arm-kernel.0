From: kurt.kanzenbach@linutronix.de (Kurt Kanzenbach)
Date: Tue, 30 Oct 2018 14:47:04 +0100
Subject: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
In-Reply-To: <20181030120831.GC27873@lunn.ch>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030120831.GC27873@lunn.ch>
Message-ID: <20181030134704.l673d7pm5mwysx2o@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Oct 30, 2018 at 01:08:31PM +0100, Andrew Lunn wrote:
> On Tue, Oct 30, 2018 at 10:31:37AM +0100, Kurt Kanzenbach wrote:
> > Hi,
> >
> > the Xilinx mdio wait functions may return false positives under certain
> > circumstances: If the functions get preempted between reading the corresponding
> > mdio register and checking for the timeout, they could falsely indicate a
> > timeout.
>
> Hi Kurt
>
> I wonder if it would be possible to add a readx_poll_timeout() which
> passes two parameters to op()?

actually I was thinking about using readx_poll_timeout(). But as you
already pointed out, it expects only one parameter for op(). I'm not
sure about adding a new readx_poll_timeout() macro.

>
> I keep seeing this basic problem in various drivers, and try to point
> people towards readx_poll_timeout(), but it is not the best of fit.
>
> Otherwise, could you add a axienet_ior_read_mcr(lp), and use
> readx_poll_timeout() as is?

I guess that would work.

I'll use readx_poll_timeout() for both wait functions and send a v2.

Thanks,
Kurt
