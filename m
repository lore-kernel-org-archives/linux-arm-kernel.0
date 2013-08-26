From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 26 Aug 2013 19:01:05 +0200
Subject: [RFC PATCH 1/3] pinctrl: add new generic pinconf config for
 deglitch filter
In-Reply-To: <521B875E.1010605@wwwdotorg.org>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
 <521B875E.1010605@wwwdotorg.org>
Message-ID: <521B89D1.6010902@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On 26/08/2013 18:50, Stephen Warren wrote:
> On 08/24/2013 03:35 PM, Boris BREZILLON wrote:
>> Add a new parameter to support deglitch filter configuration.
>> A deglitch filter works like a debounce filter but with a smaller
>> delay (nanoseconds).
> Why not use the existing debounce property, just with a small delay
> specified. It seems like that's exactly what the property is for?
That's one of the question I asked in my cover letter :-)

Indeed the at91 deglitch filter delay is not configurable and is statically
assigned to half a master clk cycle (if master clk = 133MHz -> 8 ns).
The debounce property argument is currently expressed in usecs.

This will result in always selecting the debounce filter (which is also
available on at91 SoCs) over the deglitch filter.

Could we add a flag in the deglitch argument to specify the delay unit
(nsecs or usecs) ?


Best Regards,

Boris
