From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 11:33:13 -0600
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <52037F9A.7070802@roeck-us.net>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net> <52036920.4050808@nvidia.com>
 <52037F9A.7070802@roeck-us.net>
Message-ID: <5203D659.4050907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 05:23 AM, Guenter Roeck wrote:
> On 08/08/2013 02:47 AM, Wei Ni wrote:
...
>> I think get_regulator() will return error values, not only
>> -EPROBE_DEFER, so we should set data->lm90_reg to NULL to handle other
>> error values.
>>
> Matter of opinion if you want to check for IS_ERR or NULL later on.

No, if regulator returns either:

* Something valid
* Someting IS_ERR()

... then everywhere has to check the value using IS_ERR().

If regulator returns either:

* Something valid
* Someting NULL

... then everywhere has to check the value against NULL.

checking against both IS_ERR() and NULL shouldn't ever happen, and
likewise IS_ERR_OR_NULL() is deprecated.
