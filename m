From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 18 Oct 2012 13:58:02 -0700
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq and
 _od_resume_noirq
In-Reply-To: <20121018193440.GA8609@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Thu, 18 Oct 2012 22:34:40 +0300")
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
 <871ugvivso.fsf@deeprootsystems.com>
 <20121018165525.GA6385@arwen.pp.htv.fi>
 <87ipa7d6cy.fsf@deeprootsystems.com>
 <20121018175027.GA7917@arwen.pp.htv.fi>
 <87vce77hba.fsf@deeprootsystems.com>
 <20121018193440.GA8609@arwen.pp.htv.fi>
Message-ID: <87hapr4hwl.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

[...]

> ps: I'll continue reading the code and further test my series to see
> if I can understand what you say here.

OK.  And please get it working in cases where drivers are using I2C in
their suspend/resume (and even late/early) paths, and also where device
runtime PM is disabled from userspace.  All of that works with today's
code and will not work with your proposed code.

Kevin
