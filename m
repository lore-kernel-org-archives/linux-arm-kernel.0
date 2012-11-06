From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2012 09:45:25 +0000
Subject: scheduler clock for MXS
In-Reply-To: <5098CB9F.9030401@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
Message-ID: <20121106094525.GM28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> On 05.11.2012 23:28, Russell King - ARM Linux wrote:
> 
> > It most certainly does handle the wrapping correctly - it was designed
> > to from the very start.
> 
> I'm not an expert on Linux kernel and its core infrastructure,
> but how is the sched_clock_timer armed for the first time
> after calling setup_sched_clock?
> 
> The explicitely called update_sched_clock() does _not_ arm it.

Correct, but sched_clock_postinit() does, which is called from time_init().
