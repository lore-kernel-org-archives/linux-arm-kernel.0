From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Apr 2015 14:37:04 +0100
Subject: irqchip heirarchy DT "break" series awareness?
In-Reply-To: <20150407130638.GE7873@io.lakedaemon.net>
References: <20150406144647.GC7873@io.lakedaemon.net>
 <20150407115922.5d4c6233@free-electrons.com>
 <5523AFAF.6040000@arm.com>
 <20150407130638.GE7873@io.lakedaemon.net>
Message-ID: <20150407133703.GF4394@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > If the relationship between the GIC and the shadow interrupt controllers
> > had been described, we would have avoided breaking the compatibility. I
> > guess it was too tempting to reuse pre-DT mechanisms and to forget about
> > this entirely.
> 
> I'm not sure tempting is the right word.  Everyone has known since this
> project began that we were striving to describe the hardware.  I suspect
> the reason we got to where we are is that people *assumed* the code was
> describing the hardware, and so wrote bindings reflecting their
> understanding.  iow, we don't have enough hardware engineers reviewing
> bindings :-P

FWIW when routable-irqs was introduced I negatively reviewed it, stating
that it was backwards, and that the crossbar driver should request the
appropriate domain dynamically [1]. We _knew_ it was wrong at the time,
but people decided to ignore that review because it was easier to do
things in a broken way.

A more general issue is that people hack in the minimal amount of DT
parsing code to an existing driver and rely on platform data and code to
do the heavy lifting, rather than doing a clean break with DT (which
would highlight deficiencies in the bndings). You end up with the worst
of both worlds, because you depend on both an incomplete DT and
implementation-specific platform data/code.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/211530.html
