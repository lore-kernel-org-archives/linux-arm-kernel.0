From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 2 Oct 2009 10:46:03 +0200
Subject: [PATCH v2] Add cpuidle support for at91
In-Reply-To: <4AC35582.8000404@atmel.com>
References: <1247680190-19674-1-git-send-email-albin.tonnerre@free-electrons.com>
	<200908111200.58866.marc.pignat@hevs.ch>
	<20090812165700.GC4051@pc-ras4041.res.insa>
	<200908130858.47487.marc.pignat@hevs.ch>
	<20090813193241.GA5985@pc-ras4041.res.insa>
	<20090909151417.GA4014@pc-ras4041.res.insa>
	<4AC2168B.60903@atmel.com> <20090930123449.GB3238@laptop>
	<4AC35582.8000404@atmel.com>
Message-ID: <20091002084603.GA3179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> In other words, only state "wait-for-interrupt *and* RAM self refresh"
> brings some more power saving. Indeed, cpu_do_idle() that correspond to
> the "WFI" state was already the way of dealing with idle cpu, even
> without your patch. Am I correct ?

Yes, but it has a higher exit latency. Those data is provided to the cpuidle
framework, so it can decide which state to use.

I wonder if other people can confirm a similar amount of power savings? I am
trying to implement the RAM self refresh for i.MX and don't see much
improvment. I guess I still do something wrong...

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091002/4f2c5efa/attachment.sig>
