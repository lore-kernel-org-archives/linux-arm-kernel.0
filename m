From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 23:25:13 +0100
Subject: [PATCH 1/9] lpc2k: Core support
In-Reply-To: <083DF309106F364B939360100EC290F80B15AC2B3A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-2-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15AC2B3A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300400713.2138.108.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 23:08 +0100, Kevin Wells wrote:
[...]
> > +static void arch_idle(void)
> > +{
> > +	cpu_do_idle();
> > +}
> 
> The 24xx devices have a CPU idle down register (PCON) that will suspend
> the CPU clock until the next interrupt. *pcon = 1;

Yes, I know, but was planning on introducing that together with
suspend/resume in a next patch series. I've had it in locally already
but got some interrupt disable/enable errors during exit of idle mode
that need further investigation.

> > +
> > +static inline void arch_reset(char mode, const char *cmd)
> > +{
> > +	cpu_reset(0);
> > +}
> 
> The entire system can be reset via RESETOUT using the watchdog timer.

Again, was planning that for the patch set that will introduce the
watchdog driver.

Regards,

Ithamar.
