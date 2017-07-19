From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Jul 2017 10:35:20 -0500
Subject: [PATCH] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <20170719062220.wefnkqhd7javbcee@pengutronix.de>
References: <20170718214339.7774-1-robh@kernel.org>
 <20170719062220.wefnkqhd7javbcee@pengutronix.de>
Message-ID: <CAL_JsqK1Y3xhZwNxme934UF_t=6ZdSyqBtrMmceUC798ftL+mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 1:22 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jul 18, 2017 at 04:42:41PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>
> Oh nice. If the commit adding %pOF is already set in stone, i'd suggest
> to mention the commit id here in the commit log.

It is in 4.13, but I'm not really eager to update all 60 patches and
I'd prefer consistency in the commit msg as quite a few have already
been applied.

>> of the full path string for each node.

[...]

>> @@ -103,8 +103,8 @@ void __init arm_dt_init_cpu_maps(void)
>>                */
>>               cell = of_get_property(cpu, "reg", &prop_bytes);
>>               if (!cell || prop_bytes < sizeof(*cell)) {
>> -                     pr_debug(" * %s missing reg property\n",
>> -                                  cpu->full_name);
>> +                     pr_debug(" * %pOF missing reg property\n",
>> +                                  cpu);
>
> You could join lines here and in the next hunk. And there are two more
> further down.

Okay. I did that generally, but missed a few.

Rob
