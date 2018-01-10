From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 10 Jan 2018 14:54:21 +0200
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <20180110015848.11480-3-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-3-sboyd@codeaurora.org>
Message-ID: <1515588861.7000.842.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-01-09 at 17:58 -0800, Stephen Boyd wrote:
> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.
> Introduce a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.
 
> +- ngpios-ranges:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: Tuples of GPIO ranges (base, size) indicating
> +		    GPIOs available for use.

Can be name more particular?

We have on one hand gpio-range-list for mapping, on the other this one
might become generic.

So, there are few options (at least?) to consider:
1) re-use gpio-ranges
2) add a valid property to gpio-ranges
3) rename ngpios-ranges to something like gpio-valid-ranges (I don't
like it so much either, but for me it looks more descriptive than
ngpios-ranges)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
