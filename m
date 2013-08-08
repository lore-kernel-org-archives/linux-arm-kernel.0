From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 8 Aug 2013 10:59:18 -0700
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <5203D659.4050907@wwwdotorg.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com>
 <52037F9A.7070802@roeck-us.net> <5203D659.4050907@wwwdotorg.org>
Message-ID: <20130808175918.GA15013@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:33:13AM -0600, Stephen Warren wrote:
> On 08/08/2013 05:23 AM, Guenter Roeck wrote:
> > On 08/08/2013 02:47 AM, Wei Ni wrote:
> ...
> >> I think get_regulator() will return error values, not only
> >> -EPROBE_DEFER, so we should set data->lm90_reg to NULL to handle other
> >> error values.
> >>
> > Matter of opinion if you want to check for IS_ERR or NULL later on.
> 
> No, if regulator returns either:
> 
> * Something valid
> * Someting IS_ERR()
> 
> ... then everywhere has to check the value using IS_ERR().
> 
> If regulator returns either:
> 
> * Something valid
> * Someting NULL
> 
> ... then everywhere has to check the value against NULL.
> 
Other drivers calling get_regulator() don't check against NULL,
so it should not be needed here either.

Guenter

> checking against both IS_ERR() and NULL shouldn't ever happen, and
> likewise IS_ERR_OR_NULL() is deprecated.
> 
