From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jan 2014 09:48:43 -0700
Subject: DT include files
In-Reply-To: <20140110170319.GC20094@book.gsilab.sittig.org>
References: <20140102202108.GF19720@quad.lixom.net>
 <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
 <20140103030455.GB25079@S2101-09.ap.freescale.net>
 <CAOesGMihX-pLva-aBCHJ6TYfsN57MzRWiYFTnfKCXOKeja0uUg@mail.gmail.com>
 <20140104011056.GA3282@S2101-09.ap.freescale.net>
 <20140110024124.GA6844@S2101-09.ap.freescale.net>
 <CAOesGMh3HBCYut2hfub3svrJT5JJzoWq8mU=VU0grZbg-JqqbA@mail.gmail.com>
 <52CFF57D.8060808@samsung.com>
 <CAL_JsqKHr6v+6kNXrAdnzH0gpoFCPAjPSnX8iBDgRSMh9JgxvA@mail.gmail.com>
 <20140110170319.GC20094@book.gsilab.sittig.org>
Message-ID: <52D418EB.1040605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 10:03 AM, Gerhard Sittig wrote:
> On Fri, Jan 10, 2014 at 09:30 -0600, Rob Herring wrote:
>>
>> As for *.h vs. *.dtsi naming, if the include is only pre-processor
>> defines, then I think using .h is the right way. Otherwise, if there
>> is any dts syntax, then .dtsi is the right name. It looks to me like
>> this style has been followed in both the imx and s3c64xx cases.
>>
>> On a side note, I'm not really a fan of this pattern:
>>
>> #define FOO1 1 2 3
>>
>> #define BAR FOO1 FOO2 FOO3
>>
>> While it definitely simplifies the dts files, it would never be used
>> in C and obfuscates what the actual property size is. Reading a dts
>> file, I would naturally assume the define was a single value while in
>> fact it could expand to a very large property size.
> 
> For more complex yet tedious repetitive cases like GPIO banks and
> pins I've seen #define directives which introduce "functions"
> (macros with parameters).  They appear to be rather useful, can
> reflect very well the essence of the information, don't
> necessarily pretend to be single values, but still may hide how
> many cells they expand to.  For example:
> 
>   arch/arm/boot/dts/tegra30-cardhu.dtsi:
>     interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;

I'm not sure I entirely understand your point, but for the record, both
TEGRA_GPIO() and IRQ_TYPE_LEVEL_HIGH expand to a single cell, as I would
expect (almost?) any DT macro to do.
