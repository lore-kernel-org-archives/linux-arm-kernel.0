From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 May 2015 11:14:02 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <555AFBFD.3010506@aksignal.cz>
References: <55559D55.6020703@aksignal.cz> <20150515172516.005e3a21@bbrezillon>
 <5559865F.9010502@aksignal.cz> <20150518092750.449d6c8c@bbrezillon>
 <5559A029.9060007@aksignal.cz> <555AA8F1.80100@atmel.com>
 <20150519091442.675b1a98@bbrezillon> <555AFBFD.3010506@aksignal.cz>
Message-ID: <20150519111402.747e8eb2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015 11:01:49 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> 
> 
> On 19.5.2015 09:14, Boris Brezillon wrote:
> > On Tue, 19 May 2015 11:07:29 +0800
> > "Yang, Wenyou" <wenyou.yang@atmel.com> wrote:
> >
> >>
> >>
> >> On 2015/5/18 16:17, Ji?? Prchal wrote:
> >>>
> >>>
> >>> On 18.5.2015 09:27, Boris Brezillon wrote:
> >>>>
> >>>> Can you dump watchdog registers (using devmem) ?
> >>>
> >>> / # devmem 0xfffffe40
> >>> 0x00000000
> >>> / # devmem 0xfffffe44
> >>> 0x1FFF2FFF
> >>> / # devmem 0xfffffe48
> >>> 0x00000000
> >>>
> >> The register value is right.
> >
> > It seems correct to me too.
> >
> Not to me, I want 4s:
> [    4.675675] at91sam9_wdt: enabled (heartbeat=4 sec, nowayout=1)

There's a difference between your heartbeat (the frequency you
refresh/reset your watchdog) and the watchdog expiration time (here set
to 16 secs).
We usually set the heartbeat to 1/2 or 1/4 the expiration time, so that
we're (almost) sure we can reset the watchdog before its expiration.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
