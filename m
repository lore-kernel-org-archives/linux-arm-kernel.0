From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 30 Oct 2014 13:38:30 -0700
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <3981560.mBph1QJkfl@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Thu, 30 Oct 2014 21:04:15 +0100")
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <3981560.mBph1QJkfl@vostro.rjw.lan>
Message-ID: <7h4mul9ttl.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
>> Convert the prototype to return and int. This is just an initial step,
>> needed to support error handling.
>> 
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

>> 
>> This patch is intended as fix for 3.18 rc[n]. Why?
>> 
>> There are other SOC specific patches around that adds genpd support and which
>> implements the ->attach_dev() callback. To prevent having an "atomic" patch
>> during the next release cycle, let's change the prototype now instead.
>> 
>> Further patches will add the actual error handling in genpd and these can then
>> be reviewed and tested thoroughly.
>
> So we have no users of ->attach_dev at the moment, right?

Not in mainline, but there are a couple getting ready to hit -next, so
we wanted to fix this before they arrive so that adding the error
handling will be easier.

Kevin
