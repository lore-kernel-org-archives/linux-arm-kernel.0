From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Aug 2013 21:55:51 -0600
Subject: [RFC PATCH 1/3] pinctrl: add new generic pinconf config for
 deglitch filter
In-Reply-To: <521B89D1.6010902@overkiz.com>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380109-11247-1-git-send-email-b.brezillon@overkiz.com>
 <521B875E.1010605@wwwdotorg.org> <521B89D1.6010902@overkiz.com>
Message-ID: <521C2347.4080702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2013 11:01 AM, boris brezillon wrote:
> Hello Stephen,
> 
> On 26/08/2013 18:50, Stephen Warren wrote:
>> On 08/24/2013 03:35 PM, Boris BREZILLON wrote:
>>> Add a new parameter to support deglitch filter configuration.
>>> A deglitch filter works like a debounce filter but with a smaller
>>> delay (nanoseconds).
>> Why not use the existing debounce property, just with a small delay
>> specified. It seems like that's exactly what the property is for?
> That's one of the question I asked in my cover letter :-)
> 
> Indeed the at91 deglitch filter delay is not configurable and is statically
> assigned to half a master clk cycle (if master clk = 133MHz -> 8 ns).
> The debounce property argument is currently expressed in usecs.
> 
> This will result in always selecting the debounce filter (which is also
> available on at91 SoCs) over the deglitch filter.
> 
> Could we add a flag in the deglitch argument to specify the delay unit
> (nsecs or usecs) ?

If the value is hard-coded in HW, why not use non-zero (or 1) to enable
and zero to disable?

(this kind of thing is why I'm not convinced that generic pinconf works
so well... What if we need psecs in the future?)
