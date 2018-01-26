From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 26 Jan 2018 11:20:26 +0200
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: Add a reserved-gpio-ranges
 property
In-Reply-To: <20180126011400.2191-2-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-2-sboyd@codeaurora.org>
Message-ID: <1516958426.7000.1272.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-25 at 17:13 -0800, Stephen Boyd wrote:
> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.
> Introduce a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.

>  	gpio-controller;
>  	#gpio-cells = <2>;
>  	ngpios = <18>;
> +	reserved-gpio-ranges = <0 4>, <12 2>;

What about preserving namespace, i.e.

gpio-reserved-ranges vs. your variant?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
