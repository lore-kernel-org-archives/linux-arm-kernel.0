From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 26 Jan 2015 11:16:45 +0100 (CET)
Subject: [PATCH RESEND v3 0/3] irqchip: vf610-mscm: add support for MSCM
 interrupt router
In-Reply-To: <1421309046-22452-1-git-send-email-stefan@agner.ch>
References: <1421309046-22452-1-git-send-email-stefan@agner.ch>
Message-ID: <alpine.DEB.2.11.1501261115300.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jan 2015, Stefan Agner wrote:

> Splitted out version of the MSCM driver. My first driver based on the
> routeable domain support and was part of the Vybrid Cortex-M4 support
> patchset.
> 
> So far the MSCM interrupt router was initialized by the boot loader
> and configured all interrupts for the Cortex-A5 CPU. There are two
> use cases where a proper driver is necessary:
> - To run Linux on the Cortex-M4. When the kernel is running on the
>   non-preconfigured CPU, the interrupt router need to be configured
>   properly.
> - To support deeper sleep modes: LPSTOP clears the interrupt router
>   configuration, hence a driver needs to restore the configuration
>   on resume.
> I created a seperate patchset for that driver which hopefully makes
> it easier to get it into mergeable state.
> 
> Since I identified some registers likely to be used by other drivers
> (e.g. CPU ID or the CPU Generate Interrupt Register) I also added
> the "syscon" compatible string to make the registers available for
> other drivers in case needed.
> 
> This resend version of this patchset is rebased on v3.19-rc4.

Has the discussion with Marc on the original V3 set been resolved?

What about the DT bindings? I'm relucant to pick that up w/o acks from
the DT folks.

Thanks,

	tglx
