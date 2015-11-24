From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 24 Nov 2015 10:05:40 -0800
Subject: [PATCH v9 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <564EF013.4030809@sigmadesigns.com> (Marc Gonzalez's message of
 "Fri, 20 Nov 2015 11:04:03 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C9558.4020100@sigmadesigns.com>
 <7hwptdu5vv.fsf@deeprootsystems.com>
 <564EF013.4030809@sigmadesigns.com>
Message-ID: <7hegffp91n.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 19/11/2015 20:49, Kevin Hilman wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> +static void tango_l2c_write(unsigned long val, unsigned int reg)
>>> +{
>>> +	pr_debug("%s: reg=0x%x val=0x%lx\n", __func__, reg, val);
>> 
>> leftover debugging aid?
>
> I'll remove it.
>
> (For my education, we're not supposed to use any pr_debug calls?)

pr_debug() are fine to leave if you want them, but I assumed it was just
a leftover as it didn't seem generally useful.

>>> +ENTRY(tango_smc)
>>> +	push	{lr}
>>> +	mov	ip, r1
>>> +	dsb	/* This barrier is probably unnecessary */
>> 
>> Then remove it?
>
> This was discussed in v8. It's probably cargo cult from OMAP,
> but the performance hit is negligible, and I don't have time
> to properly analyze the code path. I just wanted to add the
> comment in case someone copied my code.

Sure,

Kevin
