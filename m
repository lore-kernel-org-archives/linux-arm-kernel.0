From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon, 17 Dec 2012 23:03:04 +0100
Subject: [PATCH 2/2] cpufreq: db8500: set CPUFREQ_CONST_LOOPS
In-Reply-To: <50CF634F.1040708@codeaurora.org>
References: <1354615845-2758-1-git-send-email-fabio.baltieri@linaro.org>
 <1354615845-2758-3-git-send-email-fabio.baltieri@linaro.org>
 <50CF634F.1040708@codeaurora.org>
Message-ID: <20121217220304.GB16231@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 10:24:15AM -0800, Stephen Boyd wrote:
> On 12/04/12 02:10, Fabio Baltieri wrote:
> >  static struct cpufreq_driver db8500_cpufreq_driver = {
> > -	.flags  = CPUFREQ_STICKY,
> > +	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
> 
> Wouldn't you want to fold this into the previous patch so bisection is
> not broken? Otherwise you have a place where lpj is all screwed up when
> cpufreq mucks with it.

You are basically right... but that's not going to be as screwed up as
it's now, so I'd say that it's not worth the rebase unless the
maintainer says so. :-)

Thanks!
Fabio

-- 
Fabio Baltieri
