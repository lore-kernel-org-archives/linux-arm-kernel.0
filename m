From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Sep 2009 14:56:34 +0200
Subject: [PATCH v2] Add cpuidle support for at91
In-Reply-To: <20090930123449.GB3238@laptop>
References: <1247680190-19674-1-git-send-email-albin.tonnerre@free-electrons.com>
	<200908111200.58866.marc.pignat@hevs.ch>
	<20090812165700.GC4051@pc-ras4041.res.insa>
	<200908130858.47487.marc.pignat@hevs.ch>
	<20090813193241.GA5985@pc-ras4041.res.insa>
	<20090909151417.GA4014@pc-ras4041.res.insa>
	<4AC2168B.60903@atmel.com> <20090930123449.GB3238@laptop>
Message-ID: <4AC35582.8000404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Albin Tonnerre :
 >> Just one precision: what is the difference, entering state0 with only
>> the current cpu_do_idle() that is activated by default ?
> 
> Sorry, I don't get what you mean. Would you mind elaborating a bit?

I guess that during idle time, even without the cpuidle infrastructure,
the SOC enters arch_idle() that calls cpu_do_idle().

So, now that I have your patch applied, I wonder what is the difference
between the old situation and the first state of the cpuidle table.

In other words, only state "wait-for-interrupt *and* RAM self refresh"
brings some more power saving. Indeed, cpu_do_idle() that correspond to
the "WFI" state was already the way of dealing with idle cpu, even
without your patch. Am I correct ?

Best regards,
-- 
Nicolas Ferre
