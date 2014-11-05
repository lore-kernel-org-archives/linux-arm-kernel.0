From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 4 Nov 2014 17:33:53 -0800
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <7h4mul9ttl.fsf@deeprootsystems.com>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <3981560.mBph1QJkfl@vostro.rjw.lan>
 <7h4mul9ttl.fsf@deeprootsystems.com>
Message-ID: <20141105013353.GA19238@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
> >> Convert the prototype to return and int. This is just an initial step,
> >> needed to support error handling.
> >> 
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> >> 
> >> This patch is intended as fix for 3.18 rc[n]. Why?
> >> 
> >> There are other SOC specific patches around that adds genpd support and which
> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
> >> during the next release cycle, let's change the prototype now instead.
> >> 
> >> Further patches will add the actual error handling in genpd and these can then
> >> be reviewed and tested thoroughly.
> >
> > So we have no users of ->attach_dev at the moment, right?
> 
> Not in mainline, but there are a couple getting ready to hit -next, so
> we wanted to fix this before they arrive so that adding the error
> handling will be easier.

BTW, while we are at it, can we also pass the domain itself to
attach_dev() and detach_dev()? If anything it helps with debugging (you
can print domain name from the callbacks).

Thanks.

-- 
Dmitry
